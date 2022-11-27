
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:inspire_investors/features/expenses/domain/repo/expenses_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';

class PostExpenses extends UseCase<bool, ExpensesParams>{
  final ExpensesRepositories repository;
  PostExpenses(this.repository);
  @override
  Future<Either<Failure, bool>> call(ExpensesParams params) async {
    return await repository.postExpenses(params.expenses);
  }
}

class ExpensesParams extends Equatable {
  final Map<String, String> expenses;

  const ExpensesParams({required this.expenses});

  @override
  List<Object?> get props => [expenses];
}