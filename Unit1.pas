unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Math;
type
  Types = ( T, G, P, M, C);
  Adr = ^List;
  //Список операторов\операндов
  List = record
    Name: string[255];
    Count: Integer;
    ClassType: Types;
    In_Out: Boolean;
    Next: Adr;
    end;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    btnopen: TButton;
    strngrd1: TStringGrid;
    dlgOpen: TOpenDialog;
    btn1: TButton;
    Memo1: TMemo;
    btn2: TButton;
    vouge: TLabel;
    gucci: TLabel;
    cosmos: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnopenClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ControlC(data: string;var i: integer; ClTyp:Types; i_o:Boolean);
    procedure Analysis(const text: string);
    procedure Add(MainZv: Adr; const title: string; ClTyp:Types; i_o:Boolean);
    procedure Print;
  end;



var
  Form1: TForm1;
  FileName1 :string;
  Operand: Adr;   //Адрес начала списка операндов
  comment,flDo, flCase: boolean;
  CountOperator, CountOperand:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Row: Integer;
begin
  //Создание списка
  New(Operand);
  Operand.Next := nil;

  Row := 0;
  strngrd1.Cells[0,Row] := '          j';
  strngrd1.Cells[1,Row] := '    Оператор';
  strngrd1.Cells[2,Row] := '          f1j';
  strngrd1.Cells[3,Row] := '          i';
  strngrd1.Cells[4,Row] := '     Операнд';
  strngrd1.Cells[5,Row] := '          f2j';
end;

procedure TForm1.btnopenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
      Memo1.Lines.LoadFromFile(dlgOpen.FileName);
  FileName1 := dlgOpen.FileName;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  Row,i: Integer;
begin
  Memo1.Clear;
  with strngrd1 do
  for i:=0 to ColCount-1 do
    Cols[i].Clear;
  Row := 0;
  strngrd1.Cells[0,Row] := '          j';
  strngrd1.Cells[1,Row] := '    Оператор';
  strngrd1.Cells[2,Row] := '          f1j';
  strngrd1.Cells[3,Row] := '          i';
  strngrd1.Cells[4,Row] := '     Операнд';
  strngrd1.Cells[5,Row] := '          f2j';
  strngrd1.RowCount:= 1;
  vouge.Caption:='';
  gucci.Caption := '';
  cosmos.Caption := '';
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  myFile: TextFile;
  text1: string;
  ch: char;
