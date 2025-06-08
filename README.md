# 🔐 gpg-tools 



## Description

`gpg-tools` is a simple Bash script that allows users to utilize encryption and decryption functionalities provided by GnuPG (GPG). The interface is console-based and supports both public-key and symmetric (password-based) encryption.

### ✨ Features

- Create a new GPG key
- List keys
- Import a key from file or keyserver
- Encrypt a file using a public key
- Encrypt a file with password
- Encrypt a text message using key or password
- Decrypt encrypted files and text messages

### 🛠️ Requirements

- Linux system (or WSL on Windows)
- Bash
- GnuPG (gpg)
- `nano` (for editing text messages)

### 🧪 Usage
Unpack and navigate to this repository

Add execute permission:
```bash
 chmod +x gpg-tools.sh
```

Run the script:

```bash
 ./gpg-tools.sh
```

Follow the on-screen instructions.

### 📂 Directory Structure

A folder named `tmp_files` is created to store temporary text messages – it gets automatically cleared after decryption or encryption text messages.
