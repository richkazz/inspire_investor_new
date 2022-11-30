import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expenditure_event.dart';
part 'expenditure_state.dart';

class ExpenditureBloc extends Bloc<ExpenditureEvent, ExpenditureState> {
  ExpenditureBloc() : super(ExpenditureInitial()) {
    on<ExpenditureEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
