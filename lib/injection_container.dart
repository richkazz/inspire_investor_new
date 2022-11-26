import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:inspire_investors/util/input_validation.dart';
import 'package:http/http.dart' as http;
import 'package:inspire_investors/features/sign_up/signup_injection_container.dart' as signup;
import 'package:inspire_investors/features/login/login_injection_container.dart' as login;
import 'package:inspire_investors/features/splash_screen/splash_screen_injection_container.dart' as splash;
import 'package:inspire_investors/features/email_verification/email_verification_injection_container.dart' as email_verification;
import 'package:inspire_investors/features/change_password/change_password_injection_container.dart' as change_password;
import 'core/platform/network_info.dart';

final sl = GetIt.instance;

void init() {
  //features
  //! Features - Number Trivia
  splash.init();
  signup.init();
  login.init();
  email_verification.init();
  change_password.init();
  //! Core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}