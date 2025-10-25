program KODOWRS2;

{*
 * KODOWRS2 - File Encoding/Decoding Utility Version 2.0
 * Reconstructed from disassembly analysis
 * Original: Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
 * Date: June 3, 2003
 * Version: 2.0
 * 
 * This version uses binary-based encoding algorithm
 * with enhanced security features
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];
    BinaryString = string[8];
    FileBuffer = array[1..255] of char;

var
    inputFile, outputFile: String255;
    accessCode, inputCode: String80;
    choice: char;
    fileHandle: text;
    tempFile: text;
    ch: char;
    i: integer;
    encoded: boolean;
    binaryPattern: BinaryString;

{ Function to get user input with prompt }
function GetInput(prompt: String255): String255;
var
    input: String255;
begin
    write(prompt);
    readln(input);
    GetInput := input;
end;

{ Function to validate access code }
function ValidateCode(code: String80): boolean;
begin
    ValidateCode := (length(code) > 0) and (length(code) <= 80);
end;

{ Convert character to binary string }
function CharToBinary(ch: char): BinaryString;
var
    asciiValue: integer;
    binary: BinaryString;
    i: integer;
begin
    asciiValue := ord(ch);
    binary := '';
    
    for i := 7 downto 0 do
    begin
        if (asciiValue and (1 shl i)) <> 0 then
            binary := binary + '1'
        else
            binary := binary + '0';
    end;
    
    CharToBinary := binary;
end;

{ Convert binary string to character }
function BinaryToChar(binary: BinaryString): char;
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
    
    BinaryToChar := chr(asciiValue);
end;

{ Enhanced binary encoding algorithm }
function EncodeChar(ch: char; key: String80): char;
var
    binary: BinaryString;
    keyIndex: integer;
    keyChar: char;
    encodedBinary: BinaryString;
    i: integer;
    keySum: integer;
begin
    if length(key) = 0 then
        EncodeChar := ch
    else
    begin
        { Convert character to binary }
        binary := CharToBinary(ch);
        
        { Calculate key sum for pattern modification }
        keySum := 0;
        for i := 1 to length(key) do
            keySum := keySum + ord(key[i]);
            
        { Apply key-based transformation to binary }
        encodedBinary := '';
        for i := 1 to 8 do
        begin
            keyIndex := ((i + keySum) mod length(key)) + 1;
            keyChar := key[keyIndex];
            
            if binary[i] = '1' then
            begin
                if (ord(keyChar) + keySum) mod 2 = 0 then
                    encodedBinary := encodedBinary + '0'
                else
                    encodedBinary := encodedBinary + '1';
            end
            else
            begin
                if (ord(keyChar) + keySum) mod 2 = 0 then
                    encodedBinary := encodedBinary + '1'
                else
                    encodedBinary := encodedBinary + '0';
            end;
        end;
        
        { Convert back to character }
        EncodeChar := BinaryToChar(encodedBinary);
    end;
end;

{ Enhanced binary decoding algorithm }
function DecodeChar(ch: char; key: String80): char;
var
    binary: BinaryString;
    keyIndex: integer;
    keyChar: char;
    decodedBinary: BinaryString;
    i: integer;
    keySum: integer;
begin
    if length(key) = 0 then
        DecodeChar := ch
    else
    begin
        { Convert character to binary }
        binary := CharToBinary(ch);
        
        { Calculate key sum for pattern modification }
        keySum := 0;
        for i := 1 to length(key) do
            keySum := keySum + ord(key[i]);
            
        { Apply reverse key-based transformation to binary }
        decodedBinary := '';
        for i := 1 to 8 do
        begin
            keyIndex := ((i + keySum) mod length(key)) + 1;
            keyChar := key[keyIndex];
            
            if binary[i] = '1' then
            begin
                if (ord(keyChar) + keySum) mod 2 = 0 then
                    decodedBinary := decodedBinary + '0'
                else
                    decodedBinary := decodedBinary + '1';
            end
            else
            begin
                if (ord(keyChar) + keySum) mod 2 = 0 then
                    decodedBinary := decodedBinary + '1'
                else
                    decodedBinary := decodedBinary + '0';
            end;
        end;
        
        { Convert back to character }
        DecodeChar := BinaryToChar(decodedBinary);
    end;
