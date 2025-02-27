﻿unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TformRegister = class(TForm)
    footer: TLayout;
    tekstZaposleniLogin: TText;
    header: TLayout;
    klijent: TLayout;
    usernameLinija: TLine;
    usernameLabel: TLabel;
    editUsername: TEdit;
    sifraLinija: TLine;
    labelSifra: TLabel;
    editSifra: TEdit;
    imeLinija: TLine;
    imeLabel: TLabel;
    editIme: TEdit;
    prezimeLinija: TLine;
    labelPrezime: TLabel;
    editPrezime: TEdit;
    emailLinija: TLine;
    labelEmail: TLabel;
    editEmail: TEdit;
    buttonRegister: TButton;
    cbPrikaziSifru: TCheckBox;
    Text2: TText;
    Image1: TImage;
    procedure tekstZaposleniLoginClick(Sender: TObject);
    procedure buttonRegisterClick(Sender: TObject);
    procedure cbPrikaziSifruChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRegister: TformRegister;

implementation

uses
  unit1, unit3;

{$R *.fmx}

procedure TformRegister.buttonRegisterClick(Sender: TObject);
var
  username, sifra, ime, prezime, email: string;
begin
  //provera da li su podaci uneti
  if trim(editUsername.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite korisnicko ime!');
    editUsername.SetFocus;
    Exit;
  end;

  if trim(editSifra.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite sifru!');
    editSifra.SetFocus;
    Exit;
  end;

  if trim(editEmail.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite email!');
    editEmail.SetFocus;
    Exit;
  end;

  if trim(editIme.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite ime!');
    editIme.SetFocus;
    Exit;
  end;

  if trim(editPrezime.Text) = '' then
  begin
    ShowMessage('Molimo vas unesite prezime!');
    editPrezime.SetFocus;
    Exit;
  end;

  // Dohvaćanje unesenih podataka
  username := editUsername.Text;
  sifra := editSifra.Text;
  ime := editIme.Text;
  prezime := editPrezime.Text;
  email := editEmail.Text;

  with db do
  begin
    database.Open;
    qtemp.SQL.Clear;
    qtemp.SQL.Text := 'SELECT COUNT(*) FROM korisnici WHERE email = :Email';
    qtemp.ParamByName('Email').AsString := email;
    qtemp.Open;
    if qtemp.Fields[0].AsInteger > 0 then
    begin
      ShowMessage('Email adresa već postoji. Molimo izaberite drugu.');
      qtemp.Close;
      database.Close;
      Exit;
    end;

    qtemp.SQL.Clear;
    qtemp.SQL.Text := 'SELECT COUNT(*) FROM korisnici WHERE username = :Username';
    qtemp.ParamByName('Username').AsString := username;
    qtemp.Open;
    if qtemp.Fields[0].AsInteger > 0 then
    begin
      ShowMessage('Username već postoji. Molimo izaberite drugi.');
      qtemp.Close;
      database.Close;
      Exit;
    end;

    qtemp.SQL.Clear;
    qtemp.SQL.Text := 'INSERT INTO korisnici (ime, prezime, username, password, email) ' +
                      'VALUES (:ime, :prezime, :username, :password, :email)';
    qtemp.Params.ParamByName('ime').AsString := ime;
    qtemp.Params.ParamByName('prezime').AsString := prezime;
    qtemp.Params.ParamByName('username').AsString := username;
    qtemp.Params.ParamByName('password').AsString := sifra;
    qtemp.Params.ParamByName('email').AsString := email;
    qtemp.ExecSQL;

    ShowMessage('Uspešno ste se registrovali!');

    formRegister.Hide;
    formLogin.Show;

    qtemp.Close;
    database.Close;
  end;
end;

procedure TformRegister.cbPrikaziSifruChange(Sender: TObject);
begin
  editSifra.Password := not cbPrikaziSifru.IsChecked;
end;

procedure TformRegister.tekstZaposleniLoginClick(Sender: TObject);
begin
  formRegister.Hide;
  formLogin.Show;
end;

end.

