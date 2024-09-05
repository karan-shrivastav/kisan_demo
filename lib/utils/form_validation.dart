import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppFormValidation {
  static String? validateMobile(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterYourMobileNumber;
    }
    for (int i = 0; i < value.length; i++) {
      if (int.parse(value[0]) < int.parse("6")) {
        return "Please enter 10 digit mobile number starting 6 and above";
      }
      RegExp regex = RegExp(r'^[6-9]\d{9}$');
      if (!regex.hasMatch(value)) {
        return AppLocalizations.of(context)!.pleaseEnterAValidMobileNumber;
      }
    }
    return null;
  }

  static String? validateCaptcha(
      {required String? captchaValue,
      required String? enteredCaptcha,
      required BuildContext context}) {
    if (kDebugMode) {
      print(captchaValue);
    }
    if (enteredCaptcha == null || enteredCaptcha.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterCaptcha;
    }

    if (captchaValue != enteredCaptcha) {
      return AppLocalizations.of(context)!.pleaseEnterValidCaptcha;
    }

    return null;
  }

  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fullNameAPerAadhaarIsRequired;
    }

    if (value.length < 2) {
      return AppLocalizations.of(context)!.textMustContainAtLeast4Characters;
    }

    // Check for numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }

    // Check for special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }

    // Check for multiple consecutive spaces
    if (RegExp(r'\s\s+').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }
// Check if ends with a space
//     if (value.endsWith(' ')) {
//       return AppLocalizations.of(context)!.pleaseEnterValidName;
//     }
    return null;
  }

  static String? validateNameRelationName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fatherHusbandRequired;
    }

    if (value.length < 2) {
      return AppLocalizations.of(context)!.textMustContainAtLeast4Characters;
    }

    // Check for numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }

    // Check for special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }

    // Check for multiple consecutive spaces
    if (RegExp(r'\s\s+').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidName;
    }

    return null;
  }

  static String? validateDate(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseSelectDate;
    }

    return null;
  }

  static String? validateIdProof(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.idProofRequired;
    }
    return null;
  }

  static String? validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter panCard number ';
    }
    RegExp regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid panCard number';
    }
    return null;
  }

  static String? validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter passport number';
    }
    RegExp regex = RegExp(r'^[A-Z]{1,3}[0-9]{7,9}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid passport number';
    }
    return null;
  }

  static String? validateDrivingLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter  driving license number';
    }
    RegExp regex = RegExp(r'^([A-Z]{2}\d{2}|[A-Z]{2}-\d{2})(19|20)\d{2}\d{7}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid driving license number';
    }
    return null;
  }

  static String? validateVoterId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid voter id';
    }
    RegExp regex = RegExp(r'^[A-Z]{3}[0-9]{7}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid voter id';
    }
    return null;
  }

  static String? validateReligion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select religion';
    }
    return null;
  }

  static String? validateRelation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select relation';
    }
    return null;
  }

  static String? validateOccupation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select occupation';
    }
    return null;
  }

  /// ******** Full Address *************

  static String? validateFullAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < 30) {
      return 'Address should be 30 character';
    }

    if (RegExp(r'\s\s+').hasMatch(value)) {
      return 'Please enter a valid address';
    }


    return null;
  }

  /// ******** State  *************
  static String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select state';
    }
    return null;
  }

  /// ******** District *************
  static String? validateDistrict(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select district';
    }
    return null;
  }

  /// ******** District *************
  static String? validateVillage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select village/locality';
    }
    return null;
  }

  /// ******** pinCode *************
  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter pin code';
    }

    RegExp regex = RegExp(r'^[2-9][0-9]{5}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid pin code';
    }

    return null;
  }

  /// ********  Age *************
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter age';
    }

    if (int.parse(value) < 18) {
      return 'Age should be greater than 17';
    }
    return null;
  }

  /// ********  Email Validator *************
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// ********  Income *************
  static String? validateIncome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter income';
    }
    if (value.length < 3) {
      return 'Text must contain at least 3 characters';
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Gender';
    }
    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Username';
    }
    return null;
  }

  /// ********  Survey Number  *************
  static String? surveyNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter survey number';
    }
    return null;
  }

  /// ********  Survey Number  *************
  static String? landSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter size of land';
    }
    return null;
  }

  /// ********  Area Unit  *************
  static String? areaUnit(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter area unit type';
    }
    return null;
  }

  /// ********  Source of Irrigation   *************
  static String? sourceOfIrrigation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select source of irrigation';
    }
    return null;
  }

  /// ********  type of owner ship  *************
  static String? typeOfOwnerShip(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select type of ownerShip';
    }
    return null;
  }

  /// ********  Encumbered   *************
  static String? encumbered(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select encumbered';
    }
    return null;
  }

  /// ********  Bank type    *************///
  static String? bankType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select bank type';
    }
    return null;
  }

  /// ********  Bank type    *************///
  static String? bank(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select bank';
    }
    return null;
  }

  static String? validateBranch(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select branch';
    }
    return null;
  }

  static String? validatePacs(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select pacs';
    }
    return null;
  }

  static String? validateAadhar(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter aadhar number';
    }
    final RegExp regex = RegExp(r'^\d{12}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid aadhar number';
    }
    return null;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';  // Import localization
//
// class AppFormValidation {
//   static String? validateMobile(BuildContext context, String? value) {
//     if (value == null || value.isEmpty) {
//       return AppLocalizations.of(context)!.pleaseEnterYourMobileNumber;
//     }
//     // Regular expression for Indian mobile numbers
//     RegExp regex = RegExp(r'^[6-9]\d{9}$');
//     if (!regex.hasMatch(value)) {
//       return AppLocalizations.of(context)!.pleaseEnterAValidMobileNumber;
//     }
//     return null;
//   }
//
//   static String? validateCaptcha({
//     required BuildContext context,
//     required String? captchaValue,
//     required String? enteredCaptcha,
//   }) {
//     if (kDebugMode) {
//       print(captchaValue);
//     }
//     if (enteredCaptcha == null || enteredCaptcha.isEmpty) {
//       return AppLocalizations.of(context)!.pleaseEnterCaptcha;
//     }
//
//     if (captchaValue != enteredCaptcha) {
//       return AppLocalizations.of(context)!.pleaseEnterValidCaptcha;
//     }
//
//     return null;
//   }
//
//   static String? validateName(BuildContext context, String? value) {
//     if (value == null || value.isEmpty) {
//       return AppLocalizations.of(context)!.pleaseEnterText;
//     }
//
//     if (value.length < 4) {
//       return AppLocalizations.of(context)!.textMustContainAtLeast4Characters;
//     }
//     return null;
//   }
//
//   // Other validation methods similarly updated to use AppLocalizations
//   // ...
//
//   static String? validateState(BuildContext context, String? value) {
//     if (value == null || value.isEmpty) {
//       return AppLocalizations.of(context)!.pleaseSelectState;
//     }
//     return null;
//   }
//
// // Similarly, update all other methods to use AppLocalizations for localized strings
// }
