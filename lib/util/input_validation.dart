import 'package:dartz/dartz.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import '../core/error/failures.dart';

class InputValidator {
  Either<Failure, String> isCorrectEmailFormat(String str) {
    var ema = str.toLowerCase().trim();
    try {
      if ((Fzregex.hasMatch(ema, FzPattern.email) == true)) {
        return Right(str);
      } else {
        return Left(InvalidInputFailure());
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
