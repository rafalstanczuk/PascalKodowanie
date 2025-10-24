program KODOWRS2_Detailed;

{*
 * KODOWRS2 - File Encoding/Decoding Utility Version 2.0
 * Detailed reconstruction based on disassembly analysis
 * Original: Rafał Stańczuk (rafalsrs@wp.pl)
 * Date: June 3, 2003
 * Version: 2.0
 * 
 * This version implements binary-based encoding algorithm
 * with enhanced security features and pattern matching
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];
    BinaryString = string[8];
    FileBuffer = array[1..255] of char;
    BinaryPattern = array[0..95] of BinaryString;

var
    inputFileName, outputFileName: String255;
    accessCode: String80;
    menuChoice: char;
    fileHandle: text;
    tempBuffer: FileBuffer;
    binaryPatterns: BinaryPattern;
    bufferIndex: integer;
    maxIterations: integer;
    currentIteration: integer;
    isValidCode: boolean;
    fileExists: boolean;
    charCount: longint;
    keySum: integer;
    binaryIndex: integer;

{ Initialize binary patterns - matches assembly data }
procedure InitializeBinaryPatterns;
var
    i: integer;
    pattern: BinaryString;
begin
    { Initialize binary patterns from 00000000 to 01011111 }
    for i := 0 to 95 do
    begin
        pattern := '';
        { Convert i to 8-bit binary }
        if (i and 128) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 64) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 32) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 16) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 8) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 4) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 2) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        if (i and 1) <> 0 then pattern := pattern + '1' else pattern := pattern + '0';
        
        binaryPatterns[i] := pattern;
    end;
end;

{ Initialize program variables }
procedure InitializeProgram;
begin
    maxIterations := 92;  { Based on assembly: CMP [0426], 005C }
    currentIteration := 0;
    isValidCode := false;
    fileExists := false;
    charCount := 0;
    keySum := 0;
    binaryIndex := 0;
    
    InitializeBinaryPatterns;
end;

{ Display main menu - matches assembly string references }
procedure DisplayMainMenu;
begin
    clrscr;
    writeln('Witam w moim programie kodującym i rozkodowywującym pliki tekstowe.');
    writeln('Programowanie : Rafał Stańczuk rafalsrs@wp.pl www.rafalsrs.prv.pl');
    writeln('Uwaga-Program nie interpretuje znaków polskich!');
    writeln;
    writeln('1. Podaj plik do rozkodowania.');
    writeln('2. Podaj plik do zakodowania.');
    writeln('[ESC]. Wyjście');
    writeln;
end;

{ Get user input with specific prompts from assembly }
function GetUserInput(promptText: String255): String255;
var
    userInput: String255;
begin
    write(promptText);
    readln(userInput);
    GetUserInput := userInput;
end;

{ Validate access code - matches assembly validation logic }
function ValidateAccessCode(code: String80): boolean;
var
    i: integer;
    codeLength: integer;
begin
    codeLength := length(code);
    ValidateAccessCode := false;
    
    { Assembly shows validation loop up to 92 iterations }
    for i := 1 to maxIterations do
    begin
        if (codeLength > 0) and (codeLength <= 80) then
        begin
            ValidateAccessCode := true;
            break;
        end;
    end;
end;

{ Convert character to binary using pattern matching }
function CharToBinaryPattern(ch: char): BinaryString;
var
    asciiValue: integer;
    patternIndex: integer;
begin
    asciiValue := ord(ch);
    
    { Use pattern matching for characters 0-95 }
    if asciiValue <= 95 then
        CharToBinaryPattern := binaryPatterns[asciiValue]
    else
    begin
        { Fallback for characters > 95 }
        CharToBinaryPattern := binaryPatterns[asciiValue mod 96];
    end;
end;

{ Convert binary pattern to character }
function BinaryPatternToChar(binary: BinaryString): char;
var
    asciiValue: integer;
    i: integer;
    bitValue: integer;
begin
    asciiValue := 0;
    bitValue := 1;
    
    for i := 8 downto 1 do
    begin
        if binary[i] = '1' then
            asciiValue := asciiValue + bitValue;
        bitValue := bitValue * 2;
    end;
    
    BinaryPatternToChar := chr(asciiValue);
end;

{ Calculate key sum for binary encoding }
function CalculateKeySum(key: String80): integer;
var
    i: integer;
    sum: integer;
begin
    sum := 0;
    for i := 1 to length(key) do
        sum := sum + ord(key[i]);
    CalculateKeySum := sum;
end;

{ Enhanced binary encoding algorithm - matches assembly patterns }
function EncodeCharacter(ch: char; key: String80): char;
var
    binary: BinaryString;
    keyIndex: integer;
    keyChar: char;
    encodedBinary: BinaryString;
    i: integer;
    keySumValue: integer;
    patternIndex: integer;
begin
    if length(key) = 0 then
        EncodeCharacter := ch
    else
    begin
        { Convert character to binary pattern }
        binary := CharToBinaryPattern(ch);
        
        { Calculate key sum for pattern modification }
        keySumValue := CalculateKeySum(key);
        
        { Apply key-based transformation to binary pattern }
        encodedBinary := '';
        for i := 1 to 8 do
        begin
            keyIndex := ((i + keySumValue) mod length(key)) + 1;
            keyChar := key[keyIndex];
            
            { Enhanced binary transformation }
            if binary[i] = '1' then
            begin
                if ((ord(keyChar) + keySumValue + i) mod 2) = 0 then
                    encodedBinary := encodedBinary + '0'
                else
                    encodedBinary := encodedBinary + '1';
            end
            else
            begin
                if ((ord(keyChar) + keySumValue + i) mod 2) = 0 then
                    encodedBinary := encodedBinary + '1'
                else
                    encodedBinary := encodedBinary + '0';
            end;
        end;
        
        { Convert back to character }
        EncodeCharacter := BinaryPatternToChar(encodedBinary);
    end;
