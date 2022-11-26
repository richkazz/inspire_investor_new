import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repository/email_verification_repo.dart';

class PostRequestNewToken extends UseCase<bool, ParamsNewToken>{
  final EmailVerificationRepositories repository;
  PostRequestNewToken(this.repository);
  @override
  Future<Either<Failure, bool>> call(ParamsNewToken params) async {
    return await repository.postRequestNewToken(params.email);
  }
}

class ParamsNewToken extends Equatable {
  final String email;

  const ParamsNewToken({required this.email});

  @override
  List<Object?> get props => [email];
}