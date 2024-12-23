import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/entities/user.dart';

part 'currentuser_state.dart';

class CurrentuserCubit extends Cubit<CurrentuserState> {
  CurrentuserCubit() : super(CurrentuserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(CurrentuserInitial());
    } else {
      emit(CurrentUserLoggedIn(user));
    }
  }

  void signOut() {
    emit(CurrenUserEmpty());
  }
}
