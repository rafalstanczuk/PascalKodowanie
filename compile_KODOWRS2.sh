#!/bin/bash

# KODOWRS2 Compilation Script
# Reconstructed Pascal source compilation for Version 2.0

echo "KODOWRS2 v2.0 - File Encoding/Decoding Utility"
echo "Compilation script for reconstructed Pascal source"
echo "=================================================="

# Check if Free Pascal is available
if command -v fpc &> /dev/null; then
    echo "Using Free Pascal Compiler (fpc)..."
    
    # Compile the basic version
    echo "Compiling KODOWRS2.pas..."
    fpc -o KODOWRS2 KODOWRS2.pas
    
    # Compile the detailed version
    echo "Compiling KODOWRS2_Detailed.pas..."
    fpc -o KODOWRS2_Detailed KODOWRS2_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- KODOWRS2 (Basic version)"
    echo "- KODOWRS2_Detailed (Assembly-accurate version)"
    
elif command -v gpc &> /dev/null; then
    echo "Using GNU Pascal Compiler (gpc)..."
    
    # Compile the basic version
    echo "Compiling KODOWRS2.pas..."
    gpc -o KODOWRS2 KODOWRS2.pas
    
    # Compile the detailed version
    echo "Compiling KODOWRS2_Detailed.pas..."
    gpc -o KODOWRS2_Detailed KODOWRS2_Detailed.pas
    
    echo "Compilation completed!"
    echo "Executables created:"
    echo "- KODOWRS2 (Basic version)"
    echo "- KODOWRS2_Detailed (Assembly-accurate version)"
    
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
echo "./KODOWRS2 - Basic version with binary encoding"
echo "./KODOWRS2_Detailed - Detailed version with assembly-accurate logic"
echo ""
echo "Version 2.0 Features:"
echo "- Binary-based encoding algorithm"
echo "- Pattern matching system"
echo "- Enhanced security with binary transformations"
echo "- Same user interface as original"
echo "- Binary pattern recognition"
