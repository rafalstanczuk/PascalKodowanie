program KodowRS;

{*
 * KodowRS - File Encoding/Decoding Utility
 * Reconstructed from disassembly analysis
 * Original: Rafał Stańczuk (stanczuk.rafal@gmail.com - old contact rafalsrs@wp.pl)
 * Date: June 3, 2003
 * 
 * This program encodes and decodes text files using password protection
 *}

uses
    Crt, Dos;

type
    String80 = string[80];
    String255 = string[255];

var
    inputFile, outputFile: String255;
    accessCode, inputCode: String80;
    choice: char;
    fileHandle: text;
    tempFile: text;
    ch: char;
    i: integer;
    encoded: boolean;

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
    { Simple validation - in original this might be more complex }
    ValidateCode := (length(code) > 0);
end;

{ Function to encode a character }
function EncodeChar(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
begin
    if length(key) = 0 then
        EncodeChar := ch
    else
    begin
        keyIndex := (ord(ch) mod length(key)) + 1;
        keyChar := key[keyIndex];
        EncodeChar := chr((ord(ch) + ord(keyChar)) mod 256);
    end;
end;

{ Function to decode a character }
function DecodeChar(ch: char; key: String80): char;
var
    keyIndex: integer;
    keyChar: char;
begin
    if length(key) = 0 then
        DecodeChar := ch
    else
    begin
        keyIndex := (ord(ch) mod length(key)) + 1;
        keyChar := key[keyIndex];
        DecodeChar := chr((ord(ch) - ord(keyChar) + 256) mod 256);
    end;
end;

{ Process file for encoding/decoding }
procedure ProcessFile(inputName, outputName: String255; encode: boolean; key: String80);
var
    inputF, outputF: text;
    ch: char;
    processedChar: char;
begin
    assign(inputF, inputName);
    assign(outputF, outputName);
    
    reset(inputF);
    rewrite(outputF);
    
    while not eof(inputF) do
    begin
        read(inputF, ch);
        
        if encode then
            processedChar := EncodeChar(ch, key)
        else
            processedChar := DecodeChar(ch, key);
            
        write(outputF, processedChar);
    end;
    
    close(inputF);
    close(outputF);
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
end.
