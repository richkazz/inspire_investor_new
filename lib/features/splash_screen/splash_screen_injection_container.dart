
import 'package:get_it/get_it.dart';
import 'package:inspire_investors/features/splash_screen/presentation/bloc/splash_screen_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //! Bloc
  sl.registerFactory(
        () =>
        SplashScreenBloc(
        ),
  );
}