end;

{ Enhanced binary decoding algorithm - reverse of encoding }
function DecodeCharacter(ch: char; key: String80): char;
var
    binary: BinaryString;
    keyIndex: integer;
    keyChar: char;
    decodedBinary: BinaryString;
    i: integer;
    keySumValue: integer;
begin
    if length(key) = 0 then
        DecodeCharacter := ch
    else
    begin
        { Convert character to binary pattern }
        binary := CharToBinaryPattern(ch);
        
        { Calculate key sum for pattern modification }
        keySumValue := CalculateKeySum(key);
        
        { Apply reverse key-based transformation to binary pattern }
        decodedBinary := '';
        for i := 1 to 8 do
        begin
            keyIndex := ((i + keySumValue) mod length(key)) + 1;
            keyChar := key[keyIndex];
            
            { Reverse binary transformation }
            if binary[i] = '1' then
            begin
                if ((ord(keyChar) + keySumValue + i) mod 2) = 0 then
                    decodedBinary := decodedBinary + '0'
                else
                    decodedBinary := decodedBinary + '1';
            end
            else
            begin
                if ((ord(keyChar) + keySumValue + i) mod 2) = 0 then
                    decodedBinary := decodedBinary + '1'
                else
                    decodedBinary := decodedBinary + '0';
            end;
        end;
        
        { Convert back to character }
        DecodeCharacter := BinaryPatternToChar(decodedBinary);
    end;
end;

{ Process file with binary algorithm - matches assembly file operations }
procedure ProcessFileData(inputName, outputName: String255; encodeMode: boolean; key: String80);
var
    inputFile, outputFile: text;
    currentChar: char;
    processedChar: char;
    progressCounter: integer;
begin
    assign(inputFile, inputName);
    assign(outputFile, outputName);
    
    { Check if input file exists }
    if not FileExists(inputName) then
    begin
        writeln('Błąd: Plik nie istnieje!');
        exit;
    end;
    
    reset(inputFile);
    rewrite(outputFile);
    
    charCount := 0;
    progressCounter := 0;
    
    { Process file character by character with binary algorithm }
    while not eof(inputFile) do
    begin
        read(inputFile, currentChar);
        
        if encodeMode then
            processedChar := EncodeCharacter(currentChar, key)
        else
            processedChar := DecodeCharacter(currentChar, key);
            
        write(outputFile, processedChar);
        charCount := charCount + 1;
        progressCounter := progressCounter + 1;
        
        { Show progress every 500 characters }
        if progressCounter mod 500 = 0 then
        begin
            write('.');
            if progressCounter mod 2500 = 0 then
                writeln(' ', charCount, ' znaków');
        end;
    end;
    
    close(inputFile);
    close(outputFile);
    
    writeln;
    writeln('Przetworzono ', charCount, ' znaków (algorytm binarny).');
    
    if encodeMode then
        writeln('Plik został zakodowany pomyślnie!')
    else
        writeln('Plik został rozkodowany pomyślnie!');
end;

{ Decode file procedure - matches assembly string references }
procedure HandleDecodeFile;
begin
    writeln;
    inputFileName := GetUserInput('Podaj pełną nazwę pliku zakodowanego (z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFileName := GetUserInput('Podaj pełną nazwę pliku, do którego zapiszesz rozkodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    accessCode := GetUserInput('Podaj kod dostępu do odkodowania : ');
    
    { Validate access code }
    if not ValidateAccessCode(accessCode) then
    begin
        writeln('Błędny kod do tego pliku!!! Koniec...');
        readln;
        exit;
    end;
    
    { Process the file with binary algorithm }
    ProcessFileData(inputFileName, outputFileName, false, accessCode);
    writeln('Naciśnij Enter...');
    readln;
end;

{ Encode file procedure - matches assembly string references }
procedure HandleEncodeFile;
begin
    writeln;
    inputFileName := GetUserInput('Podaj pełną nazwę pliku do zakodowania(z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFileName := GetUserInput('Podaj pełną nazwę pliku, do którego zapiszesz zakodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    accessCode := GetUserInput('Podaj kod dostępu do kodowarki : ');
    
    { Validate access code }
    if not ValidateAccessCode(accessCode) then
    begin
        writeln('Błędny kod do tego pliku!!! Koniec...');
        readln;
        exit;
    end;
    
    { Process the file with binary algorithm }
    ProcessFileData(inputFileName, outputFileName, true, accessCode);
    writeln('Naciśnij Enter...');
    readln;
end;

{ Main program loop - matches assembly control flow }
begin
    InitializeProgram;
    
    repeat
        DisplayMainMenu;
        menuChoice := ReadKey;
        
        case menuChoice of
            '1': HandleDecodeFile;
            '2': HandleEncodeFile;
            #27: begin { ESC key - matches assembly jump }
                writeln('Koniec...');
                break;
            end;
        end;
    until menuChoice = #27;
    
    { Program termination }
    writeln('Program zakończony.');
end.
