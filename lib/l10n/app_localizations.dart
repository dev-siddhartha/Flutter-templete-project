import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('ne')
  ];

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @sign_up_with_email_to_get_started.
  ///
  /// In en, this message translates to:
  /// **'Sign up with email to get started'**
  String get sign_up_with_email_to_get_started;

  /// No description provided for @profile_name.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get profile_name;

  /// No description provided for @sign_up_with_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Sign up with phone number'**
  String get sign_up_with_phone_number;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @or_sign_in_with.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get or_sign_in_with;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ?'**
  String get already_have_account;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get log_in;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @login_with_email_account.
  ///
  /// In en, this message translates to:
  /// **'Login with email account'**
  String get login_with_email_account;

  /// No description provided for @login_with_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Login with phone number'**
  String get login_with_phone_number;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @or_login_with.
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get or_login_with;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @audio_call.
  ///
  /// In en, this message translates to:
  /// **'Audio Call'**
  String get audio_call;

  /// No description provided for @video_call.
  ///
  /// In en, this message translates to:
  /// **'Video Call'**
  String get video_call;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @please_enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get please_enter_phone_number;

  /// No description provided for @please_enter_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get please_enter_valid_phone_number;

  /// No description provided for @mpin.
  ///
  /// In en, this message translates to:
  /// **'MPIN'**
  String get mpin;

  /// No description provided for @enter_psw.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enter_psw;

  /// No description provided for @psw_notEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password can\'t be empty'**
  String get psw_notEmpty;

  /// No description provided for @psw_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get psw_length;

  /// No description provided for @psw_uppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get psw_uppercase;

  /// No description provided for @psw_lowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get psw_lowercase;

  /// No description provided for @psw_number.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get psw_number;

  /// No description provided for @psw_special.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get psw_special;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get remember_me;

  /// No description provided for @forgot_psw.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_psw;

  /// No description provided for @new_user.
  ///
  /// In en, this message translates to:
  /// **'I\'m a new user.'**
  String get new_user;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get good_evening;

  /// No description provided for @load_wallet.
  ///
  /// In en, this message translates to:
  /// **'Load Wallet'**
  String get load_wallet;

  /// No description provided for @fund_transfer.
  ///
  /// In en, this message translates to:
  /// **'Fund Transfer'**
  String get fund_transfer;

  /// No description provided for @bank_transfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank_transfer;

  /// No description provided for @recharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get recharge;

  /// No description provided for @electricity_water.
  ///
  /// In en, this message translates to:
  /// **'Electricity & Water'**
  String get electricity_water;

  /// No description provided for @internet_tv.
  ///
  /// In en, this message translates to:
  /// **'Internet & TV'**
  String get internet_tv;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @util_bills.
  ///
  /// In en, this message translates to:
  /// **'Utility & Bills'**
  String get util_bills;

  /// No description provided for @current_balance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get current_balance;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @statement.
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get statement;

  /// No description provided for @my_cards.
  ///
  /// In en, this message translates to:
  /// **'My Cards'**
  String get my_cards;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get lang;

  /// No description provided for @my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get my_profile;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @choose_data_share.
  ///
  /// In en, this message translates to:
  /// **'Choose what data you share with us'**
  String get choose_data_share;

  /// No description provided for @biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get biometric;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get dark_theme;

  /// No description provided for @change_lang.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_lang;

  /// No description provided for @log_bio.
  ///
  /// In en, this message translates to:
  /// **'Login with biometric'**
  String get log_bio;

  /// No description provided for @log_face_id.
  ///
  /// In en, this message translates to:
  /// **'Login with Face ID'**
  String get log_face_id;

  /// No description provided for @change_pin.
  ///
  /// In en, this message translates to:
  /// **'Change Pin'**
  String get change_pin;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @account_information.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get account_information;

  /// No description provided for @my_information.
  ///
  /// In en, this message translates to:
  /// **'My Information'**
  String get my_information;

  /// No description provided for @rate_review.
  ///
  /// In en, this message translates to:
  /// **'Rate & Review'**
  String get rate_review;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @enjoy_features.
  ///
  /// In en, this message translates to:
  /// **'Enjoy all the features that make it easy for you to manage your finances'**
  String get enjoy_features;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enter_name;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @kyc.
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get kyc;

  /// No description provided for @kyc_verify.
  ///
  /// In en, this message translates to:
  /// **'KYC verification'**
  String get kyc_verify;

  /// No description provided for @complete_kyc.
  ///
  /// In en, this message translates to:
  /// **'Complete your KYC'**
  String get complete_kyc;

  /// No description provided for @complete_kyc_desc.
  ///
  /// In en, this message translates to:
  /// **'Secure your wallet by verifying your identity'**
  String get complete_kyc_desc;

  /// No description provided for @mobile_register.
  ///
  /// In en, this message translates to:
  /// **'Mobile Registration'**
  String get mobile_register;

  /// No description provided for @identity_verify.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identity_verify;

  /// No description provided for @liveness_detect.
  ///
  /// In en, this message translates to:
  /// **'Liveness Verification'**
  String get liveness_detect;

  /// No description provided for @complete_title.
  ///
  /// In en, this message translates to:
  /// **'Complete {title}'**
  String complete_title(String title);

  /// No description provided for @scan_pay.
  ///
  /// In en, this message translates to:
  /// **'Scan & Pay'**
  String get scan_pay;

  /// No description provided for @tap_pay.
  ///
  /// In en, this message translates to:
  /// **'Tap & Pay'**
  String get tap_pay;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @national_id.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get national_id;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code that we sent to'**
  String get enter_otp;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @ac_created.
  ///
  /// In en, this message translates to:
  /// **'Account Created'**
  String get ac_created;

  /// No description provided for @ac_created_slogon.
  ///
  /// In en, this message translates to:
  /// **'Where Technology Meets Financial Freedom'**
  String get ac_created_slogon;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @click_terms.
  ///
  /// In en, this message translates to:
  /// **'By clicking start you agree to our'**
  String get click_terms;

  /// No description provided for @privacy_policy_terms_sevice.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy and Terms of Service'**
  String get privacy_policy_terms_sevice;

  /// No description provided for @set_pin.
  ///
  /// In en, this message translates to:
  /// **'Set Transcation pin'**
  String get set_pin;

  /// No description provided for @set_pin_descrip.
  ///
  /// In en, this message translates to:
  /// **'You will use this for payment'**
  String get set_pin_descrip;

  /// No description provided for @save_pin.
  ///
  /// In en, this message translates to:
  /// **'Save Pin'**
  String get save_pin;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @select_data.
  ///
  /// In en, this message translates to:
  /// **'Select {data}'**
  String select_data(String data);

  /// No description provided for @no_transaction.
  ///
  /// In en, this message translates to:
  /// **'No Transaction Found'**
  String get no_transaction;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @microphone.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get microphone;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @bluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get bluetooth;

  /// No description provided for @open_settings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get open_settings;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @failure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get failure;

  /// No description provided for @permission_granted.
  ///
  /// In en, this message translates to:
  /// **'{permissionFor} Permission Granted'**
  String permission_granted(String permissionFor);

  /// No description provided for @permission_denied.
  ///
  /// In en, this message translates to:
  /// **'{permissionFor} Permission Denied'**
  String permission_denied(String permissionFor);

  /// No description provided for @recent_transaction.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recent_transaction;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @available_balance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get available_balance;

  /// No description provided for @change_psw_title.
  ///
  /// In en, this message translates to:
  /// **'Change Your Password to Secure Your Account'**
  String get change_psw_title;

  /// No description provided for @change_psw_descrip.
  ///
  /// In en, this message translates to:
  /// **'Fortify your account with a strong password. Mix letters, numbers, and symbols to keep your digital fortress unbreakable.'**
  String get change_psw_descrip;

  /// No description provided for @old_psw.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get old_psw;

  /// No description provided for @new_psw.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_psw;

  /// No description provided for @old_psw_null.
  ///
  /// In en, this message translates to:
  /// **'Provide the old password'**
  String get old_psw_null;

  /// No description provided for @new_psw_null.
  ///
  /// In en, this message translates to:
  /// **'Provide the new password'**
  String get new_psw_null;

  /// No description provided for @create_psw.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get create_psw;

  /// No description provided for @create_psw_title.
  ///
  /// In en, this message translates to:
  /// **'Create Your Password to Secure Your Account'**
  String get create_psw_title;

  /// No description provided for @create_psw_descrip.
  ///
  /// In en, this message translates to:
  /// **'Lock in your account security with a unique password.'**
  String get create_psw_descrip;

  /// No description provided for @confirm_psw.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_psw;

  /// No description provided for @psw_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get psw_not_match;

  /// No description provided for @cancel_process_title.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel {title} process?'**
  String cancel_process_title(String title);

  /// No description provided for @cancel_process_message.
  ///
  /// In en, this message translates to:
  /// **'Your {title} process will be cancelled.'**
  String cancel_process_message(String title);

  /// No description provided for @biometric_setup.
  ///
  /// In en, this message translates to:
  /// **'Biometric Setup'**
  String get biometric_setup;

  /// No description provided for @biometric_login.
  ///
  /// In en, this message translates to:
  /// **'Enable for Login'**
  String get biometric_login;

  /// No description provided for @biometric_transaction.
  ///
  /// In en, this message translates to:
  /// **'Enable for Transaction'**
  String get biometric_transaction;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @date_time.
  ///
  /// In en, this message translates to:
  /// **'Date/Time'**
  String get date_time;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @click_to_pay.
  ///
  /// In en, this message translates to:
  /// **'Click to Pay'**
  String get click_to_pay;

  /// No description provided for @money_transfer.
  ///
  /// In en, this message translates to:
  /// **'Money Transfer'**
  String get money_transfer;

  /// No description provided for @transaction_id.
  ///
  /// In en, this message translates to:
  /// **'Transaction Id'**
  String get transaction_id;

  /// No description provided for @pay_now.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get pay_now;

  /// No description provided for @my_qr.
  ///
  /// In en, this message translates to:
  /// **'My Qr'**
  String get my_qr;

  /// No description provided for @scan_to_receive.
  ///
  /// In en, this message translates to:
  /// **'Scan to Receive'**
  String get scan_to_receive;

  /// No description provided for @scan_to_receive_money.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code to receive Money'**
  String get scan_to_receive_money;

  /// No description provided for @generate_qr.
  ///
  /// In en, this message translates to:
  /// **'Generate Qr'**
  String get generate_qr;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share_qr.
  ///
  /// In en, this message translates to:
  /// **'Share QR'**
  String get share_qr;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @link_bank.
  ///
  /// In en, this message translates to:
  /// **'Link Bank Account'**
  String get link_bank;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @link_bank_descrip.
  ///
  /// In en, this message translates to:
  /// **'Link your bank account to make payments and transfers'**
  String get link_bank_descrip;

  /// No description provided for @financial_payments.
  ///
  /// In en, this message translates to:
  /// **'Financial Payments'**
  String get financial_payments;

  /// No description provided for @request_money.
  ///
  /// In en, this message translates to:
  /// **'Request money'**
  String get request_money;

  /// No description provided for @atm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'ATM Withdraw'**
  String get atm_withdraw;

  /// No description provided for @personal_id.
  ///
  /// In en, this message translates to:
  /// **'Personal Identification'**
  String get personal_id;

  /// No description provided for @citizenship.
  ///
  /// In en, this message translates to:
  /// **'Citizenship'**
  String get citizenship;

  /// No description provided for @driving_license.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get driving_license;

  /// No description provided for @scan_id.
  ///
  /// In en, this message translates to:
  /// **'Scan your ID'**
  String get scan_id;

  /// No description provided for @upload_image.
  ///
  /// In en, this message translates to:
  /// **'Upload {title} image'**
  String upload_image(String title);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @front.
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get front;

  /// No description provided for @take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get take_photo;

  /// No description provided for @record_video.
  ///
  /// In en, this message translates to:
  /// **'Record Video'**
  String get record_video;

  /// No description provided for @identity_verify_descrip.
  ///
  /// In en, this message translates to:
  /// **'Simply scan your ID, and our system will extract key details automatically for a fast and secure KYC process'**
  String get identity_verify_descrip;

  /// No description provided for @personal_id_descrip.
  ///
  /// In en, this message translates to:
  /// **'You may proceed with the KYC verification using any of the accepted documents.'**
  String get personal_id_descrip;

  /// No description provided for @transaction_detail.
  ///
  /// In en, this message translates to:
  /// **'Transaction Detail'**
  String get transaction_detail;

  /// No description provided for @fund_transfer_to.
  ///
  /// In en, this message translates to:
  /// **'Fund Transfered to {title}'**
  String fund_transfer_to(String title);

  /// No description provided for @merchant_name.
  ///
  /// In en, this message translates to:
  /// **'Merchant name'**
  String get merchant_name;

  /// No description provided for @pay_from.
  ///
  /// In en, this message translates to:
  /// **'Payment from'**
  String get pay_from;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @dispute.
  ///
  /// In en, this message translates to:
  /// **'Dispute'**
  String get dispute;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'redo'**
  String get redo;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// No description provided for @issue_descrip.
  ///
  /// In en, this message translates to:
  /// **'Issue Description'**
  String get issue_descrip;

  /// No description provided for @upload_data.
  ///
  /// In en, this message translates to:
  /// **'Upload {title}'**
  String upload_data(String title);

  /// No description provided for @evidence.
  ///
  /// In en, this message translates to:
  /// **'Evidence'**
  String get evidence;

  /// No description provided for @send_money.
  ///
  /// In en, this message translates to:
  /// **'Send Money'**
  String get send_money;

  /// No description provided for @wallet_id.
  ///
  /// In en, this message translates to:
  /// **'Wallet ID'**
  String get wallet_id;

  /// No description provided for @enter_wallet_id.
  ///
  /// In en, this message translates to:
  /// **'Enter Wallet ID'**
  String get enter_wallet_id;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @receipient.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get receipient;

  /// No description provided for @previous_transaction.
  ///
  /// In en, this message translates to:
  /// **'Previous Transaction'**
  String get previous_transaction;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @write_remarks.
  ///
  /// In en, this message translates to:
  /// **'Write Remarks'**
  String get write_remarks;

  /// No description provided for @verify_transaction.
  ///
  /// In en, this message translates to:
  /// **'Verify Transaction'**
  String get verify_transaction;

  /// No description provided for @use_pin.
  ///
  /// In en, this message translates to:
  /// **'Use Pin'**
  String get use_pin;

  /// No description provided for @transaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transaction;

  /// No description provided for @pay_success.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get pay_success;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'{title} days'**
  String days(String title);

  /// No description provided for @this_month.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get this_month;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @select_date_time.
  ///
  /// In en, this message translates to:
  /// **'Select Date and Time'**
  String get select_date_time;

  /// No description provided for @select_dates.
  ///
  /// In en, this message translates to:
  /// **'Select Dates'**
  String get select_dates;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get start_date;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get end_date;

  /// No description provided for @select_start_date.
  ///
  /// In en, this message translates to:
  /// **'Select Start Date'**
  String get select_start_date;

  /// No description provided for @select_end_date.
  ///
  /// In en, this message translates to:
  /// **'Select End Date'**
  String get select_end_date;

  /// No description provided for @select_start_end_date.
  ///
  /// In en, this message translates to:
  /// **'Select Start and End Date'**
  String get select_start_end_date;

  /// No description provided for @date_format_hint.
  ///
  /// In en, this message translates to:
  /// **'Please enter date in {title} format'**
  String date_format_hint(String title);

  /// No description provided for @time_format_hint.
  ///
  /// In en, this message translates to:
  /// **'Please enter time in {title} format'**
  String time_format_hint(String title);

  /// No description provided for @apply_changes.
  ///
  /// In en, this message translates to:
  /// **'Apply Changes'**
  String get apply_changes;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @channel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get channel;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @web.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get web;

  /// No description provided for @nfc.
  ///
  /// In en, this message translates to:
  /// **'NFC'**
  String get nfc;

  /// No description provided for @transaction_property.
  ///
  /// In en, this message translates to:
  /// **'Transaction Property'**
  String get transaction_property;

  /// No description provided for @ref_code.
  ///
  /// In en, this message translates to:
  /// **'Reference Code'**
  String get ref_code;

  /// No description provided for @show_result.
  ///
  /// In en, this message translates to:
  /// **'Show Result'**
  String get show_result;

  /// No description provided for @additional_info.
  ///
  /// In en, this message translates to:
  /// **'Additional Info'**
  String get additional_info;

  /// No description provided for @lend_borrow.
  ///
  /// In en, this message translates to:
  /// **'Lend/Borrow'**
  String get lend_borrow;

  /// No description provided for @card_limitation.
  ///
  /// In en, this message translates to:
  /// **'Cannot add more than 8 cards'**
  String get card_limitation;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// No description provided for @no_cards.
  ///
  /// In en, this message translates to:
  /// **'No Cards available'**
  String get no_cards;

  /// No description provided for @add_card.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get add_card;

  /// No description provided for @cr_or_dr.
  ///
  /// In en, this message translates to:
  /// **'Credit or Debit Card'**
  String get cr_or_dr;

  /// No description provided for @select_card_clr.
  ///
  /// In en, this message translates to:
  /// **'Select Card Color'**
  String get select_card_clr;

  /// No description provided for @card_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get card_holder_name;

  /// No description provided for @enter_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Holder Name'**
  String get enter_holder_name;

  /// No description provided for @pls_enter_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter card holder name'**
  String get pls_enter_holder_name;

  /// No description provided for @card_num.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get card_num;

  /// No description provided for @enter_card_num.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Number'**
  String get enter_card_num;

  /// No description provided for @pls_enter_card_num.
  ///
  /// In en, this message translates to:
  /// **'Please enter card number'**
  String get pls_enter_card_num;

  /// No description provided for @card_exp_date.
  ///
  /// In en, this message translates to:
  /// **'Card Expiry Date'**
  String get card_exp_date;

  /// No description provided for @enter_exp_date.
  ///
  /// In en, this message translates to:
  /// **'Enter Card Expiry Date'**
  String get enter_exp_date;

  /// No description provided for @pls_enter_exp_date.
  ///
  /// In en, this message translates to:
  /// **'Please enter card expiry date'**
  String get pls_enter_exp_date;

  /// No description provided for @card_cvc.
  ///
  /// In en, this message translates to:
  /// **'Card CVC'**
  String get card_cvc;

  /// No description provided for @cvc.
  ///
  /// In en, this message translates to:
  /// **'CVC'**
  String get cvc;

  /// No description provided for @pls_enter_cvc.
  ///
  /// In en, this message translates to:
  /// **'Please enter cvc number'**
  String get pls_enter_cvc;

  /// No description provided for @enter_channel.
  ///
  /// In en, this message translates to:
  /// **'Enter Channel'**
  String get enter_channel;

  /// No description provided for @pls_enter_channel.
  ///
  /// In en, this message translates to:
  /// **'Please enter channel'**
  String get pls_enter_channel;

  /// No description provided for @logout_warning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Logout?'**
  String get logout_warning;

  /// No description provided for @enter_old_psw.
  ///
  /// In en, this message translates to:
  /// **'Enter old password'**
  String get enter_old_psw;

  /// No description provided for @enter_new_psw.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enter_new_psw;

  /// No description provided for @psw_change_success.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get psw_change_success;

  /// No description provided for @something_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_wrong;

  /// No description provided for @reenter_psw.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get reenter_psw;

  /// No description provided for @liveness_detect_descrip.
  ///
  /// In en, this message translates to:
  /// **'Move your face around to verify your identity'**
  String get liveness_detect_descrip;

  /// No description provided for @begin_liveness.
  ///
  /// In en, this message translates to:
  /// **'To begin your verification, follow the simple steps below to ensure your face is detected clearly.'**
  String get begin_liveness;

  /// No description provided for @center_face.
  ///
  /// In en, this message translates to:
  /// **'Center your face in the frame'**
  String get center_face;

  /// No description provided for @center_face_descrip.
  ///
  /// In en, this message translates to:
  /// **'Align your face within the guide frame on screen.'**
  String get center_face_descrip;

  /// No description provided for @use_good_light.
  ///
  /// In en, this message translates to:
  /// **'Use good lighting'**
  String get use_good_light;

  /// No description provided for @use_good_light_descrip.
  ///
  /// In en, this message translates to:
  /// **'Avoid strong shadows or backlight. Natural light is best.'**
  String get use_good_light_descrip;

  /// No description provided for @remove_accessories.
  ///
  /// In en, this message translates to:
  /// **'Remove accessories'**
  String get remove_accessories;

  /// No description provided for @remove_accessories_descrip.
  ///
  /// In en, this message translates to:
  /// **'No sunglasses, hats, or anything that hides your face.'**
  String get remove_accessories_descrip;

  /// No description provided for @document_details.
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get document_details;

  /// No description provided for @correct_info_waring.
  ///
  /// In en, this message translates to:
  /// **'Ensure Accuracy Before Submission'**
  String get correct_info_waring;

  /// No description provided for @ocr_info_warning.
  ///
  /// In en, this message translates to:
  /// **'Scanned details may have small errors,If anything looks wrong, correct it before proceeding'**
  String get ocr_info_warning;

  /// No description provided for @document_id.
  ///
  /// In en, this message translates to:
  /// **'Document ID'**
  String get document_id;

  /// No description provided for @enter_document_id.
  ///
  /// In en, this message translates to:
  /// **'Enter document id'**
  String get enter_document_id;

  /// No description provided for @pls_enter_doc_id.
  ///
  /// In en, this message translates to:
  /// **'Please enter document id'**
  String get pls_enter_doc_id;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enter_full_name;

  /// No description provided for @pls_enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get pls_enter_full_name;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get dob;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_of_birth;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_email;

  /// No description provided for @address_details.
  ///
  /// In en, this message translates to:
  /// **'Address Details'**
  String get address_details;

  /// No description provided for @family_details.
  ///
  /// In en, this message translates to:
  /// **'Family Details'**
  String get family_details;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @pls_enter_country.
  ///
  /// In en, this message translates to:
  /// **'Please enter your country'**
  String get pls_enter_country;

  /// No description provided for @state_emirates.
  ///
  /// In en, this message translates to:
  /// **'State/Emirates'**
  String get state_emirates;

  /// No description provided for @pls_enter_state.
  ///
  /// In en, this message translates to:
  /// **'Please enter your State/Emirates'**
  String get pls_enter_state;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @pls_enter_city.
  ///
  /// In en, this message translates to:
  /// **'Please enter your City'**
  String get pls_enter_city;

  /// No description provided for @address_line.
  ///
  /// In en, this message translates to:
  /// **'Address Line {title}'**
  String address_line(String title);

  /// No description provided for @specific_loc.
  ///
  /// In en, this message translates to:
  /// **'Specific location (villa street, sector)'**
  String get specific_loc;

  /// No description provided for @pls_enter_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pls_enter_address;

  /// No description provided for @area_neighbor.
  ///
  /// In en, this message translates to:
  /// **'Area/neighborhood'**
  String get area_neighbor;

  /// No description provided for @zip_postal.
  ///
  /// In en, this message translates to:
  /// **'Zip/Postal Code'**
  String get zip_postal;

  /// No description provided for @pls_enter_zip_postal.
  ///
  /// In en, this message translates to:
  /// **'Please enter your zip/postal code'**
  String get pls_enter_zip_postal;

  /// No description provided for @permanent_address_detail.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address Detail'**
  String get permanent_address_detail;

  /// No description provided for @form_info_warning.
  ///
  /// In en, this message translates to:
  /// **'Ensure Accuracy Before Submission'**
  String get form_info_warning;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @residental_address_detail.
  ///
  /// In en, this message translates to:
  /// **'Residental Address Detail'**
  String get residental_address_detail;

  /// No description provided for @same_as_permanent.
  ///
  /// In en, this message translates to:
  /// **'Same as Permanent Address'**
  String get same_as_permanent;

  /// No description provided for @family_detail.
  ///
  /// In en, this message translates to:
  /// **'Family Detail'**
  String get family_detail;

  /// No description provided for @father_name.
  ///
  /// In en, this message translates to:
  /// **'Father\'s Name'**
  String get father_name;

  /// No description provided for @enter_father_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your Father\'s Name'**
  String get enter_father_name;

  /// No description provided for @pls_enter_father_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter Father\'s Name'**
  String get pls_enter_father_name;

  /// No description provided for @mother_name.
  ///
  /// In en, this message translates to:
  /// **'Mother\'s Name'**
  String get mother_name;

  /// No description provided for @enter_mother_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your Mother\'s Name'**
  String get enter_mother_name;

  /// No description provided for @pls_enter_mother_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Mother\'s Name'**
  String get pls_enter_mother_name;

  /// No description provided for @granddad_name.
  ///
  /// In en, this message translates to:
  /// **'Grandfather\'s Name'**
  String get granddad_name;

  /// No description provided for @enter_granddad_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your GrandFather\'s Name'**
  String get enter_granddad_name;

  /// No description provided for @pls_enter_granddad_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Grandfather\'s Name'**
  String get pls_enter_granddad_name;

  /// No description provided for @spouse_name.
  ///
  /// In en, this message translates to:
  /// **'Spouse\'s Name'**
  String get spouse_name;

  /// No description provided for @enter_spouse_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your Spouse\'s Name'**
  String get enter_spouse_name;

  /// No description provided for @identity_details.
  ///
  /// In en, this message translates to:
  /// **'Identity Details'**
  String get identity_details;

  /// No description provided for @basic_info.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basic_info;

  /// No description provided for @document_type.
  ///
  /// In en, this message translates to:
  /// **'Document Type'**
  String get document_type;

  /// No description provided for @permanent_address.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address'**
  String get permanent_address;

  /// No description provided for @residental_address.
  ///
  /// In en, this message translates to:
  /// **'Residental Address'**
  String get residental_address;

  /// No description provided for @doc_number.
  ///
  /// In en, this message translates to:
  /// **'Document Number'**
  String get doc_number;

  /// No description provided for @doc_issue_date.
  ///
  /// In en, this message translates to:
  /// **'Document Date of Issue'**
  String get doc_issue_date;

  /// No description provided for @press_for_exit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get press_for_exit;

  /// No description provided for @pls_enter_both_dates.
  ///
  /// In en, this message translates to:
  /// **'Please enter both Start and End Dates'**
  String get pls_enter_both_dates;

  /// No description provided for @no_future_dates.
  ///
  /// In en, this message translates to:
  /// **'Cannot select Future Dates'**
  String get no_future_dates;

  /// No description provided for @no_start_before_after.
  ///
  /// In en, this message translates to:
  /// **'Start date cannot be after End Date'**
  String get no_start_before_after;

  /// No description provided for @invalid_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid Date Format. Please use {title}'**
  String invalid_format(String title);

  /// No description provided for @code_resent_success.
  ///
  /// In en, this message translates to:
  /// **'Code resent Successfully'**
  String get code_resent_success;

  /// No description provided for @register_descrip.
  ///
  /// In en, this message translates to:
  /// **'We need to send OTP to authenticate your number.'**
  String get register_descrip;

  /// No description provided for @have_promocode.
  ///
  /// In en, this message translates to:
  /// **'Have a promocode?'**
  String get have_promocode;

  /// No description provided for @send_otp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get send_otp;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get login_failed;

  /// No description provided for @error_occured.
  ///
  /// In en, this message translates to:
  /// **'An Error Occured'**
  String get error_occured;

  /// No description provided for @enter_promocode.
  ///
  /// In en, this message translates to:
  /// **'Enter Promocode'**
  String get enter_promocode;

  /// No description provided for @bio_change.
  ///
  /// In en, this message translates to:
  /// **'Biometric Data Changed'**
  String get bio_change;

  /// No description provided for @bio_change_descrip.
  ///
  /// In en, this message translates to:
  /// **'Your fingerprint or biometric data has been changed. Please re-authenticate.'**
  String get bio_change_descrip;

  /// No description provided for @enable_bio.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric fo Login'**
  String get enable_bio;

  /// No description provided for @enable_bio_descrip.
  ///
  /// In en, this message translates to:
  /// **'You can login using your {title}. Do you want to enable it?'**
  String enable_bio_descrip(String title);

  /// No description provided for @scan_login.
  ///
  /// In en, this message translates to:
  /// **'Scan to Login'**
  String get scan_login;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @otp_verify.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otp_verify;

  /// No description provided for @pls_enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Please enter OTP'**
  String get pls_enter_otp;
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
      <String>['ar', 'en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
