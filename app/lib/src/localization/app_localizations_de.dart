import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get addedBy => 'Hinzugefügt von';

  @override
  String get all => 'Alle';

  @override
  String get alreadyHaveAnAccount => 'Hast du schon ein Konto?';

  @override
  String get appTitle => 'Tools teilen';

  @override
  String get back => 'Zurück';

  @override
  String get backTo => 'Zurück zu ';

  @override
  String get balance => 'Dein Kontostand';

  @override
  String get category => 'Kategorie';

  @override
  String get changeEmail => 'E-Mail ändern';

  @override
  String get charge => 'Aufladen';

  @override
  String get check => 'Prüfen';

  @override
  String get completeOrders => 'Vervollständigen Sie die Anfrage';

  @override
  String get condition => 'Zustand des Werkzeugs';

  @override
  String get confirmationCode => 'Bestätigungscode per E-Mail';

  @override
  String get confirmationLinkSendToYourEmail => 'Der Bestätigungslink wurde an Ihre E-Mail gesendet. Bitte überprüfen Sie Ihr Konto';

  @override
  String get confirmPassword => 'Bestätigen Sie das Passwort';

  @override
  String get currencyDisplay => ' L.E';

  @override
  String get dark => 'Dunkel';

  @override
  String get dataUpdated => 'Daten wurden erfolgreich aktualisiert';

  @override
  String get day => 'Tag';

  @override
  String get dayPrice => 'Tagespreis';

  @override
  String get dayPriceHint => 'Der Preis pro 24 Stunde';

  @override
  String get days => 'Miettage';

  @override
  String get delete => 'Löschen';

  @override
  String get description => 'Beschreibung';

  @override
  String get dontGetEmail => 'Verstehst du es nicht?';

  @override
  String get dontHaveAccount => 'Sie haben kein Konto?';

  @override
  String get email => 'E-Mail';

  @override
  String endsAt(Object date) {
    return 'Endet am $date';
  }

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get gotIt => 'Habe es!';

  @override
  String get image => 'Bild';

  @override
  String get language => 'Sprache';

  @override
  String get languageDisplay => 'German';

  @override
  String get light => 'Leicht';

  @override
  String get linkWithGoogle => 'Konto verknüpfen';

  @override
  String get loadingPleaseWait => 'Wird geladen, bitte warten';

  @override
  String get location => 'Standort';

  @override
  String get locationPermissionDenied => 'Standortberechtigungen werden verweigert.';

  @override
  String get locationPermissionPermanentlyDenied => 'Standortberechtigungen werden dauerhaft verweigert, wir können keine Genehmigungen anfordern.';

  @override
  String get locationServiceDisabled => 'Ortungsdienste sind deaktiviert.';

  @override
  String get login => 'Einloggen';

  @override
  String get loginWithGoogle => 'Loggen Sie sich mit Google ein';

  @override
  String get logout => 'Abmelden';

  @override
  String get manufacture => 'Herstellung';

  @override
  String get more => 'Mehr';

  @override
  String get mustBeValidPhoneNumber => 'Muss ein gültiges ägyptisches Telefon sein';

  @override
  String get myTools => 'Meine Tools';

  @override
  String get name => 'Name';

  @override
  String get next => 'Weiter';

  @override
  String get noOneOrderedFromYou => 'Bisher hat noch niemand bei Ihnen bestellt';

  @override
  String get noToolsFound => 'Keine Werkzeuge gefunden';

  @override
  String get or => '-- Oder --';

  @override
  String get orders => 'Bestellungen';

  @override
  String get ownerDetails => 'Eigentümerdaten';

  @override
  String get password => 'Passwort';

  @override
  String get passwordDontMatch => 'Es tut uns leid! Passwort bestätigen entspricht nicht dem Passwort';

  @override
  String get phone => 'Telefon';

  @override
  String get pleaseAddTools => 'Bitte fügen Sie Werkzeuge hinzu, um die Bestellung abzuschließen';

  @override
  String get received => 'Empfangen';

  @override
  String get register => 'Registrieren';

  @override
  String get rentedByMe => 'Ich habe es gemietet';

  @override
  String get rentedFromMe => 'Von mir gemietet';

  @override
  String get resetLinkSentToYourEmail => 'Der Link zum Zurücksetzen des Passworts wurde an Ihre E-Mail gesendet';

  @override
  String get search => 'Suche hier';

  @override
  String get send => 'Senden';

  @override
  String get sendAgain => 'Erneut senden';

  @override
  String get successFullyAddedTheOrder => 'Ihre Bestellung wurde erfolgreich abgeschlossen. Sie können jetzt die Eigentümerdetails in Ihrem Bestellbildschirm überprüfen';

  @override
  String get sure => 'Klar!';

  @override
  String get system => 'System';

  @override
  String get tenantDetails => 'Mieterdaten';

  @override
  String get termsAndConditionsApproval => 'Akzeptiere die Allgemeinen Geschäftsbedingungen';

  @override
  String get theme => 'Themenmodus';

  @override
  String get toolBecomeAvailble => 'Das Werkzeug kann jetzt gemietet werden';

  @override
  String get toolHint => 'Sie tragen die Kosten für etwaige Schäden, die während der Mietdauer an der Ausrüstung entstehen';

  @override
  String get toolRentedFromOthers => 'Werkzeugverleih von jemand anderem, Sie können es derzeit nicht mieten';

  @override
  String get tools => 'Werkzeuge';

  @override
  String get value => 'Wert';

  @override
  String get walletCharge => 'Gebühr für die Brieftasche';

  @override
  String welcome(Object user) {
    return 'Willkommen $user';
  }

  @override
  String willBeAvalibleAt(Object day) {
    return 'Dieses Tool wird gemietet und ist verfügbar am $day';
  }

  @override
  String get youDontMakeAnyOrder => 'Sie geben noch keine Bestellung auf';

  @override
  String yourWalletSuccessFullyChargedWith(Object value) {
    return 'Ihr Wallet wurde erfolgreich mit ${value}L.E. aufgeladen.';
  }

  @override
  String get youShouldChargeWallet => 'Sie sollten zuerst Ihren Geldbeutel aufladen';

  @override
  String get youShouldCompleteYourProfile => 'Sie sollten zuerst Ihr Profil vervollständigen, bevor Sie fortfahren können';
}
