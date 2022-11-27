part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();
}

class IncomeInitial extends IncomeState {
  @override
  List<Object> get props => [];
}
