import 'package:get_it/get_it.dart';
import 'package:inspire_investors/features/change_password/presentation/bloc/change_password_bloc.dart';

import 'data/data_sources/change_password_remote_data_source.dart';
import 'data/repositories/change_password_repository_impl.dart';
import 'domain/repositories/change_password_repositories.dart';
import 'domain/usecases/post_change_password_data.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //! Bloc
  sl.registerFactory(
        () => ChangePasswordBloc(
      change: sl(),
    ),
  );
// Use cases
  sl.registerLazySingleton(() => PostChangePassword(sl()));

// Repository
  sl.registerLazySingleton<ChangePasswordRepositories>(
        () => ChangePasswordRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //! External

  // Data sources
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSourceImpl(client: sl()),
  );
  
}