unit Nathan.Tuple.OrdinalTypes;

interface

uses
  DUnitX.TestFramework,
  Nathan.Tuple;

type
  [TestFixture]
  TTestNathanTupleOrdinal = class(TObject)
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure Test_HasCreated();

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1T2(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1T2T3(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1T2T3T4(const ChangeValue: Boolean);

    [Test]
    [TestCase('ChangeValueF','False')]
    [TestCase('ChangeValueT','True')]
    procedure Test_OrdinalType_T1T2T3T4T5T6T7T8(const ChangeValue: Boolean);

    [Test]
    procedure Test_OrdinalTypes_T1T2T3_DifferentTypes();
  end;

implementation

procedure TTestNathanTupleOrdinal.Setup;
begin
end;

procedure TTestNathanTupleOrdinal.TearDown;
begin
end;

procedure TTestNathanTupleOrdinal.Test_HasCreated();
var
  Cut: ITuple<Integer>;
begin
  Cut := TTuple<Integer>.Create(4711);
  Assert.IsNotNull(Cut);
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalType_T1(const ChangeValue: Boolean);
var
  Cut: ITuple<Integer>;
begin
  //  Arrange...
  Cut := TTuple<Integer>.Create(4711);

  //  Act...
  //  Assert...
  Assert.AreEqual(4711, Cut.Item1);
  Assert.IsNotNull(Cut);

  if ChangeValue then
  begin
    Cut.Item1 := 4712;
    Assert.AreEqual(4712, Cut.Item1);
  end;
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalType_T1T2(const ChangeValue: Boolean);
var
  Cut: ITuple<Integer, Integer>;
begin
  Cut := TTuple<Integer, Integer>.Create(10, 11);

  Assert.AreEqual(10, Cut.Item1);
  Assert.AreEqual(11, Cut.Item2);

  if ChangeValue then
  begin
    Cut.Item1 := 20;
    Cut.Item2 := 21;

    Assert.AreEqual(20, Cut.Item1);
    Assert.AreEqual(21, Cut.Item2);
  end;
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalType_T1T2T3(const ChangeValue: Boolean);
var
  Cut: ITuple<Integer, Integer, Integer>;
begin
  Cut := TTuple<Integer, Integer, Integer>.Create(10, 11, 12);

  Assert.AreEqual(10, Cut.Item1);
  Assert.AreEqual(11, Cut.Item2);
  Assert.AreEqual(12, Cut.Item3);

  if ChangeValue then
  begin
    Cut.Item1 := 20;
    Cut.Item2 := 21;
    Cut.Item3 := 22;

    Assert.AreEqual(20, Cut.Item1);
    Assert.AreEqual(21, Cut.Item2);
    Assert.AreEqual(22, Cut.Item3);
  end;
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalType_T1T2T3T4(const ChangeValue: Boolean);
var
  Cut: ITuple<Integer, Integer, Integer, Integer>;
begin
  Cut := TTuple<Integer, Integer, Integer, Integer>.Create(10, 11, 12, 13);

  Assert.AreEqual(10, Cut.Item1);
  Assert.AreEqual(11, Cut.Item2);
  Assert.AreEqual(12, Cut.Item3);
  Assert.AreEqual(13, Cut.Item4);

  if ChangeValue then
  begin
    Cut.Item1 := 40;
    Cut.Item2 := 41;
    Cut.Item3 := 42;
    Cut.Item4 := 43;

    Assert.AreEqual(40, Cut.Item1);
    Assert.AreEqual(41, Cut.Item2);
    Assert.AreEqual(42, Cut.Item3);
    Assert.AreEqual(43, Cut.Item4);
  end;
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalType_T1T2T3T4T5T6T7T8(const ChangeValue: Boolean);
var
  Cut: ITuple<Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer>;
begin
  Cut := TTuple<Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer>
    .Create(10, 11, 12, 13, 14, 15, 16, 17);

  Assert.AreEqual(10, Cut.Item1);
  Assert.AreEqual(11, Cut.Item2);
  Assert.AreEqual(12, Cut.Item3);
  Assert.AreEqual(13, Cut.Item4);
  Assert.AreEqual(14, Cut.Item5);
  Assert.AreEqual(15, Cut.Item6);
  Assert.AreEqual(16, Cut.Item7);
  Assert.AreEqual(17, Cut.Item8);

  if ChangeValue then
  begin
    Cut.Item1 := 40;
    Cut.Item2 := 41;
    Cut.Item3 := 42;
    Cut.Item4 := 43;
    Cut.Item5 := 44;
    Cut.Item6 := 45;
    Cut.Item7 := 46;
    Cut.Item8 := 47;

    Assert.AreEqual(40, Cut.Item1);
    Assert.AreEqual(41, Cut.Item2);
    Assert.AreEqual(42, Cut.Item3);
    Assert.AreEqual(43, Cut.Item4);
    Assert.AreEqual(44, Cut.Item5);
    Assert.AreEqual(45, Cut.Item6);
    Assert.AreEqual(46, Cut.Item7);
    Assert.AreEqual(47, Cut.Item8);
  end;
end;

procedure TTestNathanTupleOrdinal.Test_OrdinalTypes_T1T2T3_DifferentTypes;
var
  Cut: ITuple<Integer, Byte, Word>;
begin
  Cut := TTuple<Integer, Byte, Word>.Create(-1000, 4, 65535);

  Assert.AreEqual(-1000, Cut.Item1);
  Assert.AreEqual(Byte(4), Cut.Item2);
  Assert.AreEqual(65535, Cut.Item3);

  Cut.Item1 := 0;
  Cut.Item2 := 1;
  Cut.Item3 := 2;

  Assert.AreEqual(0, Cut.Item1);
  Assert.AreEqual(Byte(1), Cut.Item2);
  Assert.AreEqual(2, Cut.Item3);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNathanTupleOrdinal, 'Ordinal');

end.
