unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TformLogin = class(TForm)
    footer: TLayout;
    zaposleniText: TText;
    header: TLayout;
    klijent: TLayout;
    usernameLinija: TLine;
    usernameLabel: TLabel;
    editUsername: TEdit;
    sifraLinija: TLine;
    labelSifra: TLabel;
    editSifra: TEdit;
    buttonLogin: TButton;
    registracijaText: TText;
    cbPrikaziSifru: TCheckBox;
    Image1: TImage;
    procedure registracijaTextClick(Sender: TObject);
    procedure buttonLoginClick(Sender: TObject);
    procedure cbPrikaziSifruChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formLogin: TformLogin;

implementation

uses
  unit2, unit3,Strana1;  // Make sure to import the unit containing the 'pocetna' form

{$R *.fmx}

procedure TformLogin.buttonLoginClick(Sender: TObject);
var
  pwd: string;
begin
  if Trim(editUsername.Text) = '' then
  begin
    Showmessage('Molimo unesite email!');
    editUsername.SetFocus;
  end
  else if Trim(editSifra.Text) = '' then
  begin
    Showmessage('Molimo unesite sifru!');
    editSifra.SetFocus;
  end
  else
  begin
    // Validacija
    with db do
    begin
      database.Open;
      qtemp.SQL.Clear;
      qtemp.SQL.Text := 'SELECT * FROM korisnici WHERE username=' + QuotedStr(editUsername.Text);
      qtemp.Open;
      if qtemp.RecordCount = 0 then
      begin
        ShowMessage('Neispravan email ili sifra!');
        editUsername.SetFocus;
      end
      else
      begin
        pwd := qtemp.FieldByName('password').AsString;
        if pwd = editSifra.Text then
        begin
          self.Hide;
          pocetna.Show;  // Show the 'pocetna' form on successful login
        end
        else
        begin
          ShowMessage('Neispravan email ili sifra!');
          editSIfra.SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TformLogin.cbPrikaziSifruChange(Sender: TObject);
begin
  editSifra.Password := not cbPrikaziSifru.IsChecked;
end;

procedure TformLogin.registracijaTextClick(Sender: TObject);
begin
  formLogin.Hide;
  formRegister.Show;
end;

end.

