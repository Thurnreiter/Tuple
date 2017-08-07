unit Nathan.Tuple.DifferentTypes;

interface

uses
  DUnitX.TestFramework,
  Nathan.Tuple;

type
  [TestFixture]
  TTestNathanTupleMixed = class(TObject)
  public
    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_MixTypes_OrdinalString(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_MixTypes_OrdinalStringObjects(const ChangeValue: Boolean);
  end;

implementation

uses
  System.Classes;

procedure TTestNathanTupleMixed.Test_MixTypes_OrdinalString(const ChangeValue: Boolean);
var
  Cut: ITuple<Double, String, Integer>;
begin
  //  Arrange...
  Cut := TTuple<Double, String, Integer>.Create(1.125, 'Nathan Chanan...', 4711);

  //  Act...
  //  Assert...
  Assert.AreEqual(1.125, Cut.Item1, 1);
  Assert.AreEqual('Nathan Chanan...', Cut.Item2);
  Assert.AreEqual(4711, Cut.Item3);

  if ChangeValue then
  begin
    Cut.Item1 := Cut.Item1 + 2.25;
    Cut.Item2 := 'Thurnreiter';
    Cut.Item3 := -8;

    Assert.AreEqual(3.375, Cut.Item1, 1);
    Assert.AreEqual('Thurnreiter', Cut.Item2);
    Assert.AreEqual(-8, Cut.Item3);
  end;
end;

procedure TTestNathanTupleMixed.Test_MixTypes_OrdinalStringObjects(const ChangeValue: Boolean);
var
  Cut: ITuple<String, Integer, TObject>;
begin
  //  Arrange...
  //  Act...
  Cut := TTuple<String, Integer, TObject>.Create('Nathan Chanan...', 4718, TObject.Create());
  try
    //  Assert...
    Assert.AreEqual('Nathan Chanan...', Cut.Item1);
    Assert.AreEqual(4718, Cut.Item2);
    Assert.AreEqual('TObject', Cut.Item3.ClassName);

    if ChangeValue then
    begin
      //  Act...
      Cut.Item1 := 'Thurnreiter';
      Cut.Item2 := 2810;
      Cut.Item3.Free;
      Cut.Item3 := TStringList.Create;

      //  Assert...
      Assert.AreEqual('Thurnreiter', Cut.Item1);
      Assert.AreEqual(2810, Cut.Item2);
      Assert.AreEqual('TStringList', Cut.Item3.ClassName);
    end;
  finally
    Cut.Item3.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNathanTupleMixed, 'Mixed');

end.
