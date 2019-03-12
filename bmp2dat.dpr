program bmp2dat;
{
программа для преобразования текстур из формата bmp в dat
}

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Graphics;
const
  texSize = 256 - 1;
type
  rec=array[0..texSize, 0..texSize, 0..2] of Byte;
var
  bmp: TBitmap;
  f: file of rec;
  arr: rec;
  i, j, k: Integer;
  s: ShortString;
  isexit: Boolean;
begin
  WriteLn('bmp2dat converter');

  isexit := False;
  bmp := TBitmap.Create;
  i := 0;

  AssignFile(f, 'TexturesPack.dat');
  ReWrite(f);
  while not isexit do
  begin
    inc(i);
    s := IntToStr(i)+'.bmp';
    if FileExists(s) then
    begin
      WriteLn(s);
      bmp.LoadFromFile(s);
      for j := 0 to texSize do
        for k := 0 to texSize do
        begin
          arr[j, k, 0]:=GetRValue(bmp.Canvas.Pixels[texSize - k, j]);
          arr[j, k, 1]:=GetGValue(bmp.Canvas.Pixels[texSize - k, j]);
          arr[j, k, 2]:=GetBValue(bmp.Canvas.Pixels[texSize - k, j]);
        end;
      Write(f, arr);
    end else
      isexit := True;
  end;
  CloseFile(f);
  
  WriteLn('Complete: ' + IntToStr(i - 1) + ' textures');
  WriteLn('press any key...');
  ReadLn;
end.
