import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @addedBy.
  ///
  /// In en, this message translates to:
  /// **'Added by'**
  String get addedBy;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Tools share'**
  String get appTitle;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @backTo.
  ///
  /// In en, this message translates to:
  /// **'Back to '**
  String get backTo;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get balance;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @charge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get charge;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @completeOrders.
  ///
  /// In en, this message translates to:
  /// **'Complete order'**
  String get completeOrders;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Tool condition'**
  String get condition;

  /// No description provided for @confirmationCode.
  ///
  /// In en, this message translates to:
  /// **'Email confirmation code'**
  String get confirmationCode;

  /// No description provided for @confirmationLinkSendToYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirmation link was send to your email please verify your account'**
  String get confirmationLinkSendToYourEmail;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @currencyDisplay.
  ///
  /// In en, this message translates to:
  /// **' L.E'**
  String get currencyDisplay;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @dataUpdated.
  ///
  /// In en, this message translates to:
  /// **'Data updated successfully'**
  String get dataUpdated;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @dayPrice.
  ///
  /// In en, this message translates to:
  /// **'Day price'**
  String get dayPrice;

  /// No description provided for @dayPriceHint.
  ///
  /// In en, this message translates to:
  /// **'The price for each 24 hour'**
  String get dayPriceHint;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days of rent'**
  String get days;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @dontGetEmail.
  ///
  /// In en, this message translates to:
  /// **'Don\'t get it?'**
  String get dontGetEmail;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get dontHaveAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @endsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends at {date}'**
  String endsAt(Object date);

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDisplay.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageDisplay;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @linkWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Link account'**
  String get linkWithGoogle;

  /// No description provided for @loadingPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Loading please wait'**
  String get loadingPleaseWait;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied.'**
  String get locationPermissionDenied;

  /// No description provided for @locationPermissionPermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied, we cannot request permissions.'**
  String get locationPermissionPermanentlyDenied;

  /// No description provided for @locationServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get locationServiceDisabled;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with google'**
  String get loginWithGoogle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @manufacture.
  ///
  /// In en, this message translates to:
  /// **'Manufacture'**
  String get manufacture;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @mustBeValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Must be valid egyptian phone'**
  String get mustBeValidPhoneNumber;

  /// No description provided for @myTools.
  ///
  /// In en, this message translates to:
  /// **'My tools'**
  String get myTools;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @noOneOrderedFromYou.
  ///
  /// In en, this message translates to:
  /// **'No one ordered from you till now'**
  String get noOneOrderedFromYou;

  /// No description provided for @noToolsFound.
  ///
  /// In en, this message translates to:
  /// **'No tools found'**
  String get noToolsFound;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'-- Or --'**
  String get or;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @ownerDetails.
  ///
  /// In en, this message translates to:
  /// **'Owner data'**
  String get ownerDetails;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Sorry! confirm password don\'t match password'**
  String get passwordDontMatch;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @pleaseAddTools.
  ///
  /// In en, this message translates to:
  /// **'Please add tools to complete order'**
  String get pleaseAddTools;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @rentedByMe.
  ///
  /// In en, this message translates to:
  /// **'I rented it'**
  String get rentedByMe;

  /// No description provided for @rentedFromMe.
  ///
  /// In en, this message translates to:
  /// **'Rented from me'**
  String get rentedFromMe;

  /// No description provided for @resetLinkSentToYourEmail.
  ///
  /// In en, this message translates to:
  /// **'The password reset link was send to your email'**
  String get resetLinkSentToYourEmail;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get search;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send agian'**
  String get sendAgain;

  /// No description provided for @successFullyAddedTheOrder.
  ///
  /// In en, this message translates to:
  /// **'Your order was successfully done, you can now review owner details in your orders screen'**
  String get successFullyAddedTheOrder;

  /// No description provided for @sure.
  ///
  /// In en, this message translates to:
  /// **'Sure!'**
  String get sure;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @tenantDetails.
  ///
  /// In en, this message translates to:
  /// **'Tenant data'**
  String get tenantDetails;

  /// No description provided for @termsAndConditionsApproval.
  ///
  /// In en, this message translates to:
  /// **'Accept terms and conditions'**
  String get termsAndConditionsApproval;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get theme;

  /// No description provided for @toolBecomeAvailble.
  ///
  /// In en, this message translates to:
  /// **'Tool is now available for rent'**
  String get toolBecomeAvailble;

  /// No description provided for @toolHint.
  ///
  /// In en, this message translates to:
  /// **'You will bear the costs of any loss that occurs to the equipment during its rental period'**
  String get toolHint;

  /// No description provided for @toolRentedFromOthers.
  ///
  /// In en, this message translates to:
  /// **'Tool is rented from someone else you can not rent it at this time'**
  String get toolRentedFromOthers;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @walletCharge.
  ///
  /// In en, this message translates to:
  /// **'Wallet charge'**
  String get walletCharge;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome {user}'**
  String welcome(Object user);

  /// No description provided for @willBeAvalibleAt.
  ///
  /// In en, this message translates to:
  /// **'This tool is rented will be availble on {day}'**
  String willBeAvalibleAt(Object day);

  /// No description provided for @youDontMakeAnyOrder.
  ///
  /// In en, this message translates to:
  /// **'You don\'t make any order yet'**
  String get youDontMakeAnyOrder;

  /// No description provided for @yourWalletSuccessFullyChargedWith.
  ///
  /// In en, this message translates to:
  /// **'Your wallet successfully charged with {value} L.E'**
  String yourWalletSuccessFullyChargedWith(Object value);

  /// No description provided for @youShouldChargeWallet.
  ///
  /// In en, this message translates to:
  /// **'You should charge your wallet first'**
  String get youShouldChargeWallet;

  /// No description provided for @youShouldCompleteYourProfile.
  ///
  /// In en, this message translates to:
  /// **'You should complete your profile first before you can continue'**
  String get youShouldCompleteYourProfile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
