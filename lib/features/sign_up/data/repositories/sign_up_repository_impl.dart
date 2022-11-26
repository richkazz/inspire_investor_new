
import 'package:dartz/dartz.dart';
import 'package:inspire_investors/core/error/failures.dart';
import 'package:inspire_investors/features/sign_up/domain/entities/sign_up.dart';
import 'package:inspire_investors/features/sign_up/domain/repositories/sign_up_repositories.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/platform/network_info.dart';
import '../data_sources/sign_up_remote_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepositories {
  final SignUpRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SignUpRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, SignUp>> postSignUpData(SignUp signUp) async{
    networkInfo.isConnected;

    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postSignUpData(signUp));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }
}