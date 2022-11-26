
import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import '../entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> postLogin(Login login);
}
