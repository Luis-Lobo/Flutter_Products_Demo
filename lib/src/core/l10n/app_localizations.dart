import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('pt')
  ];

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to shopping cart'**
  String get addToCart;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buy;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @cardHolderNameInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert card holder name.'**
  String get cardHolderNameInsert;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cardNumberAlertLenght.
  ///
  /// In en, this message translates to:
  /// **'Card Number must have 16 numbers.'**
  String get cardNumberAlertLenght;

  /// No description provided for @cardNumberInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert number card.'**
  String get cardNumberInsert;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category: '**
  String get category;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get createAccount;

  /// No description provided for @createAccountOnFakeShopping.
  ///
  /// In en, this message translates to:
  /// **'Create an account on Fake Shopping App and enjoy the best offers'**
  String get createAccountOnFakeShopping;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description: '**
  String get description;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address:'**
  String get emailAddress;

  /// No description provided for @emailAddressInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your email address.'**
  String get emailAddressInsert;

  /// No description provided for @emailAddressInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get emailAddressInvalid;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date'**
  String get expirationDate;

  /// No description provided for @expirationDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid date format. Use MM/AA.'**
  String get expirationDateFormat;

  /// No description provided for @expirationDateInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert expiration date.'**
  String get expirationDateInsert;

  /// No description provided for @fakeShoppingApp.
  ///
  /// In en, this message translates to:
  /// **'Fake Shopping App'**
  String get fakeShoppingApp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get name;

  /// No description provided for @nameInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your name. '**
  String get nameInsert;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get password;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm password:'**
  String get passwordConfirmation;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match. Please check and try again.'**
  String get passwordValidation;

  /// No description provided for @passwordInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your password.'**
  String get passwordInsert;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least 6 characters.'**
  String get passwordLength;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordNotMatch;

  /// No description provided for @paymentProcess.
  ///
  /// In en, this message translates to:
  /// **'Processing your payment, please wait...'**
  String get paymentProcess;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price: '**
  String get price;

  /// No description provided for @priceSymbol.
  ///
  /// In en, this message translates to:
  /// **'R\$'**
  String get priceSymbol;

  /// No description provided for @productRatings.
  ///
  /// In en, this message translates to:
  /// **'Product Ratings'**
  String get productRatings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get profile;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'PURCHASE'**
  String get purchase;

  /// No description provided for @recoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover Password'**
  String get recoverPassword;

  /// No description provided for @recoverPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot your Password?'**
  String get recoverPasswordTitle;

  /// No description provided for @recoverPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address below and you will receive instructions for reseting your password.'**
  String get recoverPasswordSubTitle;

  /// No description provided for @recoverPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password recovery link to your email. Please check your inbox and follow the instructions to reset your password.'**
  String get recoverPasswordSuccess;

  /// No description provided for @removeFromCard.
  ///
  /// In en, this message translates to:
  /// **'Removed from shopping cart'**
  String get removeFromCard;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get search;

  /// No description provided for @securityCode.
  ///
  /// In en, this message translates to:
  /// **'Security Code'**
  String get securityCode;

  /// No description provided for @securityCodeInsert.
  ///
  /// In en, this message translates to:
  /// **'Please, insert security code.'**
  String get securityCodeInsert;

  /// No description provided for @securityCodeAlertLenght.
  ///
  /// In en, this message translates to:
  /// **'Security Code must have 3 numbers.'**
  String get securityCodeAlertLenght;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'SHOP'**
  String get shop;

  /// No description provided for @shoppingCartEmpty.
  ///
  /// In en, this message translates to:
  /// **'YOUR SHOPPING CART IS EMPTY'**
  String get shoppingCartEmpty;

  /// No description provided for @totalPurchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Total Purchase Price'**
  String get totalPurchasePrice;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Our Store!'**
  String get welcome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
