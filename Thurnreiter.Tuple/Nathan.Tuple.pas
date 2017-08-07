unit Nathan.Tuple;

interface

uses
  System.Rtti;

type

  {$REGION 'Inspired by the following templates'}
  {
    https://msdn.microsoft.com/de-de/library/system.tuple(v=vs.110).aspx
    https://github.com/malcolmgroves/generics.tuples/blob/master/src/tests/Generics.Tuples.Test.pas
    https://msdn.microsoft.com/de-de/library/bb982346.aspx
    http://en.cppreference.com/w/cpp/utility/tuple/make_tuple
    https://stackoverflow.com/questions/40914165/stdtie-vs-stdmake-tuple
    http://hallvards.blogspot.ch/2006/06/simple-interface-rtti.html

    Why to use Tuple?
    https://stackoverflow.com/questions/2745426/practical-example-where-tuple-can-be-used-in-net-4-0


    TDemoTupleClass = class(TObject)
      function GetSomethingWithoutTuple(): <Integer, string, string>;   <-- This is not possible...
    end;

    We are need a Record or struct. Somethinge like this:
    TMyReturn = record
      MyInteger: Integer;
      MyFirstString: string;
      MySecondString: string;
    end;

    TDemoTupleClass = class(TObject)
      function GetSomethingWithoutTuple(): TMyReturn;
    end;

    Tuple are a kind of sugar code and make it easier to return multiple return values.

    TDemoTupleClass = class(TObject)
      function GetSomethingWithoutTuple(): ITuple<Integer, string, string>;
    end;

  }
  {$ENDREGION}

