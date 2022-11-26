import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:inspire_investors/features/login/domain/repositories/login_repositories.dart';

import '../../../../core/error/error.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/login.dart';

class PostLogin extends UseCase<Login, Params>{
  final LoginRepository repository;
  PostLogin(this.repository);
  @override
  Future<Either<Failure, Login>> call(Params params) async {
    return await repository.postLogin(params.login);
  }
}

class Params extends Equatable {
  final Login login;

  const Params({required this.login});

  @override
  List<Object?> get props => [login];
}