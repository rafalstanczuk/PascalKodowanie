#!/bin/bash

# Kodowrs3 Compilation Script
# Reconstructed Pascal source compilation for Version 3.0

echo "Kodowrs3 v3.0 - File Encoding/Decoding Utility"
echo "Compilation script for reconstructed Pascal source"
echo "=================================================="

# Check if Free Pascal is available
if command -v fpc &> /dev/null; then
    echo "Using Free Pascal Compiler (fpc)..."
    
    # Compile the basic version
    echo "Compiling Kodowrs3.pas..."
    fpc -o Kodowrs3 Kodowrs3.pas
    
    # Compile the detailed version
    echo "Compiling Kodowrs3_Detailed.pas..."
    fpc -o Kodowrs3_Detailed Kodowrs3_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- Kodowrs3 (Basic version)"
    echo "- Kodowrs3_Detailed (Assembly-accurate version)"
    
elif command -v gpc &> /dev/null; then
    echo "Using GNU Pascal Compiler (gpc)..."
    
    # Compile the basic version
    echo "Compiling Kodowrs3.pas..."
    gpc -o Kodowrs3 Kodowrs3.pas
    
    # Compile the detailed version
    echo "Compiling Kodowrs3_Detailed.pas..."
    gpc -o Kodowrs3_Detailed Kodowrs3_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- Kodowrs3 (Basic version)"
    echo "- Kodowrs3_Detailed (Assembly-accurate version)"
    
else
    echo "No Pascal compiler found!"
    echo "Please install Free Pascal (fpc) or GNU Pascal (gpc)"
    echo ""
    echo "Ubuntu/Debian: sudo apt install fpc"
    echo "Fedora: sudo dnf install fpc"
    echo "Arch: sudo pacman -S fpc"
fi

echo ""
echo "Usage:"
echo "./Kodowrs3 - Basic version with enhanced features"
echo "./Kodowrs3_Detailed - Detailed version with assembly-accurate logic"
echo ""
echo "Version 3.0 Features:"
echo "- Enhanced encoding algorithm"
echo "- Better error handling with multiple attempts"
echo "- Progress indication during file processing"
echo "- Improved input validation"
echo "- Program information menu"
echo "- Version information display"
