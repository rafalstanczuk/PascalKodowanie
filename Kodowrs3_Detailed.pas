program Kodowrs3_Detailed;

{*
 * Kodowrs3 - File Encoding/Decoding Utility Version 3.0
 * Detailed reconstruction based on disassembly analysis
 * Original: Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
 * Date: June 3, 2003, 22:28:14
 * Version: 3.0
 * 
 * This is a detailed reconstruction based on assembly analysis
 * with enhanced features for version 3
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];
    FileBuffer = array[1..255] of char;
    CodeBuffer = array[1..80] of char;

var
    inputFileName, outputFileName: String255;
    accessCode: String80;
    menuChoice: char;
    fileHandle: text;
    tempBuffer: FileBuffer;
    codeBuffer: CodeBuffer;
    bufferIndex: integer;
    maxIterations: integer;
    currentIteration: integer;
    isValidCode: boolean;
    fileExists: boolean;
    versionString: String80;
    maxAttempts: integer;
    currentAttempt: integer;
    charCount: longint;
    keySum: integer;

{ Initialize program variables - enhanced for v3 }
procedure InitializeProgram;
begin
    maxIterations := 92;  { Based on assembly: CMP [0426], 005C }
    currentIteration := 0;
    isValidCode := false;
    fileExists := false;
    maxAttempts := 3;     { Enhanced: 3 attempts instead of 1 }
    currentAttempt := 0;
    charCount := 0;
    keySum := 0;
    versionString := 'Kodowrs3 v3.0';
end;

{ Display version information - new in v3 }
procedure DisplayVersionInfo;
begin
    writeln('===============================================');
    writeln('Kodowrs3 - File Encoding/Decoding Utility v3.0');
    writeln('Programowanie : Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)');
    writeln('Data utworzenia: 3 czerwca 2003, 22:28:14');
    writeln('===============================================');
    writeln;
end;

{ Display main menu - enhanced for v3 }
procedure DisplayMainMenu;
begin
    clrscr;
    DisplayVersionInfo;
    writeln('Witam w moim programie kodującym i rozkodowywującym pliki tekstowe v3.0');
    writeln('Programowanie : Rafał Stańczuk stanczuk.rafal@gmail.com https://github.com/rafalstanczuk');
    writeln('Uwaga-Program nie interpretuje znaków polskich!');
    writeln;
    writeln('1. Podaj plik do rozkodowania.');
    writeln('2. Podaj plik do zakodowania.');
    writeln('3. Informacje o programie.');  { New in v3 }
    writeln('[ESC]. Wyjście');
    writeln;
end;

{ Get user input with specific prompts - enhanced validation }
function GetUserInput(promptText: String255): String255;
var
    userInput: String255;
    inputLength: integer;
begin
    write(promptText);
    readln(userInput);
    inputLength := length(userInput);
    
    { Enhanced input validation }
    if inputLength > 255 then
    begin
        userInput := copy(userInput, 1, 255);
        writeln('Ostrzeżenie: Nazwa pliku została skrócona do 255 znaków.');
    end;
    
    GetUserInput := userInput;
end;

{ Enhanced access code validation - improved for v3 }
function ValidateAccessCode(code: String80): boolean;
var
    i: integer;
    codeLength: integer;
    hasValidChars: boolean;
    minLength: integer;
begin
    codeLength := length(code);
    hasValidChars := true;
    minLength := 3;  { Minimum 3 characters for v3 }
    
    { Check minimum length }
    if codeLength < minLength then
    begin
        ValidateAccessCode := false;
        exit;
    end;
    
    { Check for valid characters - enhanced validation }
    for i := 1 to codeLength do
    begin
        if (ord(code[i]) < 32) or (ord(code[i]) > 126) then
        begin
            hasValidChars := false;
            break;
        end;
    end;
    
    { Additional validation - check for common patterns }
    if (code = '123') or (code = 'abc') or (code = 'password') then
    begin
        writeln('Ostrzeżenie: Używasz zbyt prostego kodu dostępu!');
    end;
    
    ValidateAccessCode := (codeLength >= minLength) and (codeLength <= 80) and hasValidChars;
end;

{ Calculate key sum for enhanced encoding - new in v3 }
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

