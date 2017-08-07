unit Nathan.Tuple.ToCheckOut;

interface

uses
  System.SysUtils,
  System.IOUtils,
  System.Rtti,
  System.Types,
  System.TypInfo,
  System.Generics.Collections,
  DUnitX.TestFramework;

type
  //  This was an experiment with open arguments, comes from:
  //  https://stackoverflow.com/questions/298373/how-can-a-function-with-varargs-retrieve-the-contents-of-the-stack

  TArgPtr = record
  private
    FArgPtr: PByte;
    class function Align(Ptr: Pointer; Align: Integer): Pointer; static;
  public
    constructor Create(LastArg: Pointer; Size: Integer);

    //  Read bytes, signed words etc. using Int32
    //  Make an unsigned version if necessary.
    function ReadInt32: Integer;

    // Exact floating-point semantics depend on C compiler.
    // Delphi compiler passes Extended as 10-byte float; most C
    // compilers pass all floating-point values as 8-byte floats.
    function ReadDouble: Double;
    function ReadExtended: Extended;
    function ReadPChar: PChar;

    procedure ReadArg(var Arg; Size: Integer);
  end;

  PDump = procedure(const types: string) cdecl varargs;


  [TestFixture]
  TTestNathanTupleCheckOut = class(TObject)
  public
    [Test]
    procedure Test_CheckOut();
  end;

implementation

var
  MyDump: PDump;

procedure Dump(const types: string); cdecl;
var
  ap: TArgPtr;
  cp: PChar;
begin
  cp := PChar(types);
  ap := TArgPtr.Create(@types, SizeOf(string));
  while True do
  begin
    case cp^ of
      #0: Exit;
      'i': TFile.AppendAllText('C:\Temp\Nathan.txt', ap.ReadInt32.ToString());
      'd': TFile.AppendAllText('C:\Temp\Nathan.txt', ap.ReadDouble.ToString());
      'e': TFile.AppendAllText('C:\Temp\Nathan.txt', ap.ReadExtended.ToString());
      's': TFile.AppendAllText('C:\Temp\Nathan.txt', ap.ReadPChar);
    else
      TFile.AppendAllText('C:\Temp\Nathan.txt', 'Unknown format');
      Exit;
    end;
    Inc(cp);
  end;
end;

constructor TArgPtr.Create(LastArg: Pointer; Size: Integer);
begin
  FArgPtr := LastArg;

  // 32-bit x86 stack is generally 4-byte aligned
  FArgPtr := Align(FArgPtr + Size, 4);
end;

class function TArgPtr.Align(Ptr: Pointer; Align: Integer): Pointer;
begin
  Integer(Result) := (Integer(Ptr) + Align - 1) and not (Align - 1);
end;

function TArgPtr.ReadInt32: Integer;
begin
  ReadArg(Result, SizeOf(Integer));
end;

function TArgPtr.ReadDouble: Double;
begin
  ReadArg(Result, SizeOf(Double));
end;

function TArgPtr.ReadExtended: Extended;
begin
  ReadArg(Result, SizeOf(Extended));
end;

function TArgPtr.ReadPChar: PChar;
begin
  ReadArg(Result, SizeOf(PChar));
end;

procedure TArgPtr.ReadArg(var Arg; Size: Integer);
begin
  Move(FArgPtr^, Arg, Size);
  FArgPtr := Align(FArgPtr + Size, 4);
end;

function AsDouble(e: Extended): Double;
begin
  Result := e;
end;

function AsSingle(e: Extended): Single;
begin
  Result := e;
end;

procedure Go;
begin
  MyDump := @Dump;

  MyDump('iii', 10, 20, 30);
  MyDump('sss', 'foo', 'bar', 'baz');

  // Looks like Delphi passes Extended in byte-aligned stack offset, very strange; thus this doesn't work.
  MyDump('e', 2.0);

  // These two are more reliable.
  MyDump('d', AsDouble(2));

  // Singles passed as 8-byte floats.
  MyDump('d', AsSingle(2));
end;








//procedure MyWrite_; cdecl;
//begin
//  // ... some magic here ...
//end;

// function _Print(const S: String): string; cdecl;
// var
// Args: Array[0..100] of Pointer absolute S;
// I: Integer;
// begin
// I := 0;
// while Args[I] <> nil do
// begin
// WriteLn(PString(@Args[I])^);
// Inc(I);
// end;
// end;

//function _Print(NumStrings: Integer; const Strings: string): string; cdecl;
function _Print(const Strings: string): string; cdecl;
var
  Args: Array [0 .. 100] of Pointer absolute Strings;
  I: Integer;
  cp: PChar;
  Actual: string;
begin
  Actual := '';
//   for I := 0 to NumStrings-1 do
//   WriteLn(PString(@Strings[I])^);
  cp := PChar(Strings);
  if cp^ = #0 then
    Exit;


  I := 0;
  Actual := Actual + PString(@Args[I])^;

  I := 0;
  while Args[I] <> nil do
  begin
    if I = 6 then
      Exit;

//    WriteLn(PString(@Args[I])^);
    Actual := Actual + PString(@Args[I])^;
    Inc(I);
  end;

  // for I := 0 to NumStrings-1 do
  // WriteLn(PString(@Args[I])^);

  TFile.AppendAllText('C:\Temp\Nathan.txt', Actual);
end;

const
  //  Print: function(const S: String): string; cdecl varargs = _Print;
  //  Print: function(NumStrings: Integer; const Strings: string): string; cdecl varargs = _Print;
  Print: function(const Strings: string): string; cdecl varargs = _Print;

//var
//  MyWrite: procedure; cdecl varargs = MyWrite_;

procedure TTestNathanTupleCheckOut.Test_CheckOut();
var
  Actual: string;
  A, B: string;
  v: TValue;
begin
  Actual := 'Chanan';
  v := TValue.From(Actual);
  Actual := v.ToString;

  v := TValue.From<string>(Actual);
//  v.MakeWithoutCopy();
  Actual := v.ToString;

  //  MyWrite(1);
  //  MyWrite(1, 2);
  //  MyWrite(1, 2, 3);

//  A := 'ABC';
//  B := 'CDE';
//  Print(A, B, 'Hallo', 'World', 1234, 47.11, 'Nathan');

  // Arrange...
  Actual := '';

  // Act...
  Actual := Actual + '1';
//  Go();

  // Assert...
  Assert.AreEqual('1', Actual);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNathanTupleCheckOut, 'CheckOut');

end.
