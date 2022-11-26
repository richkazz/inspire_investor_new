
import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repository/email_verification_repo.dart';
import '../data_source/email_verification_data_source.dart';

class EmailVerificationRepositoryImpl implements EmailVerificationRepositories {
  final EmailVerificationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EmailVerificationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> postEmailVerification(String token) async{
    networkInfo.isConnected;

    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postEmailVerification(token));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }
  @override
  Future<Either<Failure, bool>> postRequestNewToken(String email) async{
    networkInfo.isConnected;

    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postRequestNewToken(email));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }


}