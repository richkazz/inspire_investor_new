import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:inspire_investors/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:inspire_investors/features/login/data/repository/login_repository.dart';
import 'package:inspire_investors/features/login/domain/repositories/login_repositories.dart';
import 'package:inspire_investors/features/login/domain/usecases/post_login.dart';
import 'package:inspire_investors/features/login/presentation/bloc/login_bloc.dart';
import '../../core/platform/network_info.dart';
import '../../util/input_validation.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia
//! Bloc
  sl.registerFactory(
    () => LoginBloc(
      login: sl(),
    ),
  );

// Use cases
  sl.registerLazySingleton(() => PostLogin(sl()));

// Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //! External

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );
}
