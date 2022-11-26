
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class EmailVerificationRepositories {
  Future<Either<Failure, bool>> postEmailVerification(String token);
  Future<Either<Failure, bool>> postRequestNewToken(String email);
}