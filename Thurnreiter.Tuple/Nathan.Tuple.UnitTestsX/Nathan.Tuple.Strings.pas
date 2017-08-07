unit Nathan.Tuple.Strings;

interface

uses
  DUnitX.TestFramework,
  Nathan.Tuple;

type
  [TestFixture]
  TTestNathanTupleStrings = class(TObject)
  public
    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1T2T3T4T5T6T7T8(const ChangeValue: Boolean);
  end;

implementation

procedure TTestNathanTupleStrings.Test_OrdinalType_T1(const ChangeValue: Boolean);
var
  Cut: ITuple<String>;
begin
  //  Arrange...
  Cut := TTuple<String>.Create('abc');

  //  Act...
  //  Assert...
  Assert.AreEqual('abc', Cut.Item1);
  Assert.IsNotNull(Cut);

  if ChangeValue then
  begin
    Cut.Item1 := 'abcd';
    Assert.AreEqual('abcd', Cut.Item1);
  end;
end;

procedure TTestNathanTupleStrings.Test_OrdinalType_T1T2T3T4T5T6T7T8(const ChangeValue: Boolean);
var
  Cut: ITuple<String, String, String, String, String, String, String, String>;
begin
  Cut := TTuple<String, String, String, String, String, String, String, String>
    .Create('10', '11', '12', '13', 'LongValue14', '15', '16', '17');

  Assert.AreEqual('10', Cut.Item1);
  Assert.AreEqual('11', Cut.Item2);
  Assert.AreEqual('12', Cut.Item3);
  Assert.AreEqual('13', Cut.Item4);
  Assert.AreEqual('LongValue14', Cut.Item5);
  Assert.AreEqual('15', Cut.Item6);
  Assert.AreEqual('16', Cut.Item7);
  Assert.AreEqual('17', Cut.Item8);

  if ChangeValue then
  begin
    Cut.Item1 := '40';
    Cut.Item2 := '41';
    Cut.Item3 := '42';
    Cut.Item4 := '43';
    Cut.Item5 := '44';
    Cut.Item6 := '45';
    Cut.Item7 := '46';
    Cut.Item8 := '47';

    Assert.AreEqual('40', Cut.Item1);
    Assert.AreEqual('41', Cut.Item2);
    Assert.AreEqual('42', Cut.Item3);
    Assert.AreEqual('43', Cut.Item4);
    Assert.AreEqual('44', Cut.Item5);
    Assert.AreEqual('45', Cut.Item6);
    Assert.AreEqual('46', Cut.Item7);
    Assert.AreEqual('47', Cut.Item8);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNathanTupleStrings, 'Strings');

end.
