
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/change_password.dart';
import '../repositories/change_password_repositories.dart';

class PostChangePassword extends UseCase<ChangePassword, Params>{
  final ChangePasswordRepositories repository;
  PostChangePassword(this.repository);
  @override
  Future<Either<Failure, ChangePassword>> call(Params params) async {
    return await repository.postChangePassword(params.changePassword);
  }
}

class Params extends Equatable {
  final ChangePassword changePassword;

  const Params({required this.changePassword});

  @override
  List<Object?> get props => [changePassword];
}