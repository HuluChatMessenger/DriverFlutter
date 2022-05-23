import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

enum LanguageValues { en, am }

class LanguageControlsWidget extends StatefulWidget {
  final sharedPreferences;

  LanguageControlsWidget({Key? key, required this.sharedPreferences})
      : super(key: key);

  @override
  _LanguageControlsWidgetState createState() => _LanguageControlsWidgetState();
}

class _LanguageControlsWidgetState extends State<LanguageControlsWidget> {
  bool isInitialLanguageSet = true;
  String currentLanguage = AppConstants.languageAm;
  LanguageValues selectedValue = LanguageValues.am;

  @override
  Widget build(BuildContext context) {
    // selectedValue = getCurrentSelectedLanguage();
    setCurrentLanguage();
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.elliptical(24, 24),
            topRight: Radius.elliptical(24, 24)),
        color: Colors.grey.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                'strSelectLanguage'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${'strCurrentLanguage'.tr}  ',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Text(
                  getCurrentLanguage(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            languageRadioButton(
                AppConstants.titleAm, LanguageValues.am, radioBtnSelection),
            const SizedBox(height: 16),
            languageRadioButton(
                AppConstants.titleEn, LanguageValues.en, radioBtnSelection),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }

  void radioBtnSelection(LanguageValues value) {
    setState(() {
      isInitialLanguageSet = false;
      selectedValue = value;
      setLanguage();
      Navigator.pop(context);
    });
  }

  Widget languageRadioButton(
      String title, LanguageValues value, Function onChanged) {
    return RadioListTile(
      activeColor: Colors.green,
      value: value,
      groupValue: selectedValue,
      onChanged: (value) {
        onChanged(value);
      },
      title: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: flagIcon(value),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget flagIcon(LanguageValues value) {
    if (value == LanguageValues.en) {
      return SvgPicture.asset('assets/icons/us.svg',
          semanticsLabel: 'Country Flag');
    }
    return SvgPicture.asset('assets/icons/et.svg',
        semanticsLabel: 'Country Flag');
  }

  void setCurrentLanguage() {
    String? currentSavedLanguage =
        widget.sharedPreferences.getString(AppConstants.prefKeyLanguage);
    currentLanguage = (currentSavedLanguage != null)
        ? currentSavedLanguage
        : AppConstants.languageAm;
    if (isInitialLanguageSet) {
      selectedValue = getCurrentSelectedLanguage();
    }
  }

  LanguageValues getCurrentSelectedLanguage() {
    if (currentLanguage == AppConstants.languageEn) {
      return LanguageValues.en;
    }
    return LanguageValues.am;
  }

  String getCurrentLanguage() {
    if (currentLanguage == AppConstants.languageEn) {
      return AppConstants.titleEn;
    }
    return AppConstants.titleAm;
  }

  void setLanguage() {
    LanguageValues oldLanguage = LanguageValues.am;
    String type = AppConstants.languageTypeAm;
    String language = AppConstants.languageAm;
    if (currentLanguage == AppConstants.languageEn) {
      oldLanguage = LanguageValues.en;
    }

    if (oldLanguage.name != selectedValue.name) {
      if (selectedValue.name == LanguageValues.en.name) {
        type = AppConstants.languageTypeEn;
        language = AppConstants.languageEn;
      }
      print('LogHulu: $oldLanguage === $selectedValue === $type == $language');
      var locale = Locale(language, type);
      Get.updateLocale(locale);
      widget.sharedPreferences.setString(
        AppConstants.prefKeyLanguage,
        language,
      );
    }
  }
}
