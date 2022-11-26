
import 'package:dartz/dartz.dart';
import 'package:inspire_investors/features/login/data/data_sources/login_remote_data_source.dart';

import '../../../../core/error/error.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/login.dart';
import '../../domain/repositories/login_repositories.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Login>> postLogin(Login login) async{
    networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postLogin(login));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }
}