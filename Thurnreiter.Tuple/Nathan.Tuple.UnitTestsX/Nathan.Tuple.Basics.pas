unit Nathan.Tuple.Basics;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  DUnitX.TestFramework,
  Nathan.Tuple;

type
  TMyReturn = record
    MyInteger: Integer;
    MyFirstString: string;
    MySecondString: string;
  end;

  TDemoTupleClass = class(TObject)
    function GetEmployee(): TList<ITuple<Integer, string, string>>;
    function GetSomethingWithMakeTuple(): ITuple<Integer, string>;
    function GetSomethingWithoutTuple(): TMyReturn;
  end;

  [TestFixture]
  TTestNathanTupleBasics = class(TObject)
  public
    [Test]
    procedure Test_ToString();

    [Test]
    procedure Test_ListOfTupleDemo_ToString();

    [Test]
    procedure Test_make_tuple_WithHelper();

    [Test]
    procedure Test_make_tuple_FromReturnValue();

    [Test]
    procedure Test_make_tuple_WithoutHelper();

    [Test]
    procedure Test_make_tuple_WithHelper_WrongArgumentList();
  end;

implementation

function TDemoTupleClass.GetEmployee(): TList<ITuple<Integer, string, string>>;
begin
  Result := TList<ITuple<Integer, string, string>>.Create();
  Result.Add(TTuple<Integer, string, string>.Create(1, 'Zürich', 'Switzerland'));
  Result.Add(TTuple<Integer, string, string>.Create(2, 'Ravensburg', 'Germany'));
end;

function TDemoTupleClass.GetSomethingWithMakeTuple(): ITuple<Integer, string>;
begin
  Result := TTuple<Integer, string>.make_tuple([4712, 'Nathan']);
end;

function TDemoTupleClass.GetSomethingWithoutTuple(): TMyReturn;
begin
  Result.MyInteger := 4711;
  Result.MyFirstString := '1.';
  Result.MySecondString := '2.';
end;

procedure TTestNathanTupleBasics.Test_ToString();
var
  Actual: string;
  Cut: ITuple<String, Integer>;
begin
  //  Arrange...
  //  Create a three item tuple...
  Cut := TTuple<String, Integer>.Create('California', 29760021);

  //  Act...
  Actual := Cut.ToString;

  //  Assert...
  Assert.AreEqual('California', Cut.Item1);
  Assert.AreEqual(29760021, Cut.Item2);
  Assert.AreEqual('(California, 29760021)', Actual);
end;

procedure TTestNathanTupleBasics.Test_ListOfTupleDemo_ToString();
var
  Actual: string;
  ActualDemo: TDemoTupleClass;
  ActualList: TList<ITuple<Integer, string, string>>;
  Cut: ITuple<Integer, string, string>;
begin
  ActualDemo := TDemoTupleClass.Create;
  try
    ActualList := ActualDemo.GetEmployee;
    try
      Assert.AreEqual(2, ActualList.Count);

      Actual := '';
      for Cut in ActualList do
        Actual := Actual + Cut.ToString + sLineBreak;

      Assert.AreEqual('(1, Zürich, Switzerland)'#$D#$A'(2, Ravensburg, Germany)'#$D#$A, Actual);
    finally
      ActualList.Free;
    end;
  finally
    ActualDemo.Free;
  end;
end;

procedure TTestNathanTupleBasics.Test_make_tuple_FromReturnValue();
var
  ActualDemoClass: TDemoTupleClass;
  ActualReturn: ITuple<Integer, string>;
begin
  ActualDemoClass := TDemoTupleClass.Create;
  try
    ActualReturn := ActualDemoClass.GetSomethingWithMakeTuple();
    Assert.AreEqual(4712, ActualReturn.Item1);
    Assert.AreEqual('Nathan', ActualReturn.Item2);
  finally
    ActualDemoClass.Free;
  end;
end;

procedure TTestNathanTupleBasics.Test_make_tuple_WithHelper();
var
  Cut: ITuple<Integer, String>;
begin
  Cut := TTuple<Integer, String>.make_tuple([4711, 'Hello world']);

  Assert.IsNotNull(Cut);
  Assert.AreEqual(4711, Cut.Item1);
  Assert.AreEqual('Hello world', Cut.Item2);

  Cut.Item2 := '';
  Assert.AreEqual('', Cut.Item2);
end;

procedure TTestNathanTupleBasics.Test_make_tuple_WithoutHelper();
var
  Cut: ITuple<Integer, String>;
begin
  Cut := TTuple<Integer, String>.Create(4711, 'Hello world');

  Assert.IsNotNull(Cut);
  Assert.AreEqual(4711, Cut.Item1);
  Assert.AreEqual('Hello world', Cut.Item2);

  Cut.Item2 := '';
  Assert.AreEqual('', Cut.Item2);
end;

procedure TTestNathanTupleBasics.Test_make_tuple_WithHelper_WrongArgumentList();
var
  Cut: ITuple<Integer, String>;
begin
  {$REGION 'Info'}
  //  http://www.delphipraxis.net/185937-e2232-interface-x-besitzt-keine-interface-identifikation.html
  //  // How to get an Interface
  //  if LMy.QueryInterface(IMyIntfA, LIMyA) = S_OK then
  //  // or
  //  if Supports(LMy, IMyIntfA, LIMyA) then
  {$ENDREGION}

  Assert.WillRaise(procedure
    begin
      Cut := TTuple<Integer, String>.make_tuple([4711, 25.88]);
    end, EInvalidCast);

  Assert.IsNull(Cut);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNathanTupleBasics, 'Basics');

end.

