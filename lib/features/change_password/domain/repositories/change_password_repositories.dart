import 'package:dartz/dartz.dart';
import 'package:inspire_investors/core/error/failures.dart';

import '../entities/change_password.dart';

abstract class ChangePasswordRepositories {
  Future<Either<Failure, ChangePassword>> postChangePassword(ChangePassword changePassword);
}
