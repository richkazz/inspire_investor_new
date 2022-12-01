import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_change_password_event.dart';
part 'profile_change_password_state.dart';

class ProfileChangePasswordBloc extends Bloc<ProfileChangePasswordEvent, ProfileChangePasswordState> {
  ProfileChangePasswordBloc() : super(ProfileChangePasswordInitial()) {
    on<ProfileChangePasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
