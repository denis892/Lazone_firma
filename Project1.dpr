program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {formLogin},
  Unit2 in 'Unit2.pas' {formRegister},
  Unit3 in 'Unit3.pas' {db},
  Strana1 in 'Strana1.pas' {Pocetna};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformRegister, formRegister);
  Application.CreateForm(Tdb, db);
  Application.CreateForm(TPocetna, Pocetna);
  Application.Run;
end.