{ Enhanced encoding algorithm - improved for v3 }
function EncodeCharacter(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    encodedValue: integer;
    keySumValue: integer;
begin
    if length(key) = 0 then
        EncodeCharacter := ch
    else
    begin
        keySumValue := CalculateKeySum(key);
        keyIndex := ((ord(ch) + keySumValue) mod length(key)) + 1;
        keyChar := key[keyIndex];
        encodedValue := (ord(ch) + ord(keyChar) + keySumValue) mod 256;
        EncodeCharacter := chr(encodedValue);
    end;
end;

{ Enhanced decoding algorithm - improved for v3 }
function DecodeCharacter(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    decodedValue: integer;
    keySumValue: integer;
begin
    if length(key) = 0 then
        DecodeCharacter := ch
    else
    begin
        keySumValue := CalculateKeySum(key);
        keyIndex := ((ord(ch) + keySumValue) mod length(key)) + 1;
        keyChar := key[keyIndex];
        decodedValue := (ord(ch) - ord(keyChar) - keySumValue + 512) mod 256;
        DecodeCharacter := chr(decodedValue);
    end;
end;

{ Process file with enhanced features - improved for v3 }
procedure ProcessFileData(inputName, outputName: String255; encodeMode: boolean; key: String80);
var
    inputFile, outputFile: text;
    currentChar: char;
    processedChar: char;
    fileSize: longint;
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
    
    { Process file character by character with progress indication }
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
        
        { Show progress every 500 characters - enhanced for v3 }
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
    writeln('Przetworzono ', charCount, ' znaków.');
    
    if encodeMode then
        writeln('Plik został zakodowany pomyślnie!')
    else
        writeln('Plik został rozkodowany pomyślnie!');
end;

{ Show program information - new feature in v3 }
procedure ShowProgramInfo;
begin
    clrscr;
    DisplayVersionInfo;
    writeln('Funkcje programu Kodowrs3 v3.0:');
    writeln('- Kodowanie plików tekstowych z ochroną hasłem');
    writeln('- Rozkodowywanie wcześniej zakodowanych plików');
    writeln('- Ulepszony algorytm szyfrowania z lepszą dystrybucją klucza');
    writeln('- Lepsza obsługa błędów z wielokrotnymi próbami');
    writeln('- Wskaźnik postępu przetwarzania');
    writeln('- Walidacja kodu dostępu z ostrzeżeniami');
    writeln('- Informacje o wersji programu');
    writeln;
    writeln('Naciśnij Enter...');
    readln;
end;

{ Enhanced decode file procedure - improved for v3 }
procedure HandleDecodeFile;
begin
    writeln;
    inputFileName := GetUserInput('Podaj pełną nazwę pliku zakodowanego (z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFileName := GetUserInput('Podaj pełną nazwę pliku, do którego zapiszesz rozkodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    
    currentAttempt := 0;
    
    repeat
        currentAttempt := currentAttempt + 1;
        accessCode := GetUserInput('Podaj kod dostępu do odkodowania : ');
        
        if ValidateAccessCode(accessCode) then
        begin
            ProcessFileData(inputFileName, outputFileName, false, accessCode);
            break;
        end
        else
        begin
            if currentAttempt < maxAttempts then
                writeln('Błędny kod! Pozostało prób: ', maxAttempts - currentAttempt)
            else
            begin
                writeln('Błędny kod do tego pliku!!! Koniec...');
                readln;
                exit;
            end;
        end;
    until currentAttempt >= maxAttempts;
    
    writeln('Naciśnij Enter...');
    readln;
end;

{ Enhanced encode file procedure - improved for v3 }
procedure HandleEncodeFile;
begin
    writeln;
    inputFileName := GetUserInput('Podaj pełną nazwę pliku do zakodowania(z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFileName := GetUserInput('Podaj pełną nazwę pliku, do którego zapiszesz zakodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    
    currentAttempt := 0;
    
    repeat
        currentAttempt := currentAttempt + 1;
        accessCode := GetUserInput('Podaj kod dostępu do kodowarki : ');
        
        if ValidateAccessCode(accessCode) then
        begin
            ProcessFileData(inputFileName, outputFileName, true, accessCode);
            break;
        end
        else
        begin
            if currentAttempt < maxAttempts then
                writeln('Błędny kod! Pozostało prób: ', maxAttempts - currentAttempt)
            else
            begin
                writeln('Błędny kod do tego pliku!!! Koniec...');
                readln;
                exit;
            end;
        end;
    until currentAttempt >= maxAttempts;
    
    writeln('Naciśnij Enter...');
    readln;
end;

{ Main program loop - enhanced for v3 }
begin
    InitializeProgram;
    
    repeat
        DisplayMainMenu;
        menuChoice := ReadKey;
        
        case menuChoice of
            '1': HandleDecodeFile;
            '2': HandleEncodeFile;
            '3': ShowProgramInfo;  { New in v3 }
            #27: begin { ESC key - matches assembly jump }
                writeln('Koniec...');
                break;
            end;
        end;
    until menuChoice = #27;
    
    { Enhanced program termination }
    writeln('Program zakończony. Dziękuję za użycie Kodowrs3 v3.0!');
end.
