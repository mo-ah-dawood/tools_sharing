import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addedBy => 'Added by';

  @override
  String get all => 'All';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get appTitle => 'Tools share';

  @override
  String get back => 'Back';

  @override
  String get backTo => 'Back to ';

  @override
  String get balance => 'Your balance';

  @override
  String get category => 'Category';

  @override
  String get changeEmail => 'Change email';

  @override
  String get charge => 'Charge';

  @override
  String get check => 'Check';

  @override
  String get completeOrders => 'Complete order';

  @override
  String get condition => 'Tool condition';

  @override
  String get confirmationCode => 'Email confirmation code';

  @override
  String get confirmationLinkSendToYourEmail => 'Confirmation link was send to your email please verify your account';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get currencyDisplay => ' L.E';

  @override
  String get dark => 'Dark';

  @override
  String get dataUpdated => 'Data updated successfully';

  @override
  String get day => 'Day';

  @override
  String get dayPrice => 'Day price';

  @override
  String get dayPriceHint => 'The price for each 24 hour';

  @override
  String get days => 'Days of rent';

  @override
  String get delete => 'Delete';

  @override
  String get description => 'Description';

  @override
  String get dontGetEmail => 'Don\'t get it?';

  @override
  String get dontHaveAccount => 'Don\'t have account?';

  @override
  String get email => 'Email';

  @override
  String endsAt(Object date) {
    return 'Ends at $date';
  }

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get gotIt => 'Got it!';

  @override
  String get image => 'Image';

  @override
  String get language => 'Language';

  @override
  String get languageDisplay => 'English';

  @override
  String get light => 'Light';

  @override
  String get linkWithGoogle => 'Link account';

  @override
  String get loadingPleaseWait => 'Loading please wait';

  @override
  String get location => 'Location';

  @override
  String get locationPermissionDenied => 'Location permissions are denied.';

  @override
  String get locationPermissionPermanentlyDenied => 'Location permissions are permanently denied, we cannot request permissions.';

  @override
  String get locationServiceDisabled => 'Location services are disabled.';

  @override
  String get login => 'Login';

  @override
  String get loginWithGoogle => 'Login with google';

  @override
  String get logout => 'Logout';

  @override
  String get manufacture => 'Manufacture';

  @override
  String get more => 'More';

  @override
  String get mustBeValidPhoneNumber => 'Must be valid egyptian phone';

  @override
  String get myTools => 'My tools';

  @override
  String get name => 'Name';

  @override
  String get next => 'Next';

  @override
  String get noOneOrderedFromYou => 'No one ordered from you till now';

  @override
  String get noToolsFound => 'No tools found';

  @override
  String get or => '-- Or --';

  @override
  String get orders => 'Orders';

  @override
  String get ownerDetails => 'Owner data';

  @override
  String get password => 'Password';

  @override
  String get passwordDontMatch => 'Sorry! confirm password don\'t match password';

  @override
  String get phone => 'Phone';

  @override
  String get pleaseAddTools => 'Please add tools to complete order';

  @override
  String get received => 'Received';

  @override
  String get register => 'Register';

  @override
  String get rentedByMe => 'I rented it';

  @override
  String get rentedFromMe => 'Rented from me';

  @override
  String get resetLinkSentToYourEmail => 'The password reset link was send to your email';

  @override
  String get search => 'Search here';

  @override
  String get send => 'Send';

  @override
  String get sendAgain => 'Send agian';

  @override
  String get successFullyAddedTheOrder => 'Your order was successfully done, you can now review owner details in your orders screen';

  @override
  String get sure => 'Sure!';

  @override
  String get system => 'System';

  @override
  String get tenantDetails => 'Tenant data';

  @override
  String get termsAndConditionsApproval => 'Accept terms and conditions';

  @override
  String get theme => 'Theme mode';

  @override
  String get toolBecomeAvailble => 'Tool is now available for rent';

  @override
  String get toolHint => 'You will bear the costs of any loss that occurs to the equipment during its rental period';

  @override
  String get toolRentedFromOthers => 'Tool is rented from someone else you can not rent it at this time';

  @override
  String get tools => 'Tools';

  @override
  String get value => 'Value';

  @override
  String get walletCharge => 'Wallet charge';

  @override
  String welcome(Object user) {
    return 'Welcome $user';
  }

  @override
  String willBeAvalibleAt(Object day) {
    return 'This tool is rented will be availble on $day';
  }

  @override
  String get youDontMakeAnyOrder => 'You don\'t make any order yet';

  @override
  String yourWalletSuccessFullyChargedWith(Object value) {
    return 'Your wallet successfully charged with $value L.E';
  }

  @override
  String get youShouldChargeWallet => 'You should charge your wallet first';

  @override
  String get youShouldCompleteYourProfile => 'You should complete your profile first before you can continue';
}
