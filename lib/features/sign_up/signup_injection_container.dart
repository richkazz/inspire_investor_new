import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:inspire_investors/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:inspire_investors/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:inspire_investors/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:inspire_investors/features/sign_up/domain/usecases/post_sign_up_data.dart';
import 'package:inspire_investors/features/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:http/http.dart' as http;
import '../../core/platform/network_info.dart';
import '../../util/input_validation.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //! Bloc
  sl.registerFactory(
        () => SignUpBloc(
      signUpData: sl(),
      inputValidator: sl(),
    ),
  );
// Use cases
  sl.registerLazySingleton(() => PostSignUpData(sl()));

// Repository
  sl.registerLazySingleton<SignUpRepositories>(
        () => SignUpRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //! External

  // Data sources
  sl.registerLazySingleton<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImpl(client: sl()),
  );
  
}