{$M+}

  ITuple = interface
    ['{75E287BB-C16C-450E-9C3D-B2B32FC21B0E}']
    function ToString(): string;
  end;

  ITuple<T1> = interface(ITuple)
    ['{AB7B726B-760E-40CC-A75F-C426E6B870E3}']
    procedure SetItem1(Item: T1);
    function GetItem1(): T1;

    property Item1: T1 read GetItem1 write SetItem1;
  end;

  ITuple<T1, T2> = interface(ITuple<T1>)
    ['{24BF6AE8-F040-43DD-9AE7-FFFF7E600CF1}']
    procedure SetItem2(Item: T2);
    function GetItem2(): T2;

    property Item2: T2 read GetItem2 write SetItem2;
  end;

  ITuple<T1, T2, T3> = interface(ITuple<T1, T2>)
    ['{9EAE97E5-2C8C-4933-AD2D-C847C8570714}']
    procedure SetItem3(Item: T3);
    function GetItem3(): T3;

    property Item3: T3 read GetItem3 write SetItem3;
  end;

  ITuple<T1, T2, T3, T4> = interface(ITuple<T1, T2, T3>)
    ['{12F246FB-19BF-44CB-8C1B-5F0CF584EA62}']
    procedure SetItem4(Item : T4);
    function GetItem4(): T4;

    property Item4: T4 read GetItem4 write SetItem4;
  end;

  ITuple<T1, T2, T3, T4, T5> = interface(ITuple<T1, T2, T3, T4>)
    ['{86B66C13-CC15-4EDC-AFDA-90F26B68EF60}']
    procedure SetItem5(Item : T5);
    function GetItem5(): T5;

    property Item5: T5 read GetItem5 write SetItem5;
  end;

  ITuple<T1, T2, T3, T4, T5, T6> = interface(ITuple<T1, T2, T3, T4, T5>)
    ['{C99040FD-8760-499D-B3BF-A40A8B91B1F7}']
    procedure SetItem6(Item : T6);
    function GetItem6(): T6;

    property Item6: T6 read GetItem6 write SetItem6;
  end;

  ITuple<T1, T2, T3, T4, T5, T6, T7> = interface(ITuple<T1, T2, T3, T4, T5, T6>)
    ['{7FCD39F4-99F0-4861-AC2E-B38D626737DF}']
    procedure SetItem7(Item : T7);
    function GetItem7(): T7;

    property Item7: T7 read GetItem7 write SetItem7;
  end;

  ITuple<T1, T2, T3, T4, T5, T6, T7, T8> = interface(ITuple<T1, T2, T3, T4, T5, T6, T7>)
    ['{2A6F841B-8C12-48F9-88F8-F66EF9DDE0ED}']
    procedure SetItem8(Item : T8);
    function GetItem8(): T8;

    property Item8: T8 read GetItem8 write SetItem8;
  end;


  TTuple = class(TInterfacedObject, ITuple)
  public
    function ToString(): string; override;
  end;

  TTuple<T1> = class(TTuple, ITuple<T1>)
  strict private
    FItem1: T1;
  private
    procedure SetItem1(Item: T1);
    function GetItem1: T1;
  public
    constructor Create(Item1: T1);
  end;

  TTuple<T1, T2> = class(TTuple<T1>, ITuple<T1, T2>)
  strict private
    FItem2: T2;
  private
    procedure SetItem2(Item: T2);
    function GetItem2(): T2;
  public
    constructor Create(Item1: T1; Item2: T2);
  end;

  TTuple<T1, T2, T3> = class(TTuple<T1, T2>, ITuple<T1, T2, T3>)
  strict private
    FItem3: T3;
  private
    procedure SetItem3(Item: T3);
    function GetItem3(): T3;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3);
  end;

  TTuple<T1, T2, T3, T4> = class(TTuple<T1, T2, T3>, ITuple<T1, T2, T3, T4>)
  strict private
    FItem4: T4;
  private
    procedure SetItem4(Item: T4);
    function GetItem4(): T4;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4);
  end;

  TTuple<T1, T2, T3, T4, T5> = class(TTuple<T1, T2, T3, T4>, ITuple<T1, T2, T3, T4, T5>)
  strict private
    FItem5: T5;
  private
    procedure SetItem5(Item: T5);
    function GetItem5(): T5;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4; Item5: T5);
  end;

  TTuple<T1, T2, T3, T4, T5, T6> = class(TTuple<T1, T2, T3, T4, T5>, ITuple<T1, T2, T3, T4, T5, T6>)
  strict private
    FItem6: T6;
  private
    procedure SetItem6(Item: T6);
    function GetItem6(): T6;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4; Item5: T5; Item6: T6);
  end;

  TTuple<T1, T2, T3, T4, T5, T6, T7> = class(TTuple<T1, T2, T3, T4, T5, T6>, ITuple<T1, T2, T3, T4, T5, T6, T7>)
  strict private
    FItem7: T7;
  private
    procedure SetItem7(Item: T7);
    function GetItem7(): T7;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4; Item5: T5; Item6: T6; Item7: T7);
  end;

  TTuple<T1, T2, T3, T4, T5, T6, T7, T8> = class(TTuple<T1, T2, T3, T4, T5, T6, T7>, ITuple<T1, T2, T3, T4, T5, T6, T7, T8>)
  strict private
    FItem8: T8;
  private
    procedure SetItem8(Item: T8);
    function GetItem8(): T8;
  public
    constructor Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4; Item5: T5; Item6: T6; Item7: T7; Item8: T8);
  end;

  TTupleHelper = class helper for TTuple
  public
    constructor make_tuple(Values: TArray<TValue>);
  end;


{$M-}

implementation

uses
  System.SysUtils,
  System.TypInfo;

{ **************************************************************************** }

{ TTuple }

function TTuple.ToString: string;
var
  Ctx: TRttiContext;
  CtxType: TRttiType;
  CtxField: TRttiField;
begin
  //  Result := inherited; v := TValue.From(self); if v.IsObject then Result := v.AsObject.ClassName;
  Ctx := TRttiContext.Create;
  try
    Result := '';
    CtxType := Ctx.GetType(Self.ClassType);

    for CtxField in CtxType.GetFields do
      if CtxField.Name.ToUpper.Contains('FITEM') then
        Result := CtxField.GetValue(Self).ToString + ', ' + Result;
  finally
    Ctx.Free;
  end;

  if (not Result.IsEmpty) then
    Result := String.Format('(%s)', [Result.Trim([' ', ','])]);
end;

{ **************************************************************************** }

{ TTuple<T1> }

constructor TTuple<T1>.Create(Item1: T1);
begin
  inherited Create;
  SetItem1(Item1);
end;

function TTuple<T1>.GetItem1(): T1;
begin
  Result := FItem1;
end;

procedure TTuple<T1>.SetItem1(Item: T1);
begin
  FItem1 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2> }

constructor TTuple<T1, T2>.Create(Item1: T1; Item2: T2);
begin
  inherited Create(Item1);
  SetItem2(Item2);
end;

function TTuple<T1, T2>.GetItem2(): T2;
begin
  Result := FItem2;
