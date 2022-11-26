import 'package:dartz/dartz.dart';
import 'package:inspire_investors/core/error/failures.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';

abstract class SignUpRepositories {
  Future<Either<Failure, SignUp>> postSignUpData(SignUp signUp);
}
