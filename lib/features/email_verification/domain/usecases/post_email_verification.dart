


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repository/email_verification_repo.dart';

class PostEmailVerification extends UseCase<bool, Params>{
  final EmailVerificationRepositories repository;
  PostEmailVerification(this.repository);
  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.postEmailVerification(params.token);
  }
}

class Params extends Equatable {
  final String token;

  const Params({required this.token});

  @override
  List<Object?> get props => [token];
}