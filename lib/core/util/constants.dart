abstract class AppConstants {
  //Url
  static const baseUrl = "https://api.huluchat.com/";
  static const urlTerms = 'https://hulugram.org/hulutaxi/termsandconditions';

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

  // Prefs
  static const prefKeyConfig = 'PREF_KEY_CONFIG';
  static const prefKeyDriver = 'PREF_KEY_DRIVER';
  static const prefKeyLogin = 'PREF_KEY_LOGIN';
  static const prefKeyToken = 'PREF_KEY_TOKEN';

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

  //Errors
  static const String errMsgServer = 'Server Failure';
  static const String errMsgCache = 'Cache Failure';
  static const String errMsgConnection =
      'Unable to connect to the internet. Please check your connection.';
  static const String errMsgUnknown = 'Some error occurred. Please, try again!';
  static const String errMsgLogout =
      'Sorry, your account has been logged out of. Please login!';
  static const String errMsgPhone =
      'Phone number starts with the digit 9 or 7!';
  static const String errMsgEmptyFirst = 'Please enter first name!';
  static const String errMsgEmptyFather = "Please enter father's name!";
  static const String errMsgEmptyGrandfather =
      "Please enter grandfather's name!";
  static const String errMsgEmptyPhone = 'Please enter a phone number!';
  static const String errTerms = 'Please accept terms and conditions!';
  static const String errMsgModel = "Please select your car's model!";
  static const String errMsgColor = "Please select your car's color!";
  static const String errMsgEmptyPlateNo = "Please enter your car's plate number!";
  static const String errMsgEmptyMakeYear = "Please enter your car's make year!";
  static const String errMsgValidPlateNo = "Please enter a valid plate number!";
  static const String errMsgValidMakeYear = "Please enter a valid make year!";
  static const String errMsgPic = "Picture not picked. Please try again!";

  //Strings
  static const String strRegister = 'REGISTER';
  static const String strLogin = 'LOGIN';
  static const String strChooseLanguage = 'ቋንቋ ይምረጡ / Choose Language';
  static const String strAddPhotoTitle = 'Profile Photo';
  static const String strAddPhotoSub = 'Add Your Photo';
  static const String strAddVehicleTitle = 'Add Vehicle';
  static const String strBack = 'Back';
  static const String strContinue = 'Continue';
  static const String strResend = 'Resend Code';
  static const String strResendTimer = 'in 0 seconds';
  static const String strGreetingFirst = 'Hello, nice to meet you';
  static const String strGreetingSecondLogin = 'Login To HuluTaxi!';
  static const String strGreetingThirdLogin =
      'Please enter the phone number that you registered with.';
  static const String strGreetingSecondRegistration = 'Join HuluTaxi!';
  static const String strOtpFirst = 'Phone Verification';
  static const String strOtpSecond = 'Enter your OTP code';
  static const String strOtpThird = 'Enter the 5-digit code sent to you at ';
  static const String strPromptPhone = 'Phone Number';
  static const String strPromptFirstName = 'First Name';
  static const String strPromptFatherName = "Father's Name";
  static const String strPromptGFatherName = "Grandfather's Name";
  static const String strPromptReferralCode = 'Referral Code';
  static const String strPromptPlateNo = 'AA-01-A12345';
  static const String strPromptMakeYear = 'Make Year';
  static const String strModel = 'Model';
  static const String strColor = 'Color';
  static const String strRegisterVehicle = 'Register Vehicle';
  static const String strAgree = 'I agree to the';
  static const String strTerms = 'Terms & Conditions';
  static const String strThanks = 'Thank You!';
  static const String strWaitingTxt =
      'Thank you for submitting the required documents. We are evaluating your documents, you will receive a notification when your account is activated.';
  static const String strFinish = 'Finish';
  static const String strDoc = 'Driver Documents';
  static const String strDocReq = 'Required Document';
  static const String strUpload = 'Upload';
}