begin
  comment:=False;
  AssignFile(MyFile, FileName1);
  Reset(MyFile);
  //создание заглавного звеньев списков
  New(Operand);
  Operand.Next := Nil;
  text1 := '';
  while not (eof(MyFile)) do
  begin
     read(Myfile, ch);
     if (ch = ';') or (ch = #10) or (ch = #13) then
     begin
        if ch = ';' then
          text1 := text1 + ch
        else
         read(MyFile, ch);

       Analysis(text1+' ');//анализ строки
       text1:='';
     end
     else
       text1 := text1 + ch;
  end;
  if text1<>'' then
    Analysis(text1+' ');//анализ строки
  CloseFile(MyFile);
  print;
end;

procedure TForm1.ControlC(data: string;var i: integer; ClTyp:Types; i_o:Boolean );
var
  CurrStr:string;
  StrBol:Boolean;
  j:integer;
begin
   CurrStr:='';
   StrBol:=False;
   j:=0;
   while i <= length(data) do
   begin
      case data[i] of
       '$','_','a'..'z','A'..'Z','0'..'9': begin
                                              if not StrBol then
                                              begin
                                                CurrStr:= CurrStr + data[i];
                                                if (CurrStr='var') and (data[i+1]= ' ') then
                                                begin
                                                  CurrStr:='';
                                                  inc(i);
                                                end;

                                                if (data[i] in ['0'..'9']) and (length(CurrStr)=1) then
                                                   CurrStr:='';
                                              end;
                                           end;
       '"':begin //Обработка литералов/строк

              if j= 0 then
              begin
                StrBol:=true;
                inc(j);
              end
              else
              begin
                StrBol:=false;
                dec(j);
              end; 
           end;

       else
       begin
         if (CurrStr<>'') then
           Add(Operand,CurrStr,ClTyp,i_o);
         CurrStr:='';
       end;
      end;
      inc(i);
   end;
end;


procedure TForm1.Analysis(const text: string);
var
  i: integer;
  currStr, ComplAr: string;

begin
   i := 1;
   currStr := '';
   while i <= length(text) do
   begin
     if comment then
       ComplAr := ComplAr + text[i]
     else
     begin
      case text[i] of
       '$','_','a'..'z','A'..'Z','0'..'9': begin
                                              if (currStr<>'') and (pos('=',ComplAr)<>0) and (length(ComplAr) <> 0) then  //++--
                                              begin
                                                Add(Operand, CurrStr, M, False);
                                                CurrStr:='';
                                                ComplAr :='';
                                              end;
                                              if (currStr<>'') and (pos('=',ComplAr)=0) and (length(ComplAr) <> 0) then
                                              begin
                                                Add(Operand, CurrStr, G, False);
                                                CurrStr:='';
                                                ComplAr :='';
                                              end;
                                              if (text[i] in ['0'..'9']) and (length(CurrStr)=1) then
                                                 CurrStr:='';

                                              currStr := currStr + text[i];
                                              if ((currStr = 'do') and (text[i+1]='{')) or (currStr = 'case') then
                                              begin
                                                currStr := '';
                                              end;
                                              if ((currStr = 'while') or
                                                 (currStr = 'for') or
                                                 (currStr = 'switch') or
                                                 (currStr = 'if')) and (text[i+1]='(')
                                              then
                                              begin
                                                 i:=i+2;
                                                 ControlC(text,i,C,False);
                                                 currStr := '';
                                              end;

                                              if ((currStr = 'function') or
                                                 (currStr = 'var') or
                                                 (currStr = 'let') or
                                                 (currStr = 'const')) and
                                                 ((text[i+1]=' ') or (text[i+1]='(')) then
                                              begin
                                                 i:=i+2;
                                                 ControlC(text,i,T,False);
                                                 currStr := '';
                                              end;
                                              if ((currStr = 'alert') or (currStr = 'promt'))then
                                              begin
                                                 i:=i+2;
                                                 ControlC(text,i,P,True);
                                                 currStr := '';
                                              end;
                                              if (currStr = 'break') or (currStr = 'continue') or (currStr = 'return')then
                                              begin
                                                 currStr := '';
                                              end;
                                           end;

        '(': begin
               if (currStr <> '') and (ComplAr='') then
               begin
                 currStr := '';
               end

             end;

         '+','-','*','/','%','=','>','<','!','&','|','^',',',';',')','{','}','[',']':
                                                                      begin
                                                                        ComplAr := ComplAr + text[i];

                                                                        if text[i] = ';' then
                                                                        begin
                                                                          if (currStr = 'break') or (currStr = 'continue') or (currStr = 'return')then
                                                                          begin
                                                                            currStr := '';
                                                                          end;

                                                                          if (ComplAr <> '') and (ComplAr <> ';') then
                                                                          begin
                                                                            ComplAr[length(ComplAr)] := #0;
                                                                          end;
                                                                        end;

                                                                        if ComplAr = '//' then i := length(text);

                                                                      end;


         ':': begin
                CurrStr:='';
              end;

      end;

     end; // конец case


     if ComplAr = '/*' then comment := true;
     if pos('*/', ComplAr) <> 0 then
     begin
       comment := false;
       ComplAr := '';
     end;
     inc(i);
    end;
end;

procedure TForm1.Add(MainZv: Adr; const title: string; ClTyp:Types; i_o:Boolean );
var
  fl: Boolean;
  AdrZv: Adr;
begin
  fl := True;
  AdrZv := MainZv;
  while AdrZv^.Next <> Nil  do
  begin
    AdrZv := AdrZv^.Next;
    if AdrZv^.Name = title then
    begin
      if ord(AdrZv.ClassType)<ord(ClTyp)then
      AdrZv.ClassType:= ClTyp;
      if i_o=True then
      AdrZv.In_Out:=True;
      inc(AdrZv.Count);
      fl := False; // элемент найден
    end;
  end;
  if fl then //элемент не найден - создаем новый
  begin
    New(AdrZv^.Next);
    AdrZv := AdrZv^.Next;
    AdrZv^.Next := Nil;
    AdrZv^.Name := title;
    AdrZv^.Count := 1;
    AdrZv.ClassType:= ClTyp;
    AdrZv.In_Out:=i_o;
  end;
end;

procedure TForm1.Print;
var
  AdrZv:Adr;
  i,j:integer;
  countoper1,countoper2,countcount:integer;
  shape:real;
begin
  i:=0;
  j:=0;
  if CountOperand>CountOperator then
  countcount:= CountOperand
  else
  countcount:=CountOperator;
  strngrd1.RowCount:= strngrd1.RowCount+countcount+1;
  countoper1:= 0;
  repeat
    inc(j);
    AdrZv := AdrZv^.Next;
    strngrd1.Cells[0,j]:=inttostr(j);
    strngrd1.Cells[1,j]:=AdrZv.Name;
    strngrd1.Cells[2,j]:=inttostr(AdrZv.Count);
    countoper1:= countoper1 + AdrZv.Count;
  until AdrZv^.Next = Nil;
  strngrd1.Cells[0,countcount+1]:='n1 = ' + inttostr(CountOperator);
  strngrd1.Cells[2,countcount+1]:='N1 = ' + inttostr(countoper1);
  countoper2:= 0;
   AdrZv := Operand;
  repeat
    inc(i);
    AdrZv := AdrZv^.Next;
    strngrd1.Cells[3,i]:=inttostr(i);
    strngrd1.Cells[4,i]:=AdrZv.Name;
    strngrd1.Cells[5,i]:=inttostr(AdrZv.Count);
    countoper2:= countoper2 + AdrZv.Count;
  until AdrZv^.Next = Nil;
  strngrd1.Cells[5,countcount+1]:='N2 = ' + inttostr(countoper2);
  strngrd1.Cells[3,countcount+1]:='n2 = '+ inttostr(CountOperand);
  vouge.Caption:='n = '+ inttostr(CountOperand + CountOperator);
  gucci.Caption:='N = ' + inttostr(countoper1 + countoper2);
  shape:=(countoper1 + countoper2)*log2(countoper1 + countoper2);
  shape := roundto(shape,-2);
  cosmos.Caption:='V = ' + floattostr( shape);
end;

end.
