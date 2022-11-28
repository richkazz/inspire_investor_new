import 'package:get_it/get_it.dart';
import 'package:inspire_investors/features/dashbord/presentation/bloc/dashboard_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia

  //! Bloc
  sl.registerFactory(
    () => DashboardBloc(),
  );
}
