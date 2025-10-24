#!/bin/bash

# KodowRS Compilation Script
# Reconstructed Pascal source compilation

echo "KodowRS - File Encoding/Decoding Utility"
echo "Compilation script for reconstructed Pascal source"
echo "================================================"

# Check if Free Pascal is available
if command -v fpc &> /dev/null; then
    echo "Using Free Pascal Compiler (fpc)..."
    
    # Compile the basic version
    echo "Compiling KodowRS.pas..."
    fpc -o KodowRS KodowRS.pas
    
    # Compile the detailed version
    echo "Compiling KodowRS_Detailed.pas..."
    fpc -o KodowRS_Detailed KodowRS_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- KodowRS"
    echo "- KodowRS_Detailed"
    
elif command -v gpc &> /dev/null; then
    echo "Using GNU Pascal Compiler (gpc)..."
    
    # Compile the basic version
    echo "Compiling KodowRS.pas..."
    gpc -o KodowRS KodowRS.pas
    
    # Compile the detailed version
    echo "Compiling KodowRS_Detailed.pas..."
    gpc -o KodowRS_Detailed KodowRS_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- KodowRS"
    echo "- KodowRS_Detailed"
    
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
echo "./KodowRS - Basic version"
echo "./KodowRS_Detailed - Detailed version with assembly-accurate logic"
