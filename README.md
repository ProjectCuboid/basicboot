<div align="center">

![Logo](assets/logo.svg)

![kernelbadge](https://img.shields.io/badge/kernel-blue?style=for-the-badge&logo=c&logoColor=%23ffffff)
![opensource](https://img.shields.io/badge/opensource-green?style=for-the-badge&logo=opensourceinitiative&logoColor=%23ffffff&color=%236CC24A)
![release](https://img.shields.io/badge/2.1.1-beta-red?style=for-the-badge&logo=github)
![qemu](https://img.shields.io/badge/qemu-black?style=for-the-badge&logo=qemu)
![vbox](https://img.shields.io/badge/oracle%20virtualbox-yellow?style=for-the-badge&logo=virtualbox)

**A minimal operating system kernel built from scratch**

[Features](#features) • [Quick Start](#quick-start) • [Requirements](#requirements) • [Installation](#installation)

---

</div>

## ✨ Features

- **Low-level system programming** — Direct hardware interaction via assembly and C
- **Custom bootloader** — Built with NASM for x86 architecture

## 🚀 Quick Start
```bash
# Build the kernel
make

# Run in QEMU
make run

# Clean build artifacts
make clean
```

## 📦 Requirements

Ensure these tools are installed before building:

| Tool | Purpose |
|------|---------|
| **🪐 nasm** | Assembler for boot sector and kernel code |
| **💽 i686-linux-musl-gcc** | Cross-compiler targeting 32-bit x86 |
| **🔗 i686-linux-musl-ld** | Linker for creating kernel binary |

> **Note:** The cross-compiler and linker may be replaced with alternatives depending on your toolchain (for example, to i386 toolchain).

## 📩 Installation

### Installing NASM

**Arch Linux:**
```bash
sudo pacman -S nasm
```

**Ubuntu:*** 
```bash
sudo apt install nasm
```

### Installing Toolchain

1. Download the cross-compiler:
```bash
wget https://musl.cc/i686-linux-musl-cross.tgz
tar xf i686-linux-musl-cross.tgz
```

2. Add to PATH:

**ZSH:**
```bash
echo 'export PATH="$HOME/i686-linux-musl-cross/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**BASH:***
```bash
echo 'export PATH="$HOME/i686-linux-musl-cross/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Verify Installation
```bash
# Check NASM
nasm -v

# Check cross-compiler
i686-linux-musl-gcc --version

# Check linker
i686-linux-musl-ld --version
```

### Using in VirtualBox
```bash
VBoxManage convertfromraw os.img os.vdi --format VDI
```
Then create a new VM in VirtualBox and attach `os.vdi` as a virtual hard disk. ( Settings > Storage > Add Hard Disk, select `os.vdi`, delete the existing virtual disk if any. )
### ⚠️ Important

**\*** — Untested software/commands

> This project was developed and tested on EndeavourOS (Arch Linux) with zsh shell.

---

<div align="center">
Made with curiosity
</div>
