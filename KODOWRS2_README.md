# KODOWRS2 v2.0 - File Encoding/Decoding Utility

## 🎯 **Historical Context**

This is the **second version** of my early programming work from 2003, representing a significant step in algorithm complexity. This version demonstrates my exploration of binary operations and pattern matching, showing the evolution from simple character shifting to more sophisticated encoding methods.

## Overview

KODOWRS2 v2.0 is version 2.0 of the file encoding/decoding utility originally written in Borland Pascal by Rafał Stańczuk in 2003. This version implements a binary-based encoding algorithm with enhanced security features and pattern matching capabilities.

## Original Program Information

- **Original Author:** Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
- **Original Date:** June 3, 2003
- **Version:** 2.0
- **Original Compiler:** Borland Pascal 7.0
- **Original Size:** 8,576 bytes (560 bytes larger than KodowRS.exe)
- **Platform:** MS-DOS

## Version 2.0 Key Features

### Binary-Based Encoding Algorithm
- **Binary Pattern Matching:** Uses predefined binary patterns (00000000 to 01011111)
- **Character-to-Binary Conversion:** Converts characters to 8-bit binary representation
- **Pattern Transformation:** Applies key-based transformations to binary patterns
- **Enhanced Security:** More complex than simple character shifting

### Technical Improvements
1. **Binary Processing:**
   - Character to binary conversion
   - Binary pattern matching
   - Key-based binary transformation
   - Binary to character conversion

2. **Enhanced Security:**
   - Binary pattern recognition
   - Complex key distribution
   - Multi-layer encoding
   - Pattern-based encryption

3. **Algorithm Complexity:**
   - 96 binary patterns (0-95)
   - Key sum calculations
   - Bit manipulation
   - Pattern matching system

## Reconstructed Source Files

### 1. KODOWRS2.pas
Basic reconstruction with binary encoding:
- Binary character conversion
- Pattern-based encoding algorithm
- Key-based binary transformation
- Same user interface as original
- Enhanced security features

### 2. KODOWRS2_Detailed.pas
Detailed reconstruction based on assembly analysis:
- Assembly-accurate binary processing
- Pattern matching system
- Enhanced binary transformations
- Memory management patterns
- Detailed progress tracking

## Features

### Core Functionality
- **Binary Encoding:** Character-to-binary conversion with pattern matching
- **Binary Decoding:** Reverse binary-to-character conversion
- **Pattern Recognition:** Uses 96 predefined binary patterns
- **Key-Based Security:** Enhanced key distribution algorithm
- **Menu Interface:** Identical text-based menu system

### Binary Algorithm Details
- **Pattern Range:** 00000000 to 01011111 (0-95 in binary)
- **Character Processing:** ASCII to binary conversion
- **Key Transformation:** Key sum-based pattern modification
- **Bit Manipulation:** Individual bit transformation
- **Pattern Matching:** Predefined binary pattern recognition

### User Interface (Polish)
- Welcome message with author information
- Menu options for encoding/decoding
- File path input prompts
- Access code validation
- Progress indication during processing
- Error handling and user feedback

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
chmod +x compile_KODOWRS2.sh

# Run compilation
./compile_KODOWRS2.sh
```

### Manual Compilation
```bash
# Basic version
fpc -o KODOWRS2 KODOWRS2.pas

# Detailed version
fpc -o KODOWRS2_Detailed KODOWRS2_Detailed.pas
```

## Usage

### Running the Program
```bash
# Basic version
./KODOWRS2

# Detailed version (assembly-accurate)
./KODOWRS2_Detailed
```

### Menu Options
1. **Decode File** - Decrypt an encoded file using binary algorithm
2. **Encode File** - Encrypt a text file using binary algorithm
3. **Exit** - Quit the program

### File Operations
- Input file selection with full path
- Output file specification
- Access code (password) verification
- File existence validation
- Progress indication during processing

## Technical Details

### Binary Algorithm Implementation
The encoding algorithm works as follows:

1. **Character Input:** Read character from file
2. **Binary Conversion:** Convert to 8-bit binary string
3. **Pattern Matching:** Use predefined binary patterns
4. **Key Transformation:** Apply key-based modifications
5. **Bit Manipulation:** Transform individual bits
6. **Character Output:** Convert back to character

### Assembly Analysis
The reconstruction is based on detailed disassembly analysis:

- **Entry Point:** Offset 0x400 (similar to other versions)
- **Binary Patterns:** 96 predefined patterns in data section
- **String Operations:** Enhanced Borland Pascal runtime calls
- **File I/O:** Standard DOS file handling
- **Memory Management:** Binary pattern storage

### Key Assembly Patterns
- Function prologues with binary processing
- String manipulation routines with pattern matching
- File operation calls with binary encoding
- Menu system logic with binary algorithm
- Enhanced error handling with pattern validation

## File Structure

```
kod_rs/kod_rs/
├── KODOWRS2.EXE              # Original executable (8,576 bytes)
├── KODOWRS2.pas              # Basic reconstruction v2.0
├── KODOWRS2_Detailed.pas     # Assembly-accurate reconstruction v2.0
├── compile_KODOWRS2.sh       # Compilation script
├── KODOWRS2_README.md        # This documentation
└── KODOWRS2_analysis.txt     # Analysis and reconstruction notes
```

## Version Comparison

### KodowRS.exe vs KODOWRS2.exe
| Feature | KodowRS.exe | KODOWRS2.exe |
|---------|-------------|--------------|
| **Version** | 1.0 | 2.0 |
| **File Size** | 8,016 bytes | 8,576 bytes |
| **Encoding Algorithm** | Simple character shifting | Binary pattern matching |
| **Security Level** | Basic | Enhanced |
| **Pattern Recognition** | No | Yes (96 patterns) |
| **Binary Processing** | No | Yes |
| **Key Distribution** | Simple | Complex |

## Limitations

### Original Program
- **Platform:** MS-DOS only
- **Character Support:** No Polish character interpretation
- **File Types:** Text files only
- **Encryption:** Binary-based but still basic algorithm

### Reconstructed Version
- **Compatibility:** Modern Pascal compilers
- **Platform:** Cross-platform (Linux, Windows, macOS)
- **Improvements:** Enhanced binary processing and documentation
- **Documentation:** Comprehensive source comments

## Security Note

⚠️ **Warning:** This is an enhanced but still basic encoding utility, not a secure encryption system. The binary algorithm is more complex but should not be used for sensitive data protection.

## Historical Context

This program represents the evolution of early 2000s Pascal programming:
- **Version 1.0 (KodowRS.exe):** Basic character shifting
- **Version 2.0 (KODOWRS2.exe):** Binary pattern matching
- **Version 3.0 (Kodowrs3.exe):** Enhanced features and user experience
- **Development Timeline:** Rapid iteration with algorithm improvements

## Author Information

**Original Author:** Rafał Stańczuk
- Email: stanczuk.rafal@gmail.com (old contact rafalsrs@wp.pl)
- Website: https://github.com/rafalstanczuk
- Date: June 3, 2003
- Version: 2.0

**Reconstruction:** Based on disassembly analysis of the original executable, preserving the original binary encoding functionality while adapting for modern Pascal compilers.

## License

This reconstruction is provided for educational and historical purposes. The original program was created by Rafał Stańczuk in 2003.
