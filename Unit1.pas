unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Math;
type
  Types = (G, T, P, M, C);
  Adr = ^List;
  //������ ����������\���������
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
    procedure ControlC(data: string;var i: integer; ClTyp:Types);
    procedure Analysis(const text: string);
    procedure Add(MainZv: Adr; const title: string; ClTyp:Types; i_o:Boolean);
    procedure Print;
  end;



var
  Form1: TForm1;
  FileName1 :string;
  Operator: Adr;  //����� ������ ������ ����������
  Operand: Adr;   //����� ������ ������ ���������
  comment,flDo, flCase: boolean;
  CountOperator, CountOperand:integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Row: Integer;
begin
  //�������� ������
  New(Operand);
  Operand.Next := nil;

  Row := 0;
  strngrd1.Cells[0,Row] := '          j';
  strngrd1.Cells[1,Row] := '    ��������';
  strngrd1.Cells[2,Row] := '          f1j';
  strngrd1.Cells[3,Row] := '          i';
  strngrd1.Cells[4,Row] := '     �������';
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
  strngrd1.Cells[1,Row] := '    ��������';
  strngrd1.Cells[2,Row] := '          f1j';
  strngrd1.Cells[3,Row] := '          i';
  strngrd1.Cells[4,Row] := '     �������';
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
   //�������� ��������� ������� �������
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

      Analysis(text1+' ');//������ ������
      text1:='';
      end
      else
        text1 := text1 + ch;
   end;
   if text1<>'' then
    Analysis(text1+' ');//������ ������
   CloseFile(MyFile);
   print;
   
end;

procedure TForm1.ControlC(data: string;var i: integer; ClTyp:Types);
var
  CurrStr:string;
begin
   CurrStr:='';
   while i <= length(text) do
   begin
     //��������/����� �� ��������������!!
      case text[i] of
       '$','_','a'..'z','A'..'Z','0'..'9': begin
                                              CurrStr:= CurrStr + text[i];
                                              if (CurrStr='var') and (text[i+1]= ' ') then
                                              begin
                                                CurrStr:='';
                                                inc(i);
                                              end;

                                              if (text[i] in ['0'..'9']) and (length(CurrStr)=1) then
                                                 CurrStr:='';
                                           end;
       else
       begin
         if (CurrStr<>'') then
           Add(Operand,CurrStr,ClTyp,False);
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
     case text[i] of
       '$','_','a'..'z','A'..'Z','0'..'9': begin
       
                                              if (currStr<>'') and (pos('=',ComplAr)<>0) and (length(ComplAr) <> 0) then  //++--
                                              begin
                                                Add(Operator, CurrStr, M, False);
                                                ComplAr :='';
                                              end;
                                              if (currStr<>'') and (pos('=',ComplAr)=0) and (length(ComplAr) <> 0) then
                                              begin
                                                Add(Operator, CurrStr, G, False);
                                                ComplAr :='';
                                              end;

                                              currStr := currStr + text[i];

                                                 if (currStr = 'do') and (text[i+1]='{') then
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
                                                   ControlC(text,i,C);
                                                   currStr := '';
                                                 end;

                                                 if ((currStr = 'function') or
                                                    (currStr = 'var') or
                                                    (currStr = 'let') or
                                                    (currStr = 'const')) and
                                                    ((text[i+1]=' ') or (text[i+1]='(')) then
                                                 begin
                                                   i:=i+2;
                                                   ControlC(text,i,T); 
                                                   currStr := '';
                                                 end;

                                               end;

        '(': begin

               if currStr <> '' then
               begin
                 Add(Operator, currStr + '( )', T, False); // ��� � ��.�����
                 currStr := '';
               end
               else
               begin
                 if ComplAr <> '' then
                 begin
                   Add(Operator, ComplAr, T, False); // ��� � ��-���
                   ComplAr := '';
                 end;
                 Add(Operator, '( )', T,  False);
               end;
             end;

         '+','-','*','/','%','=','>','<','!','&','|','^',',',';': begin
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

     end; // ����� case

     if ComplAr = '/*' then comment := true;
     if pos('*/', ComplAr) <> 0 then
     begin
       comment := false;
       ComplAr := '';
     end;
     inc(i);
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
      fl := False; // ������� ������
    end;
  end;
  if fl then //������� �� ������ - ������� �����
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
  AdrZv := Operator;
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