end;

{ Process file for encoding/decoding with binary algorithm }
procedure ProcessFile(inputName, outputName: String255; encode: boolean; key: String80);
var
    inputF, outputF: text;
    ch: char;
    processedChar: char;
    charCount: longint;
begin
    assign(inputF, inputName);
    assign(outputF, outputName);
    
    reset(inputF);
    rewrite(outputF);
    
    charCount := 0;
    while not eof(inputF) do
    begin
        read(inputF, ch);
        
        if encode then
            processedChar := EncodeChar(ch, key)
        else
            processedChar := DecodeChar(ch, key);
            
        write(outputF, processedChar);
        charCount := charCount + 1;
        
        { Show progress every 500 characters }
        if charCount mod 500 = 0 then
        begin
            write('.');
        end;
    end;
    
    close(inputF);
    close(outputF);
    writeln;
    writeln('Przetworzono ', charCount, ' znaków.');
end;

{ Main menu display }
procedure ShowMenu;
begin
    clrscr;
    writeln('Witam w moim programie kodującym i rozkodowywującym pliki tekstowe.');
    writeln('Programowanie : Rafał Stańczuk stanczuk.rafal@gmail.com https://github.com/rafalstanczuk');
    writeln('Uwaga-Program nie interpretuje znaków polskich!');
    writeln;
    writeln('1. Podaj plik do rozkodowania.');
    writeln('2. Podaj plik do zakodowania.');
    writeln('[ESC]. Wyjście');
    writeln;
end;

{ Decode file procedure }
procedure DecodeFile;
begin
    writeln;
    inputFile := GetInput('Podaj pełną nazwę pliku zakodowanego (z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFile := GetInput('Podaj pełną nazwę pliku, do którego zapiszesz rozkodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    inputCode := GetInput('Podaj kod dostępu do odkodowania : ');
    
    if not ValidateCode(inputCode) then
    begin
        writeln('Błędny kod do tego pliku!!! Koniec...');
        readln;
        exit;
    end;
    
    if FileExists(inputFile) then
    begin
        writeln('Rozkodowywanie pliku (algorytm binarny)...');
        ProcessFile(inputFile, outputFile, false, inputCode);
        writeln('Plik został rozkodowany pomyślnie!');
    end
    else
    begin
        writeln('Plik nie istnieje!');
    end;
    
    writeln('Naciśnij Enter...');
    readln;
end;

{ Encode file procedure }
procedure EncodeFile;
begin
    writeln;
    inputFile := GetInput('Podaj pełną nazwę pliku do zakodowania(z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFile := GetInput('Podaj pełną nazwę pliku, do którego zapiszesz zakodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    inputCode := GetInput('Podaj kod dostępu do kodowarki : ');
    
    if not ValidateCode(inputCode) then
    begin
        writeln('Błędny kod do tego pliku!!! Koniec...');
        readln;
        exit;
    end;
    
    if FileExists(inputFile) then
    begin
        writeln('Kodowanie pliku (algorytm binarny)...');
        ProcessFile(inputFile, outputFile, true, inputCode);
        writeln('Plik został zakodowany pomyślnie!');
    end
    else
    begin
        writeln('Plik nie istnieje!');
    end;
    
    writeln('Naciśnij Enter...');
    readln;
end;

{ Main program }
begin
    repeat
        ShowMenu;
        choice := ReadKey;
        
        case choice of
            '1': DecodeFile;
            '2': EncodeFile;
            #27: begin { ESC key }
                writeln('Koniec...');
                break;
            end;
        end;
    until choice = #27;
    
    writeln('Program zakończony.');
end.
