import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/entities/user.dart';

import 'package:gameync/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:gameync/features/auth/domain/usecases/login_usecase.dart';

import 'package:gameync/features/auth/domain/usecases/user_signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final CurrentuserCubit _currentuserCubit;
  final UserLogOut _userLogOut;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required CurrentuserCubit currentuserCubit,
    required UserLogOut userLogOut,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _currentuserCubit = currentuserCubit,
        _userLogOut = userLogOut,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthUserLoggedOut>(_onAuthUserLoggedOut);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
        uname: event.uname,
        name: event.name,
        phoneNumber: event.phoneNumber,
        email: event.email,
        password: event.password));

    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _currentuserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _onAuthUserLoggedOut(
      AuthUserLoggedOut event, Emitter<AuthState> emit) async {
    final res = await _userLogOut(NoParams());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => emit(AuthLogOutSuccess()));
  }
}
