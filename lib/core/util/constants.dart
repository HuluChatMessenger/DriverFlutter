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
  static const String errMsgEmptyPlateNo =
      "Please enter your car's plate number!";
  static const String errMsgEmptyMakeYear =
      "Please enter your car's make year!";
  static const String errMsgValidPlateNo = "Please enter a valid plate number!";
  static const String errMsgValidMakeYear = "Please enter a valid make year!";
  static const String errMsgPic = "Picture not picked. Please try again!";
  static const String errMsgFeedbackType = "Please select feedbackType";
  static const String errMsgUrgencyLeve = "Please select urgency level!";
  static const String errMsgEmptyFeedback = "Please enter feedback!";
  static const String errMsgAirtime =
      'Sorry, airtime exchange service is not available at the moment. Please, try again a bit later!';

  //Strings
  static const String strAppName = 'HuluTaxi';
  static const String strCopyright = '©';
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
  static const String strWallet = 'Wallet';
  static const String strTripHistory = 'Trip History';
  static const String strEarnings = 'Earnings';
  static const String strDocuments = 'Documents';
  static const String strMyAccount = 'My Account';
  static const String strHuluCoin = 'HuluCoin';
  static const String strFeedback = 'Feedback';
  static const String strTheme = 'Theme';
  static const String strLanguage = 'Language';
  static const String strAccountDetailsTitle = 'ACCOUNT DETAILS';
  static const String strVehicleDetailsTitle = 'VEHICLE DETAILS';
  static const String strPhoneNoTitle = 'PHONE NO';
  static const String strReferralTitle = 'REFERRAL CODE';
  static const String strModelTitle = 'MODEL';
  static const String strColorTitle = 'COLOR';
  static const String strPlateNoTitle = 'PLATE NO';
  static const String strFeedbackType = 'Feedback Type';
  static const String strUrgencyLevel = 'Urgency Level';
  static const String strPromptFeedback = 'Enter feedback';
  static const String strSend = 'Send';
  static const String strDeposit = 'Deposit';
  static const String strWalletNo = '9834 7502 1684 2984';
  static const String strWalletMember = 'Member Since';
  static const String strWalletDate = '05/22';
  static const String strWalletBalance = 'Balance';
  static const String strBirr = 'Birr';
  static const String strTrips = 'Trips';
  static const String strBuyAirtime = 'Buy Airtime';
  static const String strFuelCoupon = 'Fuel Coupon';
  static const String strFuelCouponMsg =
      'Head to our main office to convert your HuluCoin to fuel coupons.';
  static const String str0 = '0';
  static const String strCurrentBalance = 'Current Balance';
  static const String strToday = 'Today';
  static const String strTripDetail = 'Trip Details';
  static const String strDate = 'Date';
  static const String strTime = 'Time';
  static const String strPrice = 'Price';
  static const String strDistance = 'Distance';
  static const String strStatus = 'Status';
  static const String strComingSoon = 'Coming Soon!';
  static const String strCancel = 'Cancel';
  static const String strSubmit = 'Submit';
  static const String strCoinDesc =
      'Please pick one of the available mobile cards from below.';
  static const String strCoin50 = '50 Br';
  static const String strCoin100 = '100 Br';
  static const String strAirtimeSuccessStart =
      'successfully began transferring to';
  static const String strAirtimeSuccessEnd =
      "from your HuluCoin balance. You'll receive notification when the airtime is added to your card.";
  static const String strOnlineHrs = "Online Hrs";
  static const String strLogout = "Logout";
  static const String strLogoutMsg =
      "Are you sure you want to Logout from the Hulu Taxi?";
}
