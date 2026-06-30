// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Emdad Khodro Saipa`
  String get appName {
    return Intl.message(
      'Emdad Khodro Saipa',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Relief`
  String get relief {
    return Intl.message('Relief', name: 'relief', desc: '', args: []);
  }

  /// `Survey`
  String get survey {
    return Intl.message('Survey', name: 'survey', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `register`
  String get registerInService {
    return Intl.message(
      'register',
      name: 'registerInService',
      desc: '',
      args: [],
    );
  }

  /// `mobile number`
  String get mobileNumber {
    return Intl.message(
      'mobile number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `confirmation`
  String get confirmation {
    return Intl.message(
      'confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `confirmation Code`
  String get confirmationCode {
    return Intl.message(
      'confirmation Code',
      name: 'confirmationCode',
      desc: '',
      args: [],
    );
  }

  /// `resend Code {secondsRemaining}`
  String resendCode(Object secondsRemaining) {
    return Intl.message(
      'resend Code $secondsRemaining',
      name: 'resendCode',
      desc: '',
      args: [secondsRemaining],
    );
  }

  /// `Change mobile number`
  String get changeMobileNumber {
    return Intl.message(
      'Change mobile number',
      name: 'changeMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `09xxxxxxxxx`
  String get hintMobileNumber {
    return Intl.message(
      '09xxxxxxxxx',
      name: 'hintMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `xxxxxxxxxx`
  String get hintIdNumber {
    return Intl.message('xxxxxxxxxx', name: 'hintIdNumber', desc: '', args: []);
  }

  /// `Please wait`
  String get pleaseWait {
    return Intl.message('Please wait', name: 'pleaseWait', desc: '', args: []);
  }

  /// `error from server`
  String get errorFromServer {
    return Intl.message(
      'error from server',
      name: 'errorFromServer',
      desc: '',
      args: [],
    );
  }

  /// `error in sending message`
  String get errorInSendingMessage {
    return Intl.message(
      'error in sending message',
      name: 'errorInSendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Server connection error`
  String get serverConnectionError {
    return Intl.message(
      'Server connection error',
      name: 'serverConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `error form is not valid`
  String get errorFormIsNotValid {
    return Intl.message(
      'error form is not valid',
      name: 'errorFormIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `error phone number is not valid`
  String get errorPhoneNumberIsNotValid {
    return Intl.message(
      'error phone number is not valid',
      name: 'errorPhoneNumberIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `error OTP code is not valid`
  String get errorOTPCodeIsNotValid {
    return Intl.message(
      'error OTP code is not valid',
      name: 'errorOTPCodeIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Click For Adding Car`
  String get clickForAddingCar {
    return Intl.message(
      'Click For Adding Car',
      name: 'clickForAddingCar',
      desc: '',
      args: [],
    );
  }

  /// `Click For Adding Car`
  String get addNewCar {
    return Intl.message(
      'Click For Adding Car',
      name: 'addNewCar',
      desc: '',
      args: [],
    );
  }

  /// `Quick Help`
  String get quickHelp {
    return Intl.message('Quick Help', name: 'quickHelp', desc: '', args: []);
  }

  /// `InPlace Service`
  String get inPlaceService {
    return Intl.message(
      'InPlace Service',
      name: 'inPlaceService',
      desc: '',
      args: [],
    );
  }

  /// `Body Guaranty`
  String get bodyGuaranty {
    return Intl.message(
      'Body Guaranty',
      name: 'bodyGuaranty',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscriptionBuy {
    return Intl.message(
      'Subscription',
      name: 'subscriptionBuy',
      desc: '',
      args: [],
    );
  }

  /// `Car Transport`
  String get carTransport {
    return Intl.message(
      'Car Transport',
      name: 'carTransport',
      desc: '',
      args: [],
    );
  }

  /// `Puncture`
  String get puncture {
    return Intl.message('Puncture', name: 'puncture', desc: '', args: []);
  }

  /// `Guest User`
  String get guestUser {
    return Intl.message('Guest User', name: 'guestUser', desc: '', args: []);
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Product Introduction`
  String get productIntroduction {
    return Intl.message(
      'Product Introduction',
      name: 'productIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Social Responsiblity`
  String get socialResponsiblity {
    return Intl.message(
      'Social Responsiblity',
      name: 'socialResponsiblity',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `enter car specifications`
  String get enterCarSpecifications {
    return Intl.message(
      'enter car specifications',
      name: 'enterCarSpecifications',
      desc: '',
      args: [],
    );
  }

  /// `car model`
  String get carModel {
    return Intl.message('car model', name: 'carModel', desc: '', args: []);
  }

  /// `year of production`
  String get yearOfProduction {
    return Intl.message(
      'year of production',
      name: 'yearOfProduction',
      desc: '',
      args: [],
    );
  }

  /// `chassis number`
  String get chassisNumber {
    return Intl.message(
      'chassis number',
      name: 'chassisNumber',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Are you sure about removing this car?`
  String get removeCarDialogText {
    return Intl.message(
      'Are you sure about removing this car?',
      name: 'removeCarDialogText',
      desc: '',
      args: [],
    );
  }

  /// `iran`
  String get iran {
    return Intl.message('iran', name: 'iran', desc: '', args: []);
  }

  /// `Resend again`
  String get resendAgain {
    return Intl.message(
      'Resend again',
      name: 'resendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Wrong code`
  String get otpCodeWrong {
    return Intl.message('Wrong code', name: 'otpCodeWrong', desc: '', args: []);
  }

  /// `code entry is wrong please use resend code`
  String get otpCodeWrongDescription {
    return Intl.message(
      'code entry is wrong please use resend code',
      name: 'otpCodeWrongDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUs 096550`
  String get contactDirectlyUs {
    return Intl.message(
      'contactUs 096550',
      name: 'contactDirectlyUs',
      desc: '',
      args: [],
    );
  }

  /// `Direct contact with Saipa Car Relief Support`
  String get contactDirectlyDialogBody {
    return Intl.message(
      'Direct contact with Saipa Car Relief Support',
      name: 'contactDirectlyDialogBody',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get contactDirectlyDialogPositiveAction {
    return Intl.message(
      'Call',
      name: 'contactDirectlyDialogPositiveAction',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch {url}`
  String throwMessageForContactDirectly(Object url) {
    return Intl.message(
      'Could not launch $url',
      name: 'throwMessageForContactDirectly',
      desc: '',
      args: [url],
    );
  }

  /// `Fullname`
  String get fullname {
    return Intl.message('Fullname', name: 'fullname', desc: '', args: []);
  }

  /// `Name`
  String get firstname {
    return Intl.message('Name', name: 'firstname', desc: '', args: []);
  }

  /// `Lastname`
  String get lastname {
    return Intl.message('Lastname', name: 'lastname', desc: '', args: []);
  }

  /// `National code`
  String get nationalCode {
    return Intl.message(
      'National code',
      name: 'nationalCode',
      desc: '',
      args: [],
    );
  }

  /// `purchase`
  String get purchase {
    return Intl.message('purchase', name: 'purchase', desc: '', args: []);
  }

  /// `extending`
  String get extending {
    return Intl.message('extending', name: 'extending', desc: '', args: []);
  }

  /// `bodyGuarantee`
  String get bodyGuarantee {
    return Intl.message(
      'bodyGuarantee',
      name: 'bodyGuarantee',
      desc: '',
      args: [],
    );
  }

  /// `bodyGuaranteeDescription`
  String get bodyGuaranteeDescription {
    return Intl.message(
      'bodyGuaranteeDescription',
      name: 'bodyGuaranteeDescription',
      desc: '',
      args: [],
    );
  }

  /// `tripExtending`
  String get tripExtending {
    return Intl.message(
      'tripExtending',
      name: 'tripExtending',
      desc: '',
      args: [],
    );
  }

  /// `Supplementary Extending`
  String get supplementaryExtending {
    return Intl.message(
      'Supplementary Extending',
      name: 'supplementaryExtending',
      desc: '',
      args: [],
    );
  }

  /// `publicExtending`
  String get publicExtending {
    return Intl.message(
      'publicExtending',
      name: 'publicExtending',
      desc: '',
      args: [],
    );
  }

  /// `pay`
  String get pay {
    return Intl.message('pay', name: 'pay', desc: '', args: []);
  }

  /// `Comming Soon`
  String get commingSoon {
    return Intl.message(
      'Comming Soon',
      name: 'commingSoon',
      desc: '',
      args: [],
    );
  }

  /// `PleaseWait`
  String get PleaseWait {
    return Intl.message('PleaseWait', name: 'PleaseWait', desc: '', args: []);
  }

  /// `clickForBodyGaurantee`
  String get clickForBodyGaurantee {
    return Intl.message(
      'clickForBodyGaurantee',
      name: 'clickForBodyGaurantee',
      desc: '',
      args: [],
    );
  }

  /// `ApplicationIsRegistered`
  String get ApplicationIsRegistered {
    return Intl.message(
      'ApplicationIsRegistered',
      name: 'ApplicationIsRegistered',
      desc: '',
      args: [],
    );
  }

  /// `ApplicationIsRegisteredCallYou`
  String get ApplicationIsRegisteredCallYou {
    return Intl.message(
      'ApplicationIsRegisteredCallYou',
      name: 'ApplicationIsRegisteredCallYou',
      desc: '',
      args: [],
    );
  }

  /// `withParticipatingInSurvayingHelpUSToBecomeBetter`
  String get withParticipatingInSurvayingHelpUSToBecomeBetter {
    return Intl.message(
      'withParticipatingInSurvayingHelpUSToBecomeBetter',
      name: 'withParticipatingInSurvayingHelpUSToBecomeBetter',
      desc: '',
      args: [],
    );
  }

  /// `Go To Surveying`
  String get startSurveying {
    return Intl.message(
      'Go To Surveying',
      name: 'startSurveying',
      desc: '',
      args: [],
    );
  }

  /// `clickForExtending`
  String get clickForExtending {
    return Intl.message(
      'clickForExtending',
      name: 'clickForExtending',
      desc: '',
      args: [],
    );
  }

  /// `purchaseExtending`
  String get purchaseExtending {
    return Intl.message(
      'purchaseExtending',
      name: 'purchaseExtending',
      desc: '',
      args: [],
    );
  }

  /// `pleaseUpdateApplicationVersion`
  String get pleaseUpdateApplicationVersion {
    return Intl.message(
      'pleaseUpdateApplicationVersion',
      name: 'pleaseUpdateApplicationVersion',
      desc: '',
      args: [],
    );
  }

  /// `developingIsInProgress`
  String get developingIsInProgress {
    return Intl.message(
      'developingIsInProgress',
      name: 'developingIsInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Submit Request`
  String get submitRequest {
    return Intl.message(
      'Submit Request',
      name: 'submitRequest',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message('description', name: 'description', desc: '', args: []);
  }

  /// `I have a Physical limitation Such As {limitKind} `
  String have_limitation(Object limitKind) {
    return Intl.message(
      'I have a Physical limitation Such As $limitKind ',
      name: 'have_limitation',
      desc: '',
      args: [limitKind],
    );
  }

  /// `Physical`
  String get physical {
    return Intl.message('Physical', name: 'physical', desc: '', args: []);
  }

  /// ` *`
  String get star {
    return Intl.message(' *', name: 'star', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Submit Request {title}`
  String submitRequestTitle(Object title) {
    return Intl.message(
      'Submit Request $title',
      name: 'submitRequestTitle',
      desc: '',
      args: [title],
    );
  }

  /// `Submit Request Force Relief`
  String get submitRequestForceRelief {
    return Intl.message(
      'Submit Request Force Relief',
      name: 'submitRequestForceRelief',
      desc: '',
      args: [],
    );
  }

  /// `Speaking`
  String get speaking {
    return Intl.message('Speaking', name: 'speaking', desc: '', args: []);
  }

  /// `Moving`
  String get moving {
    return Intl.message('Moving', name: 'moving', desc: '', args: []);
  }

  /// `Hearing`
  String get hearing {
    return Intl.message('Hearing', name: 'hearing', desc: '', args: []);
  }

  /// `And`
  String get and {
    return Intl.message('And', name: 'and', desc: '', args: []);
  }

  /// `Force Relief`
  String get forceRelief {
    return Intl.message(
      'Force Relief',
      name: 'forceRelief',
      desc: '',
      args: [],
    );
  }

  /// `OnSiteService`
  String get onSiteService {
    return Intl.message(
      'OnSiteService',
      name: 'onSiteService',
      desc: '',
      args: [],
    );
  }

  /// `On Site Service Request`
  String get onSiteServiceRequest {
    return Intl.message(
      'On Site Service Request',
      name: 'onSiteServiceRequest',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartOne`
  String get aboutUsTextPartOne {
    return Intl.message(
      'aboutUsTextPartOne',
      name: 'aboutUsTextPartOne',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartTwo`
  String get aboutUsTextPartTwo {
    return Intl.message(
      'aboutUsTextPartTwo',
      name: 'aboutUsTextPartTwo',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartThree`
  String get aboutUsTextPartThree {
    return Intl.message(
      'aboutUsTextPartThree',
      name: 'aboutUsTextPartThree',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartFour`
  String get aboutUsTextPartFour {
    return Intl.message(
      'aboutUsTextPartFour',
      name: 'aboutUsTextPartFour',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartFive`
  String get aboutUsTextPartFive {
    return Intl.message(
      'aboutUsTextPartFive',
      name: 'aboutUsTextPartFive',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartSix`
  String get aboutUsTextPartSix {
    return Intl.message(
      'aboutUsTextPartSix',
      name: 'aboutUsTextPartSix',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartSeven: `
  String get aboutUsTextPartSeven {
    return Intl.message(
      'aboutUsTextPartSeven: ',
      name: 'aboutUsTextPartSeven',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartEight`
  String get aboutUsTextPartEight {
    return Intl.message(
      'aboutUsTextPartEight',
      name: 'aboutUsTextPartEight',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartNine`
  String get aboutUsTextPartNine {
    return Intl.message(
      'aboutUsTextPartNine',
      name: 'aboutUsTextPartNine',
      desc: '',
      args: [],
    );
  }

  /// `aboutUsTextPartTen`
  String get aboutUsTextPartTen {
    return Intl.message(
      'aboutUsTextPartTen',
      name: 'aboutUsTextPartTen',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartOnetitle`
  String get contactUsTextPartOnetitle {
    return Intl.message(
      'contactUsTextPartOnetitle',
      name: 'contactUsTextPartOnetitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartOneDescription`
  String get contactUsTextPartOneDescription {
    return Intl.message(
      'contactUsTextPartOneDescription',
      name: 'contactUsTextPartOneDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartTwoTitle`
  String get contactUsTextPartTwoTitle {
    return Intl.message(
      'contactUsTextPartTwoTitle',
      name: 'contactUsTextPartTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartTwoDescription`
  String get contactUsTextPartTwoDescription {
    return Intl.message(
      'contactUsTextPartTwoDescription',
      name: 'contactUsTextPartTwoDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartThreeTitle`
  String get contactUsTextPartThreeTitle {
    return Intl.message(
      'contactUsTextPartThreeTitle',
      name: 'contactUsTextPartThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartThreeDescription`
  String get contactUsTextPartThreeDescription {
    return Intl.message(
      'contactUsTextPartThreeDescription',
      name: 'contactUsTextPartThreeDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartFourTitle`
  String get contactUsTextPartFourTitle {
    return Intl.message(
      'contactUsTextPartFourTitle',
      name: 'contactUsTextPartFourTitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartFourDescription`
  String get contactUsTextPartFourDescription {
    return Intl.message(
      'contactUsTextPartFourDescription',
      name: 'contactUsTextPartFourDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartFiveTitle`
  String get contactUsTextPartFiveTitle {
    return Intl.message(
      'contactUsTextPartFiveTitle',
      name: 'contactUsTextPartFiveTitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartFiveDescription`
  String get contactUsTextPartFiveDescription {
    return Intl.message(
      'contactUsTextPartFiveDescription',
      name: 'contactUsTextPartFiveDescription',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartSixTitle`
  String get contactUsTextPartSixTitle {
    return Intl.message(
      'contactUsTextPartSixTitle',
      name: 'contactUsTextPartSixTitle',
      desc: '',
      args: [],
    );
  }

  /// `contactUsTextPartSixDescription`
  String get contactUsTextPartSixDescription {
    return Intl.message(
      'contactUsTextPartSixDescription',
      name: 'contactUsTextPartSixDescription',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartOne`
  String get socialResponsibilityTextPartOne {
    return Intl.message(
      'socialResponsibilityTextPartOne',
      name: 'socialResponsibilityTextPartOne',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartTwo`
  String get socialResponsibilityTextPartTwo {
    return Intl.message(
      'socialResponsibilityTextPartTwo',
      name: 'socialResponsibilityTextPartTwo',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartThree`
  String get socialResponsibilityTextPartThree {
    return Intl.message(
      'socialResponsibilityTextPartThree',
      name: 'socialResponsibilityTextPartThree',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartFour`
  String get socialResponsibilityTextPartFour {
    return Intl.message(
      'socialResponsibilityTextPartFour',
      name: 'socialResponsibilityTextPartFour',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartFive`
  String get socialResponsibilityTextPartFive {
    return Intl.message(
      'socialResponsibilityTextPartFive',
      name: 'socialResponsibilityTextPartFive',
      desc: '',
      args: [],
    );
  }

  /// `socialResponsibilityTextPartSix`
  String get socialResponsibilityTextPartSix {
    return Intl.message(
      'socialResponsibilityTextPartSix',
      name: 'socialResponsibilityTextPartSix',
      desc: '',
      args: [],
    );
  }

  /// `basicGoldenCardText`
  String get basicGoldenCardText {
    return Intl.message(
      'basicGoldenCardText',
      name: 'basicGoldenCardText',
      desc: '',
      args: [],
    );
  }

  /// `moreInformation`
  String get moreInformation {
    return Intl.message(
      'moreInformation',
      name: 'moreInformation',
      desc: '',
      args: [],
    );
  }

  /// `economyGoldenCardText`
  String get economyGoldenCardText {
    return Intl.message(
      'economyGoldenCardText',
      name: 'economyGoldenCardText',
      desc: '',
      args: [],
    );
  }

  /// `fullGoldenCardText`
  String get fullGoldenCardText {
    return Intl.message(
      'fullGoldenCardText',
      name: 'fullGoldenCardText',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextOne`
  String get tripEmdadTextOne {
    return Intl.message(
      'tripEmdadTextOne',
      name: 'tripEmdadTextOne',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextTwo`
  String get tripEmdadTextTwo {
    return Intl.message(
      'tripEmdadTextTwo',
      name: 'tripEmdadTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextThree`
  String get tripEmdadTextThree {
    return Intl.message(
      'tripEmdadTextThree',
      name: 'tripEmdadTextThree',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextFour`
  String get tripEmdadTextFour {
    return Intl.message(
      'tripEmdadTextFour',
      name: 'tripEmdadTextFour',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextFive`
  String get tripEmdadTextFive {
    return Intl.message(
      'tripEmdadTextFive',
      name: 'tripEmdadTextFive',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdadTextSix`
  String get tripEmdadTextSix {
    return Intl.message(
      'tripEmdadTextSix',
      name: 'tripEmdadTextSix',
      desc: '',
      args: [],
    );
  }

  /// `tripEmdad`
  String get tripEmdad {
    return Intl.message('tripEmdad', name: 'tripEmdad', desc: '', args: []);
  }

  /// `commonEmdadTextOne`
  String get commonEmdadTextOne {
    return Intl.message(
      'commonEmdadTextOne',
      name: 'commonEmdadTextOne',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextTwo`
  String get commonEmdadTextTwo {
    return Intl.message(
      'commonEmdadTextTwo',
      name: 'commonEmdadTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextThree`
  String get commonEmdadTextThree {
    return Intl.message(
      'commonEmdadTextThree',
      name: 'commonEmdadTextThree',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextFour`
  String get commonEmdadTextFour {
    return Intl.message(
      'commonEmdadTextFour',
      name: 'commonEmdadTextFour',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextFive`
  String get commonEmdadTextFive {
    return Intl.message(
      'commonEmdadTextFive',
      name: 'commonEmdadTextFive',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextSix`
  String get commonEmdadTextSix {
    return Intl.message(
      'commonEmdadTextSix',
      name: 'commonEmdadTextSix',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdadTextSeven`
  String get commonEmdadTextSeven {
    return Intl.message(
      'commonEmdadTextSeven',
      name: 'commonEmdadTextSeven',
      desc: '',
      args: [],
    );
  }

  /// `commonEmdad`
  String get commonEmdad {
    return Intl.message('commonEmdad', name: 'commonEmdad', desc: '', args: []);
  }

  /// `necessaryEmdadTextOne`
  String get necessaryEmdadTextOne {
    return Intl.message(
      'necessaryEmdadTextOne',
      name: 'necessaryEmdadTextOne',
      desc: '',
      args: [],
    );
  }

  /// `necessaryEmdadTextTwo`
  String get necessaryEmdadTextTwo {
    return Intl.message(
      'necessaryEmdadTextTwo',
      name: 'necessaryEmdadTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `necessaryEmdadTextThree`
  String get necessaryEmdadTextThree {
    return Intl.message(
      'necessaryEmdadTextThree',
      name: 'necessaryEmdadTextThree',
      desc: '',
      args: [],
    );
  }

  /// `necessaryEmdad`
  String get necessaryEmdad {
    return Intl.message(
      'necessaryEmdad',
      name: 'necessaryEmdad',
      desc: '',
      args: [],
    );
  }

  /// `supplmentaryEmdadTextOne`
  String get supplmentaryEmdadTextOne {
    return Intl.message(
      'supplmentaryEmdadTextOne',
      name: 'supplmentaryEmdadTextOne',
      desc: '',
      args: [],
    );
  }

  /// `supplmentaryEmdadTextTwo`
  String get supplmentaryEmdadTextTwo {
    return Intl.message(
      'supplmentaryEmdadTextTwo',
      name: 'supplmentaryEmdadTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `supplmentaryEmdadTextThree`
  String get supplmentaryEmdadTextThree {
    return Intl.message(
      'supplmentaryEmdadTextThree',
      name: 'supplmentaryEmdadTextThree',
      desc: '',
      args: [],
    );
  }

  /// `supplmentaryEmdad`
  String get supplmentaryEmdad {
    return Intl.message(
      'supplmentaryEmdad',
      name: 'supplmentaryEmdad',
      desc: '',
      args: [],
    );
  }

  /// `productionIntroduction`
  String get productionIntroduction {
    return Intl.message(
      'productionIntroduction',
      name: 'productionIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `servicescomparingtable`
  String get servicescomparingtable {
    return Intl.message(
      'servicescomparingtable',
      name: 'servicescomparingtable',
      desc: '',
      args: [],
    );
  }

  /// `carInPlaceService`
  String get carInPlaceService {
    return Intl.message(
      'carInPlaceService',
      name: 'carInPlaceService',
      desc: '',
      args: [],
    );
  }

  /// `carInPlaceServiceDescription`
  String get carInPlaceServiceDescription {
    return Intl.message(
      'carInPlaceServiceDescription',
      name: 'carInPlaceServiceDescription',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServices`
  String get firstAndPeriodicServices {
    return Intl.message(
      'firstAndPeriodicServices',
      name: 'firstAndPeriodicServices',
      desc: '',
      args: [],
    );
  }

  /// `optionInstalling`
  String get optionInstalling {
    return Intl.message(
      'optionInstalling',
      name: 'optionInstalling',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTrip`
  String get visitBeforTrip {
    return Intl.message(
      'visitBeforTrip',
      name: 'visitBeforTrip',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextOne`
  String get visitBeforTripTextOne {
    return Intl.message(
      'visitBeforTripTextOne',
      name: 'visitBeforTripTextOne',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextTwo`
  String get visitBeforTripTextTwo {
    return Intl.message(
      'visitBeforTripTextTwo',
      name: 'visitBeforTripTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextThree`
  String get visitBeforTripTextThree {
    return Intl.message(
      'visitBeforTripTextThree',
      name: 'visitBeforTripTextThree',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextFour`
  String get visitBeforTripTextFour {
    return Intl.message(
      'visitBeforTripTextFour',
      name: 'visitBeforTripTextFour',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextFive`
  String get visitBeforTripTextFive {
    return Intl.message(
      'visitBeforTripTextFive',
      name: 'visitBeforTripTextFive',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextSix`
  String get visitBeforTripTextSix {
    return Intl.message(
      'visitBeforTripTextSix',
      name: 'visitBeforTripTextSix',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextSeven`
  String get visitBeforTripTextSeven {
    return Intl.message(
      'visitBeforTripTextSeven',
      name: 'visitBeforTripTextSeven',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextEight`
  String get visitBeforTripTextEight {
    return Intl.message(
      'visitBeforTripTextEight',
      name: 'visitBeforTripTextEight',
      desc: '',
      args: [],
    );
  }

  /// `visitBeforTripTextNine`
  String get visitBeforTripTextNine {
    return Intl.message(
      'visitBeforTripTextNine',
      name: 'visitBeforTripTextNine',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextOne`
  String get firstAndPeriodicServicesTextOne {
    return Intl.message(
      'firstAndPeriodicServicesTextOne',
      name: 'firstAndPeriodicServicesTextOne',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextTwo`
  String get firstAndPeriodicServicesTextTwo {
    return Intl.message(
      'firstAndPeriodicServicesTextTwo',
      name: 'firstAndPeriodicServicesTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextThree`
  String get firstAndPeriodicServicesTextThree {
    return Intl.message(
      'firstAndPeriodicServicesTextThree',
      name: 'firstAndPeriodicServicesTextThree',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextFour`
  String get firstAndPeriodicServicesTextFour {
    return Intl.message(
      'firstAndPeriodicServicesTextFour',
      name: 'firstAndPeriodicServicesTextFour',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextFive`
  String get firstAndPeriodicServicesTextFive {
    return Intl.message(
      'firstAndPeriodicServicesTextFive',
      name: 'firstAndPeriodicServicesTextFive',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextSix`
  String get firstAndPeriodicServicesTextSix {
    return Intl.message(
      'firstAndPeriodicServicesTextSix',
      name: 'firstAndPeriodicServicesTextSix',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextSeven`
  String get firstAndPeriodicServicesTextSeven {
    return Intl.message(
      'firstAndPeriodicServicesTextSeven',
      name: 'firstAndPeriodicServicesTextSeven',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextEight`
  String get firstAndPeriodicServicesTextEight {
    return Intl.message(
      'firstAndPeriodicServicesTextEight',
      name: 'firstAndPeriodicServicesTextEight',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextNine`
  String get firstAndPeriodicServicesTextNine {
    return Intl.message(
      'firstAndPeriodicServicesTextNine',
      name: 'firstAndPeriodicServicesTextNine',
      desc: '',
      args: [],
    );
  }

  /// `firstAndPeriodicServicesTextTen`
  String get firstAndPeriodicServicesTextTen {
    return Intl.message(
      'firstAndPeriodicServicesTextTen',
      name: 'firstAndPeriodicServicesTextTen',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextOne`
  String get optionInstallingTextOne {
    return Intl.message(
      'optionInstallingTextOne',
      name: 'optionInstallingTextOne',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextTwo`
  String get optionInstallingTextTwo {
    return Intl.message(
      'optionInstallingTextTwo',
      name: 'optionInstallingTextTwo',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextThree`
  String get optionInstallingTextThree {
    return Intl.message(
      'optionInstallingTextThree',
      name: 'optionInstallingTextThree',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextFour`
  String get optionInstallingTextFour {
    return Intl.message(
      'optionInstallingTextFour',
      name: 'optionInstallingTextFour',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextFive`
  String get optionInstallingTextFive {
    return Intl.message(
      'optionInstallingTextFive',
      name: 'optionInstallingTextFive',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextSix`
  String get optionInstallingTextSix {
    return Intl.message(
      'optionInstallingTextSix',
      name: 'optionInstallingTextSix',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextSeven`
  String get optionInstallingTextSeven {
    return Intl.message(
      'optionInstallingTextSeven',
      name: 'optionInstallingTextSeven',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextEight`
  String get optionInstallingTextEight {
    return Intl.message(
      'optionInstallingTextEight',
      name: 'optionInstallingTextEight',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextNine`
  String get optionInstallingTextNine {
    return Intl.message(
      'optionInstallingTextNine',
      name: 'optionInstallingTextNine',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextTen`
  String get optionInstallingTextTen {
    return Intl.message(
      'optionInstallingTextTen',
      name: 'optionInstallingTextTen',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextEleven`
  String get optionInstallingTextEleven {
    return Intl.message(
      'optionInstallingTextEleven',
      name: 'optionInstallingTextEleven',
      desc: '',
      args: [],
    );
  }

  /// `optionInstallingTextTwelve`
  String get optionInstallingTextTwelve {
    return Intl.message(
      'optionInstallingTextTwelve',
      name: 'optionInstallingTextTwelve',
      desc: '',
      args: [],
    );
  }

  /// `emdadServices`
  String get emdadServices {
    return Intl.message(
      'emdadServices',
      name: 'emdadServices',
      desc: '',
      args: [],
    );
  }

  /// `inPlaceCarServices`
  String get inPlaceCarServices {
    return Intl.message(
      'inPlaceCarServices',
      name: 'inPlaceCarServices',
      desc: '',
      args: [],
    );
  }

  /// `bodyGauranteeServices`
  String get bodyGauranteeServices {
    return Intl.message(
      'bodyGauranteeServices',
      name: 'bodyGauranteeServices',
      desc: '',
      args: [],
    );
  }

  /// `goldenCard`
  String get goldenCard {
    return Intl.message('goldenCard', name: 'goldenCard', desc: '', args: []);
  }

  /// `basicBodyGuarantee`
  String get basicBodyGuarantee {
    return Intl.message(
      'basicBodyGuarantee',
      name: 'basicBodyGuarantee',
      desc: '',
      args: [],
    );
  }

  /// `fullBodyGuarantee`
  String get fullBodyGuarantee {
    return Intl.message(
      'fullBodyGuarantee',
      name: 'fullBodyGuarantee',
      desc: '',
      args: [],
    );
  }

  /// `economyBodyGuarantee`
  String get economyBodyGuarantee {
    return Intl.message(
      'economyBodyGuarantee',
      name: 'economyBodyGuarantee',
      desc: '',
      args: [],
    );
  }

  /// `goldenCardText`
  String get goldenCardText {
    return Intl.message(
      'goldenCardText',
      name: 'goldenCardText',
      desc: '',
      args: [],
    );
  }

  /// `common`
  String get common {
    return Intl.message('common', name: 'common', desc: '', args: []);
  }

  /// `suplementry`
  String get suplementry {
    return Intl.message('suplementry', name: 'suplementry', desc: '', args: []);
  }

  /// `necessary`
  String get necessary {
    return Intl.message('necessary', name: 'necessary', desc: '', args: []);
  }

  /// `trip`
  String get trip {
    return Intl.message('trip', name: 'trip', desc: '', args: []);
  }

  /// `Tire Puncture`
  String get tirePuncture {
    return Intl.message(
      'Tire Puncture',
      name: 'tirePuncture',
      desc: '',
      args: [],
    );
  }

  /// `Car Problem`
  String get carProblem {
    return Intl.message('Car Problem', name: 'carProblem', desc: '', args: []);
  }

  /// `Primary and periodic services`
  String get primaryAndPeriodicService {
    return Intl.message(
      'Primary and periodic services',
      name: 'primaryAndPeriodicService',
      desc: '',
      args: [],
    );
  }

  /// `Non Urgent repairs`
  String get nonUrgentRepairs {
    return Intl.message(
      'Non Urgent repairs',
      name: 'nonUrgentRepairs',
      desc: '',
      args: [],
    );
  }

  /// `Options and Accessories`
  String get optionsAndAccessories {
    return Intl.message(
      'Options and Accessories',
      name: 'optionsAndAccessories',
      desc: '',
      args: [],
    );
  }

  /// `Technical visit before the trip`
  String get technicalVisitBeforeTrip {
    return Intl.message(
      'Technical visit before the trip',
      name: 'technicalVisitBeforeTrip',
      desc: '',
      args: [],
    );
  }

  /// `Current Car Mileage`
  String get currentCarMileage {
    return Intl.message(
      'Current Car Mileage',
      name: 'currentCarMileage',
      desc: '',
      args: [],
    );
  }

  /// `Car Description`
  String get carDescription {
    return Intl.message(
      'Car Description',
      name: 'carDescription',
      desc: '',
      args: [],
    );
  }

  /// `Accept And Continue`
  String get acceptAndContinue {
    return Intl.message(
      'Accept And Continue',
      name: 'acceptAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Additional address (license plate, unit, etc.)`
  String get additionalAddress {
    return Intl.message(
      'Additional address (license plate, unit, etc.)',
      name: 'additionalAddress',
      desc: '',
      args: [],
    );
  }

  /// `Choosing a service provider is important to me`
  String get chooseServiceProviderIsImportantToMe {
    return Intl.message(
      'Choosing a service provider is important to me',
      name: 'chooseServiceProviderIsImportantToMe',
      desc: '',
      args: [],
    );
  }

  /// `Choose Day`
  String get chooseDay {
    return Intl.message('Choose Day', name: 'chooseDay', desc: '', args: []);
  }

  /// `Choose Time`
  String get chooseTime {
    return Intl.message('Choose Time', name: 'chooseTime', desc: '', args: []);
  }

  /// `Choose Date and Time`
  String get chooseDateTime {
    return Intl.message(
      'Choose Date and Time',
      name: 'chooseDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Choose Automobile`
  String get chooseAutomobile {
    return Intl.message(
      'Choose Automobile',
      name: 'chooseAutomobile',
      desc: '',
      args: [],
    );
  }

  /// `Accurate Address`
  String get accurateAddress {
    return Intl.message(
      'Accurate Address',
      name: 'accurateAddress',
      desc: '',
      args: [],
    );
  }

  /// `Score: {value}`
  String score(Object value) {
    return Intl.message(
      'Score: $value',
      name: 'score',
      desc: '',
      args: [value],
    );
  }

  /// `For Use Features Need Give Permission`
  String get givePermissionDescription {
    return Intl.message(
      'For Use Features Need Give Permission',
      name: 'givePermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `You Are Here`
  String get youAreHere {
    return Intl.message('You Are Here', name: 'youAreHere', desc: '', args: []);
  }

  /// `Change Theme`
  String get changeTheme {
    return Intl.message(
      'Change Theme',
      name: 'changeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Used Services`
  String get frequentService {
    return Intl.message(
      'Frequently Used Services',
      name: 'frequentService',
      desc: '',
      args: [],
    );
  }

  /// `Emdad Service`
  String get emdadService {
    return Intl.message(
      'Emdad Service',
      name: 'emdadService',
      desc: '',
      args: [],
    );
  }

  /// `Car Service`
  String get carService {
    return Intl.message('Car Service', name: 'carService', desc: '', args: []);
  }

  /// `Force Service`
  String get forceService {
    return Intl.message(
      'Force Service',
      name: 'forceService',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Battery Relief`
  String get batteryRelief {
    return Intl.message(
      'Battery Relief',
      name: 'batteryRelief',
      desc: '',
      args: [],
    );
  }

  /// `OnSite Relief`
  String get onSiteRelief {
    return Intl.message(
      'OnSite Relief',
      name: 'onSiteRelief',
      desc: '',
      args: [],
    );
  }

  /// `Flat Relief`
  String get flatRelief {
    return Intl.message('Flat Relief', name: 'flatRelief', desc: '', args: []);
  }

  /// `Transportation Relief`
  String get transportationRelief {
    return Intl.message(
      'Transportation Relief',
      name: 'transportationRelief',
      desc: '',
      args: [],
    );
  }

  /// `clickForRegisterCar`
  String get clickForRegisterCar {
    return Intl.message(
      'clickForRegisterCar',
      name: 'clickForRegisterCar',
      desc: '',
      args: [],
    );
  }

  /// `carName`
  String get carName {
    return Intl.message('carName', name: 'carName', desc: '', args: []);
  }

  /// `tiba`
  String get tiba {
    return Intl.message('tiba', name: 'tiba', desc: '', args: []);
  }

  /// `addCar`
  String get addCar {
    return Intl.message('addCar', name: 'addCar', desc: '', args: []);
  }

  /// `enterYourCarFeaturesForUsingServices`
  String get enterYourCarFeaturesForUsingServices {
    return Intl.message(
      'enterYourCarFeaturesForUsingServices',
      name: 'enterYourCarFeaturesForUsingServices',
      desc: '',
      args: [],
    );
  }

  /// `3200000 rial`
  String get purchaseItemPrice {
    return Intl.message(
      '3200000 rial',
      name: 'purchaseItemPrice',
      desc: '',
      args: [],
    );
  }

  /// `- rial`
  String get purchaseItemNoPrice {
    return Intl.message(
      '- rial',
      name: 'purchaseItemNoPrice',
      desc: '',
      args: [],
    );
  }

  /// `Operation success`
  String get operationSuccess {
    return Intl.message(
      'Operation success',
      name: 'operationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Need some help`
  String get needSomeHelp {
    return Intl.message(
      'Need some help',
      name: 'needSomeHelp',
      desc: '',
      args: [],
    );
  }

  /// `service name`
  String get servicesName {
    return Intl.message(
      'service name',
      name: 'servicesName',
      desc: '',
      args: [],
    );
  }

  /// `request number`
  String get requestId {
    return Intl.message(
      'request number',
      name: 'requestId',
      desc: '',
      args: [],
    );
  }

  /// `date and time`
  String get dateAndTime {
    return Intl.message(
      'date and time',
      name: 'dateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `service price`
  String get servicePrice {
    return Intl.message(
      'service price',
      name: 'servicePrice',
      desc: '',
      args: [],
    );
  }

  /// `transport price`
  String get transportPrice {
    return Intl.message(
      'transport price',
      name: 'transportPrice',
      desc: '',
      args: [],
    );
  }

  /// `sum price`
  String get sumPrice {
    return Intl.message('sum price', name: 'sumPrice', desc: '', args: []);
  }

  /// `discount price`
  String get discountPrice {
    return Intl.message(
      'discount price',
      name: 'discountPrice',
      desc: '',
      args: [],
    );
  }

  /// `serve name`
  String get serveName {
    return Intl.message('serve name', name: 'serveName', desc: '', args: []);
  }

  /// `serve auto`
  String get serveAuto {
    return Intl.message('serve auto', name: 'serveAuto', desc: '', args: []);
  }

  /// `serve plate`
  String get servePlate {
    return Intl.message('serve plate', name: 'servePlate', desc: '', args: []);
  }

  /// `serve mobile`
  String get serveMobile {
    return Intl.message(
      'serve mobile',
      name: 'serveMobile',
      desc: '',
      args: [],
    );
  }

  /// `family`
  String get family {
    return Intl.message('family', name: 'family', desc: '', args: []);
  }

  /// `sum price with tax price`
  String get sumPriceWithTaxPrice {
    return Intl.message(
      'sum price with tax price',
      name: 'sumPriceWithTaxPrice',
      desc: '',
      args: [],
    );
  }

  /// `tax price`
  String get taxPrice {
    return Intl.message('tax price', name: 'taxPrice', desc: '', args: []);
  }

  /// `request info`
  String get requestInfoDetails {
    return Intl.message(
      'request info',
      name: 'requestInfoDetails',
      desc: '',
      args: [],
    );
  }

  /// `final submit`
  String get finalSubmit {
    return Intl.message(
      'final submit',
      name: 'finalSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Register Car`
  String get registerCar {
    return Intl.message(
      'Register Car',
      name: 'registerCar',
      desc: '',
      args: [],
    );
  }

  /// `Edit Car`
  String get editCar {
    return Intl.message('Edit Car', name: 'editCar', desc: '', args: []);
  }

  /// `violation Car`
  String get violationCar {
    return Intl.message(
      'violation Car',
      name: 'violationCar',
      desc: '',
      args: [],
    );
  }

  /// `Car Tolls`
  String get carTolls {
    return Intl.message('Car Tolls', name: 'carTolls', desc: '', args: []);
  }

  /// `Highway Tolls`
  String get highwayTolls {
    return Intl.message(
      'Highway Tolls',
      name: 'highwayTolls',
      desc: '',
      args: [],
    );
  }

  /// `Marginal Park`
  String get marginalPark {
    return Intl.message(
      'Marginal Park',
      name: 'marginalPark',
      desc: '',
      args: [],
    );
  }

  /// `charges car`
  String get chargesCar {
    return Intl.message('charges car', name: 'chargesCar', desc: '', args: []);
  }

  /// `weatherPrediction`
  String get weatherPrediction {
    return Intl.message(
      'weatherPrediction',
      name: 'weatherPrediction',
      desc: '',
      args: [],
    );
  }

  /// `compass`
  String get compass {
    return Intl.message('compass', name: 'compass', desc: '', args: []);
  }

  /// `speedMeter`
  String get speedMeter {
    return Intl.message('speedMeter', name: 'speedMeter', desc: '', args: []);
  }

  /// `search`
  String get search {
    return Intl.message('search', name: 'search', desc: '', args: []);
  }

  /// `....`
  String get etc {
    return Intl.message('....', name: 'etc', desc: '', args: []);
  }

  /// `Enter at least three character to search`
  String get searchHint {
    return Intl.message(
      'Enter at least three character to search',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Register request`
  String get registerRequest {
    return Intl.message(
      'Register request',
      name: 'registerRequest',
      desc: '',
      args: [],
    );
  }

  /// `VIN number`
  String get vin {
    return Intl.message('VIN number', name: 'vin', desc: '', args: []);
  }

  /// `Do You Want To Exit From Your Account?`
  String get exitDescription {
    return Intl.message(
      'Do You Want To Exit From Your Account?',
      name: 'exitDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been successfully registered.`
  String get submitDialogDescription {
    return Intl.message(
      'Your request has been successfully registered.',
      name: 'submitDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Other Services`
  String get otherServices {
    return Intl.message(
      'Other Services',
      name: 'otherServices',
      desc: '',
      args: [],
    );
  }

  /// `chassis number is not correct`
  String get chassisNumberValidation {
    return Intl.message(
      'chassis number is not correct',
      name: 'chassisNumberValidation',
      desc: '',
      args: [],
    );
  }

  /// `Enter Chassis Number`
  String get enterChassisNo {
    return Intl.message(
      'Enter Chassis Number',
      name: 'enterChassisNo',
      desc: '',
      args: [],
    );
  }

  /// `filling star fields are mandatory`
  String get notNullValidation {
    return Intl.message(
      'filling star fields are mandatory',
      name: 'notNullValidation',
      desc: '',
      args: [],
    );
  }

  /// `entered national id is not correct`
  String get nationalIdLengthValidation {
    return Intl.message(
      'entered national id is not correct',
      name: 'nationalIdLengthValidation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Needed Information`
  String get confirmNeededInformation {
    return Intl.message(
      'Confirm Needed Information',
      name: 'confirmNeededInformation',
      desc: '',
      args: [],
    );
  }

  /// `registerRequestSuccess`
  String get registerRequestSuccess {
    return Intl.message(
      'registerRequestSuccess',
      name: 'registerRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Plat Car Must Be Full Or Clean`
  String get platCarMustBeFullOrClean {
    return Intl.message(
      'Plat Car Must Be Full Or Clean',
      name: 'platCarMustBeFullOrClean',
      desc: '',
      args: [],
    );
  }

  /// `Car Name is Mandatory`
  String get carNameIsMandatory {
    return Intl.message(
      'Car Name is Mandatory',
      name: 'carNameIsMandatory',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Code`
  String get trackingCode {
    return Intl.message(
      'Tracking Code',
      name: 'trackingCode',
      desc: '',
      args: [],
    );
  }

  /// `Please choose one item`
  String get noItemSelected {
    return Intl.message(
      'Please choose one item',
      name: 'noItemSelected',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose At Least One Item`
  String get selectAtLeastOneItem {
    return Intl.message(
      'Please Choose At Least One Item',
      name: 'selectAtLeastOneItem',
      desc: '',
      args: [],
    );
  }

  /// `Choose Service Provider`
  String get chooseServiceProvider {
    return Intl.message(
      'Choose Service Provider',
      name: 'chooseServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Choose Needed Services`
  String get chooseNeededServices {
    return Intl.message(
      'Choose Needed Services',
      name: 'chooseNeededServices',
      desc: '',
      args: [],
    );
  }

  /// `This Service will Provided by Emdad Khodro Saipa Soon`
  String get saipaDevelopingText {
    return Intl.message(
      'This Service will Provided by Emdad Khodro Saipa Soon',
      name: 'saipaDevelopingText',
      desc: '',
      args: [],
    );
  }

  /// `You must select a car model`
  String get pleaseSelectCarModel {
    return Intl.message(
      'You must select a car model',
      name: 'pleaseSelectCarModel',
      desc: '',
      args: [],
    );
  }

  /// `You must fill a car name`
  String get youMustBeEnterNameCar {
    return Intl.message(
      'You must fill a car name',
      name: 'youMustBeEnterNameCar',
      desc: '',
      args: [],
    );
  }

  /// `انتخاب شماره شاسی اجباری است`
  String get youMustBeSelectChassis {
    return Intl.message(
      'انتخاب شماره شاسی اجباری است',
      name: 'youMustBeSelectChassis',
      desc: '',
      args: [],
    );
  }

  /// `استعلام شماره شاسی اجباری است`
  String get youMustBeGetReferenceChassis {
    return Intl.message(
      'استعلام شماره شاسی اجباری است',
      name: 'youMustBeGetReferenceChassis',
      desc: '',
      args: [],
    );
  }

  /// `Please enter lastname`
  String get youMostBeSelectLastName {
    return Intl.message(
      'Please enter lastname',
      name: 'youMostBeSelectLastName',
      desc: '',
      args: [],
    );
  }

  /// `current kilometer must be between 0 until 999,999`
  String get currentKilometer {
    return Intl.message(
      'current kilometer must be between 0 until 999,999',
      name: 'currentKilometer',
      desc: '',
      args: [],
    );
  }

  /// `Buy Subscription {title}`
  String buyPurchaseTitle(Object title) {
    return Intl.message(
      'Buy Subscription $title',
      name: 'buyPurchaseTitle',
      desc: '',
      args: [title],
    );
  }

  /// `Original Price: `
  String get originalPrice {
    return Intl.message(
      'Original Price: ',
      name: 'originalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Final Price: `
  String get finalPrice {
    return Intl.message(
      'Final Price: ',
      name: 'finalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Have discount code? `
  String get haveDiscountCode {
    return Intl.message(
      'Have discount code? ',
      name: 'haveDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `Add Code`
  String get addDiscountCode {
    return Intl.message(
      'Add Code',
      name: 'addDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `Check Code`
  String get checkDiscountCode {
    return Intl.message(
      'Check Code',
      name: 'checkDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter discount code`
  String get enterDiscountCode {
    return Intl.message(
      'Enter discount code',
      name: 'enterDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `Discount Code`
  String get discountCode {
    return Intl.message(
      'Discount Code',
      name: 'discountCode',
      desc: '',
      args: [],
    );
  }

  /// `Entered code is not valid`
  String get discountCodeNotValid {
    return Intl.message(
      'Entered code is not valid',
      name: 'discountCodeNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter discount code`
  String get pleaseEnterDiscountCode {
    return Intl.message(
      'Please enter discount code',
      name: 'pleaseEnterDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender {
    return Intl.message('gender', name: 'gender', desc: '', args: []);
  }

  /// `male`
  String get male {
    return Intl.message('male', name: 'male', desc: '', args: []);
  }

  /// `female`
  String get female {
    return Intl.message('female', name: 'female', desc: '', args: []);
  }

  /// `Your profile is not complete, would you like to complete your information?`
  String get profileDialogNotCompletedMessage {
    return Intl.message(
      'Your profile is not complete, would you like to complete your information?',
      name: 'profileDialogNotCompletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Complete Profile`
  String get completeProfile {
    return Intl.message(
      'Complete Profile',
      name: 'completeProfile',
      desc: '',
      args: [],
    );
  }

  /// `later`
  String get later {
    return Intl.message('later', name: 'later', desc: '', args: []);
  }

  /// `applications`
  String get applicationHistory {
    return Intl.message(
      'applications',
      name: 'applicationHistory',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Request`
  String get cancelApplication {
    return Intl.message(
      'Cancel Request',
      name: 'cancelApplication',
      desc: '',
      args: [],
    );
  }

  /// `findNearestHelper`
  String get findNearestHelper {
    return Intl.message(
      'findNearestHelper',
      name: 'findNearestHelper',
      desc: '',
      args: [],
    );
  }

  /// `batteryHelpApplication`
  String get batteryHelpApplication {
    return Intl.message(
      'batteryHelpApplication',
      name: 'batteryHelpApplication',
      desc: '',
      args: [],
    );
  }

  /// `moveApplication`
  String get moveApplication {
    return Intl.message(
      'moveApplication',
      name: 'moveApplication',
      desc: '',
      args: [],
    );
  }

  /// `aDoneApplication`
  String get aDoneApplication {
    return Intl.message(
      'aDoneApplication',
      name: 'aDoneApplication',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message('details', name: 'details', desc: '', args: []);
  }

  /// `cancel`
  String get cancelRequest {
    return Intl.message('cancel', name: 'cancelRequest', desc: '', args: []);
  }

  /// `1401/04/27`
  String get date {
    return Intl.message('1401/04/27', name: 'date', desc: '', args: []);
  }

  /// `14:25`
  String get time {
    return Intl.message('14:25', name: 'time', desc: '', args: []);
  }

  /// `Info`
  String get info {
    return Intl.message('Info', name: 'info', desc: '', args: []);
  }

  /// `Active Subscription`
  String get activeSubscription {
    return Intl.message(
      'Active Subscription',
      name: 'activeSubscription',
      desc: '',
      args: [],
    );
  }

  /// `End Date: `
  String get endDate {
    return Intl.message('End Date: ', name: 'endDate', desc: '', args: []);
  }

  /// `No Active Subscription`
  String get noActiveSubscribe {
    return Intl.message(
      'No Active Subscription',
      name: 'noActiveSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `No car defined`
  String get noCarDefined {
    return Intl.message(
      'No car defined',
      name: 'noCarDefined',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Car`
  String get pleaseSelectCar {
    return Intl.message(
      'Please Select Car',
      name: 'pleaseSelectCar',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Number not Valid`
  String get invoiceNumberNotValid {
    return Intl.message(
      'Invoice Number not Valid',
      name: 'invoiceNumberNotValid',
      desc: '',
      args: [],
    );
  }

  /// `No Item To View`
  String get noItemToView {
    return Intl.message(
      'No Item To View',
      name: 'noItemToView',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Payment`
  String get invoiceCouponPayment {
    return Intl.message(
      'Invoice Payment',
      name: 'invoiceCouponPayment',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice Number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter invoice number`
  String get pleaseEnterInvoiceNumber {
    return Intl.message(
      'Please enter invoice number',
      name: 'pleaseEnterInvoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `New version of the app is available, want to download?`
  String get updateAppText {
    return Intl.message(
      'New version of the app is available, want to download?',
      name: 'updateAppText',
      desc: '',
      args: [],
    );
  }

  /// `tehran`
  String get tehran {
    return Intl.message('tehran', name: 'tehran', desc: '', args: []);
  }

  /// `manometer`
  String get pressureMeter {
    return Intl.message('manometer', name: 'pressureMeter', desc: '', args: []);
  }

  /// `wind`
  String get wind {
    return Intl.message('wind', name: 'wind', desc: '', args: []);
  }

  /// `wind blow`
  String get windBlow {
    return Intl.message('wind blow', name: 'windBlow', desc: '', args: []);
  }

  /// `speed (km/h):`
  String get speed {
    return Intl.message('speed (km/h):', name: 'speed', desc: '', args: []);
  }

  /// `am`
  String get am {
    return Intl.message('am', name: 'am', desc: '', args: []);
  }

  /// `pm`
  String get pm {
    return Intl.message('pm', name: 'pm', desc: '', args: []);
  }

  /// `temperature (celsius):`
  String get temperatureDegreesCelsius {
    return Intl.message(
      'temperature (celsius):',
      name: 'temperatureDegreesCelsius',
      desc: '',
      args: [],
    );
  }

  /// `humidity`
  String get humidity {
    return Intl.message('humidity', name: 'humidity', desc: '', args: []);
  }

  /// `air pressure`
  String get airPressure {
    return Intl.message(
      'air pressure',
      name: 'airPressure',
      desc: '',
      args: [],
    );
  }

  /// `subscription history`
  String get subscriptionHistory {
    return Intl.message(
      'subscription history',
      name: 'subscriptionHistory',
      desc: '',
      args: [],
    );
  }

  /// `request `
  String get request {
    return Intl.message('request ', name: 'request', desc: '', args: []);
  }

  /// `confirm date: `
  String get confirmDate {
    return Intl.message(
      'confirm date: ',
      name: 'confirmDate',
      desc: '',
      args: [],
    );
  }

  /// `no request found`
  String get noHistory {
    return Intl.message(
      'no request found',
      name: 'noHistory',
      desc: '',
      args: [],
    );
  }

  /// `profile Compliting Warning`
  String get profileComplitingWarning {
    return Intl.message(
      'profile Compliting Warning',
      name: 'profileComplitingWarning',
      desc: '',
      args: [],
    );
  }

  /// `profile Compliting`
  String get profileCompliting {
    return Intl.message(
      'profile Compliting',
      name: 'profileCompliting',
      desc: '',
      args: [],
    );
  }

  /// `Your Device Is Not Supported Biometric`
  String get biometricNotSupported {
    return Intl.message(
      'Your Device Is Not Supported Biometric',
      name: 'biometricNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `Your Are Not Enabled Biometric`
  String get biometricNotEnabled {
    return Intl.message(
      'Your Are Not Enabled Biometric',
      name: 'biometricNotEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Login With Mobile Number`
  String get loginWithMobileNumber {
    return Intl.message(
      'Login With Mobile Number',
      name: 'loginWithMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Night`
  String get night {
    return Intl.message('Night', name: 'night', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `UnActive`
  String get unActive {
    return Intl.message('UnActive', name: 'unActive', desc: '', args: []);
  }

  /// `Fingerprint`
  String get fingerprint {
    return Intl.message('Fingerprint', name: 'fingerprint', desc: '', args: []);
  }

  /// `Authentication Required`
  String get authenticationRequired {
    return Intl.message(
      'Authentication Required',
      name: 'authenticationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verify Identity`
  String get verifyIdentity {
    return Intl.message(
      'Verify Identity',
      name: 'verifyIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Scan Your Fingerprint To Authenticate`
  String get scanFingerPrint {
    return Intl.message(
      'Scan Your Fingerprint To Authenticate',
      name: 'scanFingerPrint',
      desc: '',
      args: [],
    );
  }

  /// `Scan Your FaceID To Authenticate`
  String get scanFaceId {
    return Intl.message(
      'Scan Your FaceID To Authenticate',
      name: 'scanFaceId',
      desc: '',
      args: [],
    );
  }

  /// `Login With FingerPrint `
  String get loginWithFingerPrint {
    return Intl.message(
      'Login With FingerPrint ',
      name: 'loginWithFingerPrint',
      desc: '',
      args: [],
    );
  }

  /// `Login With FaceID `
  String get loginWithFaceId {
    return Intl.message(
      'Login With FaceID ',
      name: 'loginWithFaceId',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Required`
  String get biometricRequired {
    return Intl.message(
      'Biometric Required',
      name: 'biometricRequired',
      desc: '',
      args: [],
    );
  }

  /// `Go To Setting`
  String get goToSetting {
    return Intl.message(
      'Go To Setting',
      name: 'goToSetting',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication is not set up on your device. Go to Settings > Security to add biometric authentication.`
  String get goToSettingDescription {
    return Intl.message(
      'Biometric authentication is not set up on your device. Go to Settings > Security to add biometric authentication.',
      name: 'goToSettingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Authentication`
  String get biometricAuthentication {
    return Intl.message(
      'Biometric Authentication',
      name: 'biometricAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `Is Valid`
  String get isValid {
    return Intl.message('Is Valid', name: 'isValid', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `car Name:`
  String get carNamee {
    return Intl.message('car Name:', name: 'carNamee', desc: '', args: []);
  }

  /// `Time Of Providing Service`
  String get timeOfProvidingService {
    return Intl.message(
      'Time Of Providing Service',
      name: 'timeOfProvidingService',
      desc: '',
      args: [],
    );
  }

  /// `agents`
  String get agents {
    return Intl.message('agents', name: 'agents', desc: '', args: []);
  }

  /// `search agents`
  String get searchAgents {
    return Intl.message(
      'search agents',
      name: 'searchAgents',
      desc: '',
      args: [],
    );
  }

  /// `search based on name,code,address`
  String get searchAgentsHint {
    return Intl.message(
      'search based on name,code,address',
      name: 'searchAgentsHint',
      desc: '',
      args: [],
    );
  }

  /// `call`
  String get call {
    return Intl.message('call', name: 'call', desc: '', args: []);
  }

  /// `routing`
  String get routing {
    return Intl.message('routing', name: 'routing', desc: '', args: []);
  }

  /// `No Internet Connection`
  String get noConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noConnection',
      desc: '',
      args: [],
    );
  }

  /// `Make Sure You have internet connection`
  String get makeSureHavingInternetConnection {
    return Intl.message(
      'Make Sure You have internet connection',
      name: 'makeSureHavingInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `retry`
  String get retry {
    return Intl.message('retry', name: 'retry', desc: '', args: []);
  }

  /// `096550`
  String get phoneNumber {
    return Intl.message('096550', name: 'phoneNumber', desc: '', args: []);
  }

  /// `Offline Service`
  String get offlineService {
    return Intl.message(
      'Offline Service',
      name: 'offlineService',
      desc: '',
      args: [],
    );
  }

  /// `Call Emdad Khodro`
  String get callServiceProvider {
    return Intl.message(
      'Call Emdad Khodro',
      name: 'callServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `gas stations`
  String get gasStation {
    return Intl.message('gas stations', name: 'gasStation', desc: '', args: []);
  }

  /// `search gas stations`
  String get searchGasStations {
    return Intl.message(
      'search gas stations',
      name: 'searchGasStations',
      desc: '',
      args: [],
    );
  }

  /// `has benzin`
  String get hasBenzin {
    return Intl.message('has benzin', name: 'hasBenzin', desc: '', args: []);
  }

  /// `has CNG`
  String get hasCNG {
    return Intl.message('has CNG', name: 'hasCNG', desc: '', args: []);
  }

  /// `has not benzin`
  String get hasNotBenzin {
    return Intl.message(
      'has not benzin',
      name: 'hasNotBenzin',
      desc: '',
      args: [],
    );
  }

  /// `has not CNG`
  String get hasNotCNG {
    return Intl.message('has not CNG', name: 'hasNotCNG', desc: '', args: []);
  }

  /// `Device is not safe`
  String get deviceNotSafe {
    return Intl.message(
      'Device is not safe',
      name: 'deviceNotSafe',
      desc: '',
      args: [],
    );
  }

  /// `App can not run on this device`
  String get appCanNotBeUsedOnThisDevice {
    return Intl.message(
      'App can not run on this device',
      name: 'appCanNotBeUsedOnThisDevice',
      desc: '',
      args: [],
    );
  }

  /// `Close App`
  String get closeApp {
    return Intl.message('Close App', name: 'closeApp', desc: '', args: []);
  }

  /// `Car Color`
  String get carColor {
    return Intl.message('Car Color', name: 'carColor', desc: '', args: []);
  }

  /// `Engine Number`
  String get engineNumber {
    return Intl.message(
      'Engine Number',
      name: 'engineNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose Colors Of Car`
  String get chooseCarColor {
    return Intl.message(
      'Please Choose Colors Of Car',
      name: 'chooseCarColor',
      desc: '',
      args: [],
    );
  }

  /// `Activate Subscription`
  String get activateSubscription {
    return Intl.message(
      'Activate Subscription',
      name: 'activateSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Activation`
  String get activation {
    return Intl.message('Activation', name: 'activation', desc: '', args: []);
  }

  /// `Activate Code`
  String get activateCode {
    return Intl.message(
      'Activate Code',
      name: 'activateCode',
      desc: '',
      args: [],
    );
  }

  /// `مشتری گرامی، ضمن تشکر از خرید اشتراک در دفاتر پیشخوان دولت الکترونیک، خواهشمند است جهت فعالسازی اشتراک خود از طریق دکمه فعالسازی زیر اقدام نمایید.`
  String get activatePishkhanDescription1 {
    return Intl.message(
      'مشتری گرامی، ضمن تشکر از خرید اشتراک در دفاتر پیشخوان دولت الکترونیک، خواهشمند است جهت فعالسازی اشتراک خود از طریق دکمه فعالسازی زیر اقدام نمایید.',
      name: 'activatePishkhanDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Important Note: `
  String get importantNote {
    return Intl.message(
      'Important Note: ',
      name: 'importantNote',
      desc: '',
      args: [],
    );
  }

  /// `فعال شدن اشتراک خریداری شده منوط به تکمیل اطلاعات خودرو می باشد.`
  String get activatePishkhanDescription2 {
    return Intl.message(
      'فعال شدن اشتراک خریداری شده منوط به تکمیل اطلاعات خودرو می باشد.',
      name: 'activatePishkhanDescription2',
      desc: '',
      args: [],
    );
  }

  /// `show pic`
  String get showPic {
    return Intl.message('show pic', name: 'showPic', desc: '', args: []);
  }

  /// `Activate Pishkhan Subscription`
  String get activatePishkhanSubscription {
    return Intl.message(
      'Activate Pishkhan Subscription',
      name: 'activatePishkhanSubscription',
      desc: '',
      args: [],
    );
  }

  /// `License Number`
  String get licenseNumber {
    return Intl.message(
      'License Number',
      name: 'licenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `moreThan10CarIsNotAllowed`
  String get moreThan10CarIsNotAllowed {
    return Intl.message(
      'moreThan10CarIsNotAllowed',
      name: 'moreThan10CarIsNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `APP Version`
  String get appVersion {
    return Intl.message('APP Version', name: 'appVersion', desc: '', args: []);
  }

  /// `Car Info`
  String get carInfo {
    return Intl.message('Car Info', name: 'carInfo', desc: '', args: []);
  }

  /// `Request Info`
  String get requestInfo {
    return Intl.message(
      'Request Info',
      name: 'requestInfo',
      desc: '',
      args: [],
    );
  }

  /// `Request Number`
  String get requestNumber {
    return Intl.message(
      'Request Number',
      name: 'requestNumber',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message('Service', name: 'service', desc: '', args: []);
  }

  /// `Car Status`
  String get carStatus {
    return Intl.message('Car Status', name: 'carStatus', desc: '', args: []);
  }

  /// `Customer Info`
  String get emdadKhahInfo {
    return Intl.message(
      'Customer Info',
      name: 'emdadKhahInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name and Last Name`
  String get nameAndLastName {
    return Intl.message(
      'Name and Last Name',
      name: 'nameAndLastName',
      desc: '',
      args: [],
    );
  }

  /// `physicalLimitation`
  String get physicalLimitation {
    return Intl.message(
      'physicalLimitation',
      name: 'physicalLimitation',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت ممنوع الخروجی`
  String get najiCountryLeavingPermission {
    return Intl.message(
      'وضعیت ممنوع الخروجی',
      name: 'najiCountryLeavingPermission',
      desc: '',
      args: [],
    );
  }

  /// `گواهینامه های رانندگی`
  String get najiDrivingLicenses {
    return Intl.message(
      'گواهینامه های رانندگی',
      name: 'najiDrivingLicenses',
      desc: '',
      args: [],
    );
  }

  /// `پلاک‌های فعال`
  String get najiLicensePlates {
    return Intl.message(
      'پلاک‌های فعال',
      name: 'najiLicensePlates',
      desc: '',
      args: [],
    );
  }

  /// `نمره منفی`
  String get najiNegativePoint {
    return Intl.message(
      'نمره منفی',
      name: 'najiNegativePoint',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت گذرنامه`
  String get najiPassportStatus {
    return Intl.message(
      'وضعیت گذرنامه',
      name: 'najiPassportStatus',
      desc: '',
      args: [],
    );
  }

  /// `وضعیت کارت و سند خودرو`
  String get najiVehiclesDocuments {
    return Intl.message(
      'وضعیت کارت و سند خودرو',
      name: 'najiVehiclesDocuments',
      desc: '',
      args: [],
    );
  }

  /// `تجمیع تخلفات خودرو`
  String get najiVehiclesViolationsAggregate {
    return Intl.message(
      'تجمیع تخلفات خودرو',
      name: 'najiVehiclesViolationsAggregate',
      desc: '',
      args: [],
    );
  }

  /// `تخلفات خودرو بدون احراز هویت`
  String get najiVehiclesViolationsAggregateWithoutAuthentication {
    return Intl.message(
      'تخلفات خودرو بدون احراز هویت',
      name: 'najiVehiclesViolationsAggregateWithoutAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `تصویر تخلف خودرو`
  String get najiVehiclesViolationsImage {
    return Intl.message(
      'تصویر تخلف خودرو',
      name: 'najiVehiclesViolationsImage',
      desc: '',
      args: [],
    );
  }

  /// `تخلفات وسیله نقلیه`
  String get najiVehiclesViolations {
    return Intl.message(
      'تخلفات وسیله نقلیه',
      name: 'najiVehiclesViolations',
      desc: '',
      args: [],
    );
  }

  /// `استعلام`
  String get inquiry {
    return Intl.message('استعلام', name: 'inquiry', desc: '', args: []);
  }

  /// `استعلام اصالت خودرو`
  String get najiVehiclesCondition {
    return Intl.message(
      'استعلام اصالت خودرو',
      name: 'najiVehiclesCondition',
      desc: '',
      args: [],
    );
  }

  /// `سوابق خدمات خودرویی`
  String get najiServicesHistory {
    return Intl.message(
      'سوابق خدمات خودرویی',
      name: 'najiServicesHistory',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
