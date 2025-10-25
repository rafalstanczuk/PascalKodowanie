# Kodowrs3 v3.0 - File Encoding/Decoding Utility

## 🎯 **Historical Context**

This is the **third and final version** of my early programming work from 2003, representing a focus on user experience and enhanced features. This version demonstrates my understanding of user interface design, error handling, and program information display.

## Overview

Kodowrs3 v3.0 is version 3.0 of the file encoding/decoding utility originally written in Borland Pascal by Rafał Stańczuk in 2003. This repository contains a reconstructed Pascal source code based on disassembly analysis of the original executable, with enhanced features and improvements.

## Original Program Information

- **Original Author:** Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
- **Original Date:** June 3, 2003, 22:28:14
- **Version:** 3.0 (1 minute after KodowRS.exe)
- **Original Compiler:** Borland Pascal 7.0
- **Original Size:** 8,016 bytes
- **Platform:** MS-DOS

## Version 3.0 Enhancements

### New Features
- **Version Information Display:** Shows program version and creation date
- **Program Information Menu:** Detailed feature description
- **Enhanced Error Handling:** Multiple attempts for access code validation
- **Progress Indication:** Visual feedback during file processing
- **Improved Input Validation:** Better character validation and warnings
- **Enhanced Encoding Algorithm:** Better key distribution and security

### Improvements Over KodowRS.exe
1. **Better User Experience:**
   - Version information display
   - Progress indicators
   - Multiple attempt validation
   - Enhanced error messages

2. **Enhanced Security:**
   - Improved encoding algorithm
   - Better key distribution
   - Minimum password length validation
   - Common password warnings

3. **Better Error Handling:**
   - 3 attempts for access code validation
   - More descriptive error messages
   - Input length validation
   - File existence checks

## Reconstructed Source Files

### 1. Kodowrs3.pas
Enhanced reconstruction with version 3.0 features:
- Version information display
- Program information menu
- Enhanced encoding algorithm
- Multiple attempt validation
- Progress indication
- Improved error handling

### 2. Kodowrs3_Detailed.pas
Detailed reconstruction based on assembly analysis:
- Assembly-accurate control flow
- Enhanced string handling
- Version-specific features
- Memory management patterns
- Detailed progress tracking

## Features

### Core Functionality
- **File Encoding:** Enhanced encryption with better key distribution
- **File Decoding:** Improved decryption algorithm
- **Password Protection:** Multi-attempt validation with warnings
- **Menu Interface:** Enhanced text-based menu system
- **Version Information:** Program version and creation date display

### User Interface (Polish)
- Welcome message with version information
- Enhanced menu options including program info
- File path input prompts with validation
- Access code validation with multiple attempts
- Progress indication during file processing
- Enhanced error handling and user feedback

### Enhanced Encryption Algorithm
- **Key Distribution:** Better key sum calculation
- **Character Encoding:** Improved character transformation
- **Security:** Enhanced password validation
- **Reversibility:** Maintains encoding/decoding compatibility

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
chmod +x compile_kodowrs3.sh

# Run compilation
./compile_kodowrs3.sh
```

### Manual Compilation
```bash
# Basic version
fpc -o Kodowrs3 Kodowrs3.pas

# Detailed version
fpc -o Kodowrs3_Detailed Kodowrs3_Detailed.pas
```

## Usage

### Running the Program
```bash
# Basic version
./Kodowrs3

# Detailed version (assembly-accurate)
./Kodowrs3_Detailed
```

### Menu Options
1. **Decode File** - Decrypt an encoded file
2. **Encode File** - Encrypt a text file
3. **Program Information** - Show detailed feature information
4. **Exit** - Quit the program

### File Operations
- Input file selection with full path
- Output file specification
- Access code (password) verification with 3 attempts
- File existence validation
- Progress indication during processing

## Technical Details

### Assembly Analysis
The reconstruction is based on detailed disassembly analysis:

- **Entry Point:** Offset 0x400 (similar to KodowRS.exe)
- **Main Loop:** Up to 92 iterations
- **String Operations:** Enhanced Borland Pascal runtime calls
- **File I/O:** Improved DOS file handling
- **Memory Management:** Enhanced stack-based operations

### Version 3.0 Specific Features
- **Version Display:** Program version and creation date
- **Enhanced Validation:** Multiple attempt system
- **Progress Tracking:** Character count and progress dots
- **Improved Algorithms:** Better key distribution
- **Error Handling:** More robust error management

### Key Assembly Patterns
- Function prologues with enhanced stack management
- String manipulation routines with validation
- File operation calls with progress tracking
- Menu system logic with additional options
- Enhanced error handling with multiple attempts

## File Structure

```
Jurassic/
├── Kodowrs3.pas              # Basic reconstruction v3.0
├── Kodowrs3_Detailed.pas     # Assembly-accurate reconstruction v3.0
├── compile_kodowrs3.sh       # Compilation script
├── Kodowrs3_README.md        # This documentation
└── Kodowrs3_analysis.txt     # Analysis and reconstruction notes
```

## Version Comparison

### KodowRS.exe vs Kodowrs3.exe
| Feature | KodowRS.exe | Kodowrs3.exe |
|---------|-------------|--------------|
| Version | 1.0 | 3.0 |
| Access Attempts | 1 | 3 |
| Progress Indication | No | Yes |
| Version Display | No | Yes |
| Program Info Menu | No | Yes |
| Input Validation | Basic | Enhanced |
| Error Messages | Basic | Detailed |
| Encoding Algorithm | Simple | Enhanced |

## Limitations

### Original Program
- **Platform:** MS-DOS only
- **Character Support:** No Polish character interpretation
- **File Types:** Text files only
- **Encryption:** Enhanced but still basic character-based algorithm

### Reconstructed Version
- **Compatibility:** Modern Pascal compilers
- **Platform:** Cross-platform (Linux, Windows, macOS)
- **Improvements:** Enhanced error handling and user experience
- **Documentation:** Comprehensive source comments

## Security Note

⚠️ **Warning:** This is an enhanced but still simple encoding utility, not a secure encryption system. The algorithm is improved but should not be used for sensitive data protection.

## Historical Context

This program represents the evolution of early 2000s Pascal programming:
- **Version 1.0 (KodowRS.exe):** Basic functionality
- **Version 3.0 (Kodowrs3.exe):** Enhanced features and user experience
- **Development Timeline:** 1 minute between versions (rapid iteration)
- **Programming Style:** Borland Pascal with DOS focus

## Author Information

**Original Author:** Rafał Stańczuk
- Email: stanczuk.rafal@gmail.com (old contact rafalsrs@wp.pl)
- Website: https://github.com/rafalstanczuk
- Date: June 3, 2003, 22:28:14
- Version: 3.0

**Reconstruction:** Based on disassembly analysis of the original executable, preserving the original functionality while enhancing it for modern Pascal compilers and improved user experience.

## License

This reconstruction is provided for educational and historical purposes. The original program was created by Rafał Stańczuk in 2003.
