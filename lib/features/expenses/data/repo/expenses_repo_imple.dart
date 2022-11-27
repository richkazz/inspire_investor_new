
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repo/expenses_repo.dart';
import '../data_sourse/expenses_remote_data_source.dart';

class ExpensesRepositoryImpl implements ExpensesRepositories {
  final ExpensesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ExpensesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> postExpenses(Map<String, String> expenses) async{
    networkInfo.isConnected;

    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.postExpenses(expenses));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO not connected error
      return Left(NetWorkFailure());
    }
  }


}