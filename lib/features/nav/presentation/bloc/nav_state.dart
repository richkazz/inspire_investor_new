part of 'nav_bloc.dart';

abstract class NavState extends Equatable {
  const NavState();
}

class NavInitial extends NavState {
  @override
  List<Object> get props => [];
}
