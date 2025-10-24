program Kodowrs3;

{*
 * Kodowrs3 - File Encoding/Decoding Utility Version 3.0
 * Reconstructed from disassembly analysis
 * Original: Rafał Stańczuk (rafalsrs@wp.pl)
 * Date: June 3, 2003, 22:28:14
 * Version: 3.0
 * 
 * This is version 3 of the file encoding/decoding utility
 * with enhanced features and improved error handling
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];
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
    version: String80;
    maxAttempts: integer;
    currentAttempt: integer;

{ Display version information }
procedure ShowVersion;
begin
    version := 'Kodowrs3 v3.0';
    writeln('===============================================');
    writeln('Kodowrs3 - File Encoding/Decoding Utility v3.0');
    writeln('Programowanie : Rafał Stańczuk (rafalsrs@wp.pl)');
    writeln('Data utworzenia: 3 czerwca 2003, 22:28:14');
    writeln('===============================================');
    writeln;
end;

{ Function to get user input with prompt }
function GetInput(prompt: String255): String255;
var
    input: String255;
begin
    write(prompt);
    readln(input);
    GetInput := input;
end;

{ Enhanced access code validation }
function ValidateCode(code: String80): boolean;
var
    i: integer;
    codeLength: integer;
    hasValidChars: boolean;
begin
    codeLength := length(code);
    hasValidChars := true;
    
    { Check for valid characters }
    for i := 1 to codeLength do
    begin
        if (ord(code[i]) < 32) or (ord(code[i]) > 126) then
        begin
            hasValidChars := false;
            break;
        end;
    end;
    
    ValidateCode := (codeLength > 0) and (codeLength <= 80) and hasValidChars;
end;

{ Enhanced encoding algorithm with better key distribution }
function EncodeChar(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    encodedValue: integer;
    keySum: integer;
    i: integer;
begin
    if length(key) = 0 then
        EncodeChar := ch
    else
    begin
        { Calculate key sum for better distribution }
        keySum := 0;
        for i := 1 to length(key) do
            keySum := keySum + ord(key[i]);
            
        keyIndex := ((ord(ch) + keySum) mod length(key)) + 1;
        keyChar := key[keyIndex];
        encodedValue := (ord(ch) + ord(keyChar) + keySum) mod 256;
        EncodeChar := chr(encodedValue);
    end;
end;

{ Enhanced decoding algorithm }
function DecodeChar(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
    decodedValue: integer;
    keySum: integer;
    i: integer;
begin
    if length(key) = 0 then
        DecodeChar := ch
    else
    begin
        { Calculate key sum for better distribution }
        keySum := 0;
        for i := 1 to length(key) do
            keySum := keySum + ord(key[i]);
            
        keyIndex := ((ord(ch) + keySum) mod length(key)) + 1;
        keyChar := key[keyIndex];
        decodedValue := (ord(ch) - ord(keyChar) - keySum + 512) mod 256;
        DecodeChar := chr(decodedValue);
    end;
end;

{ Process file for encoding/decoding with progress indication }
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
        
        { Show progress every 1000 characters }
        if charCount mod 1000 = 0 then
        begin
            write('.');
        end;
    end;
    
    close(inputF);
    close(outputF);
    writeln;
    writeln('Przetworzono ', charCount, ' znaków.');
end;

{ Enhanced main menu display }
procedure ShowMenu;
begin
    clrscr;
    ShowVersion;
    writeln('Witam w moim programie kodującym i rozkodowywującym pliki tekstowe v3.0');
    writeln('Programowanie : Rafał Stańczuk rafalsrs@wp.pl www.rafalsrs.prv.pl');
    writeln('Uwaga-Program nie interpretuje znaków polskich!');
    writeln;
    writeln('1. Podaj plik do rozkodowania.');
    writeln('2. Podaj plik do zakodowania.');
    writeln('3. Informacje o programie.');
    writeln('[ESC]. Wyjście');
    writeln;
end;

{ Show program information }
procedure ShowInfo;
begin
    clrscr;
    ShowVersion;
    writeln('Funkcje programu:');
    writeln('- Kodowanie plików tekstowych z ochroną hasłem');
    writeln('- Rozkodowywanie wcześniej zakodowanych plików');
    writeln('- Ulepszony algorytm szyfrowania');
    writeln('- Lepsze obsługa błędów');
    writeln('- Wskaźnik postępu przetwarzania');
    writeln;
    writeln('Naciśnij Enter...');
    readln;
end;

{ Enhanced decode file procedure }
procedure DecodeFile;
begin
    writeln;
    inputFile := GetInput('Podaj pełną nazwę pliku zakodowanego (z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFile := GetInput('Podaj pełną nazwę pliku, do którego zapiszesz rozkodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    
    maxAttempts := 3;
    currentAttempt := 0;
    
    repeat
        currentAttempt := currentAttempt + 1;
        inputCode := GetInput('Podaj kod dostępu do odkodowania : ');
        
        if ValidateCode(inputCode) then
        begin
            if FileExists(inputFile) then
            begin
                writeln('Rozkodowywanie pliku...');
                ProcessFile(inputFile, outputFile, false, inputCode);
                writeln('Plik został rozkodowany pomyślnie!');
            end
            else
            begin
                writeln('Błąd: Plik nie istnieje!');
            end;
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

{ Enhanced encode file procedure }
procedure EncodeFile;
begin
    writeln;
    inputFile := GetInput('Podaj pełną nazwę pliku do zakodowania(z rozszerzeniem) lub/i jego ścieżkę : ');
    outputFile := GetInput('Podaj pełną nazwę pliku, do którego zapiszesz zakodowane dane (z rozszerzeniem) lub/i jego ścieżkę : ');
    
    maxAttempts := 3;
    currentAttempt := 0;
    
    repeat
        currentAttempt := currentAttempt + 1;
        inputCode := GetInput('Podaj kod dostępu do kodowarki : ');
        
        if ValidateCode(inputCode) then
        begin
            if FileExists(inputFile) then
            begin
                writeln('Kodowanie pliku...');
                ProcessFile(inputFile, outputFile, true, inputCode);
                writeln('Plik został zakodowany pomyślnie!');
            end
            else
            begin
                writeln('Błąd: Plik nie istnieje!');
            end;
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

{ Main program }
begin
    maxAttempts := 3;
    currentAttempt := 0;
    
    repeat
        ShowMenu;
        choice := ReadKey;
        
        case choice of
            '1': DecodeFile;
            '2': EncodeFile;
            '3': ShowInfo;
            #27: begin { ESC key }
                writeln('Koniec...');
                break;
            end;
        end;
    until choice = #27;
    
    writeln('Program zakończony. Dziękuję za użycie Kodowrs3 v3.0!');
end.
