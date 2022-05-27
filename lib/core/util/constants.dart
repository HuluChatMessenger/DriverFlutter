abstract class AppConstants {
  //Url
  static const baseUrl = "https://api.huluchat.com/";
  static const urlTerms = 'https://hulugram.org/hulutaxi/termsandconditions';
  static const apiKey = 'AIzaSyDywlkflWqYCy3_bQHu0lka5Ybr3YUN5s0';

  //EndPoints
  static const apiEndpointConfiguration = 'huluride/configurations/';
  static const apiEndpointRegister = 'huluride/register/';
  static const apiEndpointOtpRegister = 'huluride/register.otp.verify/';
  static const apiEndpointOtpRegisterResend = 'huluride/register.otp.resend/';
  static const apiEndpointOtpLoginSend = 'huluride/auth.otp.send/';
  static const apiEndpointLogin = 'huluride/auth/';
  static const apiEndpointDriver = 'huluride/driver/';
  static const apiEndpointPic = 'photo.upload/';
  static const apiEndpointVehicle = 'huluride/driver/vehicle/';
  static const apiEndpointDocument = 'huluride/driver/document/';
  static const apiEndpointFeedback = 'huluride/driver/feedback/';
  static const apiEndpointWallet = 'huluride/wallet/transactions/';
  static const apiEndpointTrip = 'huluride/driver/trips/';
  static const apiEndpointHuluCoinBalance = 'huluride/hulucoin/balance/';
  static const apiEndpointService = 'hulupay/services/';
  static const apiEndpointServiceRequest = 'hulupay/service-requests/';
  static const apiEndpointEarningWeek = 'huluride/driver/earnings/last7days/';
  static const apiEndpointEarningWeekTwo =
      'huluride/driver/earnings/last14days/';
  static const apiEndpointEarningMonth = 'huluride/driver/earnings/thismonth/';
  static const apiEndpointEarningMonthThree =
      'huluride/driver/earnings/threemonth/';
  static const apiEndpointEarningMonthSix =
      'huluride/driver/earnings/sixmonth/';
  static const apiEndpointEarningsListWeek =
      'huluride/driver/earnings.bytime/last7days/';
  static const apiEndpointEarningsListWeekTwo =
      'huluride/driver/earnings.bytime/last14days/';
  static const apiEndpointEarningsListMonth =
      'huluride/driver/earnings.bytime/thismonth/';
  static const apiEndpointEarningsListMonthThree =
      'huluride/driver/earnings.bytime/threemonth/';
  static const apiEndpointEarningsListMonthSix =
      'huluride/driver/earnings.bytime/sixmonth/';

  // Prefs
  static const prefKeyConfig = 'PREF_KEY_CONFIG';
  static const prefKeyDriver = 'PREF_KEY_DRIVER';
  static const prefKeyLogin = 'PREF_KEY_LOGIN';
  static const prefKeyToken = 'PREF_KEY_TOKEN';
  static const prefKeyLanguage = 'PREF_KEY_LANGUAGE';

  // Prefs
  static const languageEn = 'en';
  static const languageTypeEn = 'US';
  static const languageAm = 'am';
  static const languageTypeAm = 'ET';
  static const titleEn = 'ENGLISH';
  static const titleAm = 'አማርኛ';

  // Splash
  static const splashLanding = 'SPLASH_LANDING';
  static const splashPic = 'SPLASH_PIC';
  static const splashVehicle = 'SPLASH_VEHICLE';
  static const splashDocuments = 'SPLASH_DOCUMENTS';
  static const splashWaiting = 'SPLASH_WAITING';
  static const splashLogin = 'SPLASH_LOGIN';

  // Dialog
  static const dialogTypeLoading = 'DIALOG_LOADING';
  static const dialogTypeErr = 'DIALOG_ERROR';
  static const dialogTypeMsg = 'DIALOG_MESSAGE';

  //Date Format
  static const isoDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

  //Date Format
  static const phoneNumberCallCenter = "9399";

  //MAP
  static const double cameraZoom = 19.151926040649414;
  static const double cameraTilt = 59.440717697143555;
  static const double cameraBearing = 192.8334901395799;

  //Strings
  static const String strAppName = 'HuluTaxi';
  static const String strCopyright = '©';
  static const String strChooseLanguage = 'ቋንቋ ይምረጡ / Choose Language';
  static const String strPromptPlateNo = 'AA-01-A12345';
  static const String strWalletNo = '9834 7502 1684 2984';
  static const String strWalletDate = '05/22';
  static const String str0 = '0';
  static const String strBalanceHidden = "***";
}
