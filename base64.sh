#!/usr/bin/env bash

# Check for minimum bash version 4
if ((BASH_VERSINFO[0] < 4)); then
  echo "❌ Error: This script requires Bash version 4 or later."
  echo "Your Bash version is ${BASH_VERSION}"
  exit 1
fi

# Function: Display help message
show_help() {
  cat << EOF
Usage: $0 [-e | -d] [-i input_file] [-o output_file]

Options:
  -e            Encode input to Base64
  -d            Decode Base64 input
  -i FILE       Input file (optional; if omitted, reads from terminal)
  -o FILE       Output file (optional; defaults to screen)
  -h            Show this help message

Examples:
  $0 -e                  # Encode typed/pasted input (Ctrl+D to finish)
  $0 -d                  # Decode Base64 input (Ctrl+D to finish)
  $0 -e -i file.txt      # Encode from file
  $0 -d -i file.txt      # Decode from file
EOF
  exit 0
}

# Initialize flags and variables
encode=0
decode=0
input=""
output=""

# Parse command-line options
while getopts "edi:o:h" opt; do
  case $opt in
    e) encode=1 ;;
    d) decode=1 ;;
    i) input="$OPTARG" ;;
    o) output="$OPTARG" ;;
    h) show_help ;;
    *) show_help ;;
  esac
done

# Validate options
if [[ $encode -eq 1 && $decode -eq 1 ]]; then
  echo "❌ Error: Choose only one -e (encode) or -d (decode)."
  exit 1
elif [[ $encode -eq 0 && $decode -eq 0 ]]; then
  echo "❌ Error: You must specify -e or -d."
  exit 1
fi

# Set base64 command
b64cmd="base64"
[[ $decode -eq 1 ]] && b64cmd="base64 -d"

# Handle input
if [[ -n "$input" ]]; then
  # Input file mode
  if [[ ! -f "$input" ]]; then
    echo "❌ Error: File '$input' not found."
    exit 1
  fi
  result=$($b64cmd < "$input" 2>&1)
else
  # Read from terminal (stdin)
  echo "📝 Paste or type your text (Ctrl+D to finish):"
  result=$(cat | $b64cmd 2>&1)
fi

# Output result
if [[ -n "$output" ]]; then
  echo "$result" > "$output"
else
  echo -e "\n--> output:"
  echo "$result"
fi
