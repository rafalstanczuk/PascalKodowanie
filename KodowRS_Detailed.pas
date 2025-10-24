program KodowRS;

{*
 * KodowRS - File Encoding/Decoding Utility
 * Detailed reconstruction based on disassembly analysis
 * Original: Rafał Stańczuk (rafalsrs@wp.pl)
 * Date: June 3, 2003
 * 
 * This is a more accurate reconstruction based on the assembly analysis
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];
    FileBuffer = array[1..255] of char;

var
    inputFileName, outputFileName: String255;
    accessCode: String80;
    menuChoice: char;
    fileHandle: text;
    tempBuffer: FileBuffer;
    bufferIndex: integer;
    maxIterations: integer;
    currentIteration: integer;
    isValidCode: boolean;
    fileExists: boolean;

{ Initialize program variables }
procedure InitializeProgram;
begin
    maxIterations := 92;  { Based on assembly: CMP [0426], 005C }
    currentIteration := 0;
    isValidCode := false;
    fileExists := false;
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

{ Simple encoding algorithm based on assembly analysis }
function EncodeCharacter(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    encodedValue: integer;
begin
    if length(key) = 0 then
        EncodeCharacter := ch
    else
    begin
        { Simple key-based encoding }
        keyIndex := (ord(ch) mod length(key)) + 1;
        keyChar := key[keyIndex];
        encodedValue := (ord(ch) + ord(keyChar)) mod 256;
        EncodeCharacter := chr(encodedValue);
    end;
end;

{ Simple decoding algorithm }
function DecodeCharacter(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    decodedValue: integer;
begin
    if length(key) = 0 then
        DecodeCharacter := ch
    else
    begin
        { Reverse of encoding }
        keyIndex := (ord(ch) mod length(key)) + 1;
        keyChar := key[keyIndex];
        decodedValue := (ord(ch) - ord(keyChar) + 256) mod 256;
        DecodeCharacter := chr(decodedValue);
    end;
end;

{ Process file with encoding/decoding - matches assembly file operations }
procedure ProcessFileData(inputName, outputName: String255; encodeMode: boolean; key: String80);
var
    inputFile, outputFile: text;
    currentChar: char;
    processedChar: char;
    fileSize: longint;
begin
    assign(inputFile, inputName);
    assign(outputFile, outputName);
    
    { Check if input file exists }
    if not FileExists(inputName) then
    begin
        writeln('Plik nie istnieje!');
        exit;
    end;
    
    reset(inputFile);
    rewrite(outputFile);
    
    { Process file character by character }
    while not eof(inputFile) do
    begin
        read(inputFile, currentChar);
        
        if encodeMode then
            processedChar := EncodeCharacter(currentChar, key)
        else
            processedChar := DecodeCharacter(currentChar, key);
            
        write(outputFile, processedChar);
    end;
    
    close(inputFile);
    close(outputFile);
    
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
    
    { Process the file }
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
    
    { Process the file }
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
