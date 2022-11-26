
import 'package:get_it/get_it.dart';
import 'package:inspire_investors/features/email_verification/data/data_source/email_verification_data_source.dart';
import 'package:inspire_investors/features/email_verification/domain/repository/email_verification_repo.dart';
import 'package:inspire_investors/features/email_verification/presentation/bloc/email_verification_bloc.dart';

import 'data/repository/email_verification_repository_impl.dart';
import 'domain/usecases/post_email_verification.dart';
import 'domain/usecases/post_request_new_token.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //! Bloc
  sl.registerFactory(
        () => EmailVerificationBloc(
      verification: sl(), requestToken: sl(),
    ),
  );
// Use cases
  sl.registerLazySingleton(() => PostEmailVerification(sl()));
  sl.registerLazySingleton(() => PostRequestNewToken(sl()));

// Repository
  sl.registerLazySingleton<EmailVerificationRepositories>(
        () => EmailVerificationRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //! External

  // Data sources
  sl.registerLazySingleton<EmailVerificationRemoteDataSource>(
        () => EmailVerificationRemoteDataSourceImpl(client: sl()),
  );

}