end;

procedure TTuple<T1, T2>.SetItem2(Item: T2);
begin
  FItem2 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3> }

constructor TTuple<T1, T2, T3>.Create(Item1: T1; Item2: T2; Item3: T3);
begin
  inherited Create(Item1, Item2);
  SetItem3(Item3);
end;

function TTuple<T1, T2, T3>.GetItem3(): T3;
begin
  Result := FItem3;
end;

procedure TTuple<T1, T2, T3>.SetItem3(Item: T3);
begin
  FItem3 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3, T4> }

constructor TTuple<T1, T2, T3, T4>.Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4);
begin
  inherited Create(Item1, Item2, Item3);
  SetItem4(Item4);
end;

function TTuple<T1, T2, T3, T4>.GetItem4(): T4;
begin
  Result := FItem4;
end;

procedure TTuple<T1, T2, T3, T4>.SetItem4(Item: T4);
begin
  FItem4 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3, T4, T5> }

constructor TTuple<T1, T2, T3, T4, T5>.Create(Item1: T1; Item2: T2; Item3: T3; Item4: T4; Item5: T5);
begin
  inherited Create(Item1, Item2, Item3, Item4);
  SetItem5(Item5);
end;

function TTuple<T1, T2, T3, T4, T5>.GetItem5(): T5;
begin
  Result := FItem5;
end;

procedure TTuple<T1, T2, T3, T4, T5>.SetItem5(Item: T5);
begin
  FItem5 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3, T4, T5, T6> }

constructor TTuple<T1, T2, T3, T4, T5, T6>.Create(Item1: T1; Item2: T2;
  Item3: T3; Item4: T4; Item5: T5; Item6: T6);
begin
  inherited Create(Item1, Item2, Item3, Item4, Item5);
  SetItem6(Item6);
end;

function TTuple<T1, T2, T3, T4, T5, T6>.GetItem6(): T6;
begin
  Result := FItem6;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6>.SetItem6(Item: T6);
begin
  FItem6 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3, T4, T5, T6, T7> }

constructor TTuple<T1, T2, T3, T4, T5, T6, T7>.Create(Item1: T1; Item2: T2;
  Item3: T3; Item4: T4; Item5: T5; Item6: T6; Item7: T7);
begin
  inherited Create(Item1, Item2, Item3, Item4, Item5, Item6);
  SetItem7(Item7);
end;

function TTuple<T1, T2, T3, T4, T5, T6, T7>.GetItem7(): T7;
begin
  Result := FItem7;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6, T7>.SetItem7(Item: T7);
begin
  FItem7 := Item;
end;

{ **************************************************************************** }

{ TTuple<T1, T2, T3, T4, T5, T6, T7, T8> }

constructor TTuple<T1, T2, T3, T4, T5, T6, T7, T8>.Create(Item1: T1; Item2: T2;
  Item3: T3; Item4: T4; Item5: T5; Item6: T6; Item7: T7; Item8: T8);
begin
  inherited Create(Item1, Item2, Item3, Item4, Item5, Item6, Item7);
  SetItem8(Item8);
end;

function TTuple<T1, T2, T3, T4, T5, T6, T7, T8>.GetItem8(): T8;
begin
  Result := FItem8;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6, T7, T8>.SetItem8(Item: T8);
begin
  FItem8 := Item;
end;

{ **************************************************************************** }

{ TTupleHelper }

constructor TTupleHelper.make_tuple(Values: TArray<TValue>);
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Method: TRttiMethod;
  Prop: TRttiProperty;
begin
  Ctx := TRttiContext.Create;
  try
    Typ := Ctx.GetType(ClassType);
    if not Assigned(Typ) then
      Exit;

    {$REGION 'Info'}
    //  Saples to Create an Object with RTTI...
    //    and (ATypeInfo.Kind = tkInterface)
    //    and (AClass <> nil)
    //    and (AClass.GetInterfaceEntry(GetTypeData(ATypeInfo).GUID) <> nil);
    //  for lProperty in lType.GetDeclaredProperties do
    //    Result.Add(lProperty.ToString);
    {$ENDREGION}

    Method := Typ.GetMethod('Create');
    if (not Assigned(Method)) or not Method.IsConstructor then
      Exit;

    Method.Invoke(Self, Values);
  finally
    Ctx.Free;
  end;

end;

end.
