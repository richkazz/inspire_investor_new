
import 'package:dartz/dartz.dart';
import 'package:inspire_investors/core/error/failures.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/change_password.dart';
import '../../domain/repositories/change_password_repositories.dart';
import '../data_sources/change_password_remote_data_source.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepositories {
  final ChangePasswordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, ChangePassword>> postChangePassword(ChangePassword changePassword) async{
    networkInfo.isConnected;

    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postChangePassword(changePassword));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }
}