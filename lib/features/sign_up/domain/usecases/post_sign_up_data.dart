
import 'package:equatable/equatable.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:inspire_investors/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';

class PostSignUpData extends UseCase<SignUp, Params>{
  final SignUpRepositories repository;
  PostSignUpData(this.repository);
  @override
  Future<Either<Failure, SignUp>> call(Params params) async {
    return await repository.postSignUpData(params.signUp);
  }
}

class Params extends Equatable {
  final SignUp signUp;

  const Params({required this.signUp});

  @override
  List<Object?> get props => [signUp];
}