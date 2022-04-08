import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> stringValidPhone(String str) {
    String pattern = r'(^(?:[79])?[0-9]{9}$)';
    RegExp regExp = RegExp(pattern);
    if (str.isEmpty) {
      return Left(InvalidInputEmptyPhoneFailure());
    } else if (!(str.startsWith('9') || str.startsWith('7')) &&
        !regExp.hasMatch(str)) {
      return Left(InvalidInputPhoneFailure());
    } else if (str.length < 9) {
      return Left(InvalidInputIncompletePhoneFailure());
    } else if (regExp.hasMatch(str)) {
      return Right(str);
    }
    return Left(InvalidInputEmptyPhoneFailure());
  }
}

class InvalidInputFailure extends Failure {}

class InvalidInputEmptyPhoneFailure extends Failure {}

class InvalidInputIncompletePhoneFailure extends Failure {}

class InvalidInputPhoneFailure extends Failure {}
