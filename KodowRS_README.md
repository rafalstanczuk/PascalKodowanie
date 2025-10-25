# KodowRS v1.0 - File Encoding/Decoding Utility

## 🎯 **Historical Context**

This is the **first version** of my early programming work from 2003, representing the very beginning of my coding journey. This simple file encoding utility demonstrates basic Pascal programming concepts and serves as the foundation for subsequent versions.

## Overview

KodowRS v1.0 is a file encoding/decoding utility originally written in Borland Pascal by Rafał Stańczuk in 2003. This repository contains a reconstructed Pascal source code based on disassembly analysis of the original executable.

## Original Program Information

- **Original Author:** Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
- **Original Date:** June 3, 2003
- **Original Compiler:** Borland Pascal 7.0
- **Original Size:** 8,016 bytes
- **Platform:** MS-DOS

## Reconstructed Source Files

### 1. KodowRS.pas
Basic reconstruction with core functionality:
- File encoding/decoding
- Password protection
- Menu-driven interface
- Simple character-based encryption

### 2. KodowRS_Detailed.pas
Detailed reconstruction based on assembly analysis:
- Assembly-accurate control flow
- Specific string handling
- Iteration limits (92 iterations)
- Memory management patterns

## Features

### Core Functionality
- **File Encoding:** Encrypt text files with password protection
- **File Decoding:** Decrypt previously encoded files
- **Password Protection:** Access code validation
- **Menu Interface:** Simple text-based menu system

### User Interface (Polish)
- Welcome message with author information
- Menu options for encoding/decoding
- File path input prompts
- Access code validation
- Error handling and user feedback

### Encryption Algorithm
- Simple character-based encoding
- Key-based transformation
- Reversible encoding/decoding
- Support for text files

## Compilation

### Prerequisites
- Free Pascal Compiler (fpc) or GNU Pascal Compiler (gpc)

### Installation
```bash
# Ubuntu/Debian
sudo apt install fpc

# Fedora
sudo dnf install fpc

# Arch Linux
sudo pacman -S fpc
```

### Compilation
```bash
# Make compilation script executable
chmod +x compile_kodowrs.sh

# Run compilation
./compile_kodowrs.sh
```

### Manual Compilation
```bash
# Basic version
fpc -o KodowRS KodowRS.pas

# Detailed version
fpc -o KodowRS_Detailed KodowRS_Detailed.pas
```

## Usage

### Running the Program
```bash
# Basic version
./KodowRS

# Detailed version (assembly-accurate)
./KodowRS_Detailed
```

### Menu Options
1. **Decode File** - Decrypt an encoded file
2. **Encode File** - Encrypt a text file
3. **Exit** - Quit the program

### File Operations
- Input file selection with full path
- Output file specification
- Access code (password) verification
- File existence validation

## Technical Details

### Assembly Analysis
The reconstruction is based on detailed disassembly of the original executable:

- **Entry Point:** Offset 0x400
- **Main Loop:** Up to 92 iterations
- **String Operations:** Borland Pascal runtime calls
- **File I/O:** Standard DOS file handling
- **Memory Management:** Stack-based operations

### Key Assembly Patterns
- Function prologues with stack management
- String manipulation routines
- File operation calls
- Menu system logic
- Error handling jumps

### Runtime Library
- Borland Pascal 7.0 runtime
- DOS file operations
- String handling functions
- Memory management routines

## File Structure

```
Jurassic/
├── KodowRS.pas              # Basic reconstruction
├── KodowRS_Detailed.pas     # Assembly-accurate reconstruction
├── compile_kodowrs.sh       # Compilation script
├── KodowRS_README.md        # This documentation
├── kodowrs_analysis.txt     # String analysis
└── kodowrs_disassembly.txt  # Assembly disassembly
```

## Limitations

### Original Program
- **Platform:** MS-DOS only
- **Character Support:** No Polish character interpretation
- **File Types:** Text files only
- **Encryption:** Simple character-based algorithm

### Reconstructed Version
- **Compatibility:** Modern Pascal compilers
- **Platform:** Cross-platform (Linux, Windows, macOS)
- **Improvements:** Better error handling
- **Documentation:** Comprehensive source comments

## Security Note

⚠️ **Warning:** This is a simple encoding utility, not a secure encryption system. The algorithm is basic and should not be used for sensitive data protection.

## Historical Context

This program represents early 2000s Pascal programming practices:
- DOS-based applications
- Simple file encryption
- Menu-driven interfaces
- Character-based algorithms
- Borland Pascal development

## Author Information

**Original Author:** Rafał Stańczuk
- Email: stanczuk.rafal@gmail.com (old contact rafalsrs@wp.pl)
- Website: https://github.com/rafalstanczuk
- Date: June 3, 2003

**Reconstruction:** Based on disassembly analysis of the original executable, preserving the original functionality and user interface while adapting for modern Pascal compilers.

## License

This reconstruction is provided for educational and historical purposes. The original program was created by Rafał Stańczuk in 2003.
