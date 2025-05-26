# bash64
# README.md content
readme_content = """# Bash Base64 Encoder/Decoder

A simple and interactive Bash script for encoding and decoding text using Base64.

## 📦 Features

- ✅ Encode from terminal, file, or clipboard (paste)
- ✅ Decode Base64 input
- ✅ Auto shows output after Ctrl+D (once)
- ✅ Helpful flags and instructions

## 🚀 Usage

```bash
chmod +x base64.sh
./base64.sh -e        # Encode text (type or paste, then Ctrl+D)
./base64.sh -d        # Decode Base64 (paste or type, then Ctrl+D)
./base64.sh -e -i input.txt -o encoded.txt
./base64.sh -d -i encoded.txt -o decoded.txt
