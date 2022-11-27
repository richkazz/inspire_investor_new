
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ExpensesRepositories {
  Future<Either<Failure, bool>> postExpenses(Map<String, String> expenses);

}