import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musiq/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final FirebaseAuth auth = FirebaseAuth.instance;
      try {
        await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        userIsLoggedIn = event.email;
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for that user.';
            break;
          case 'user-disabled':
            errorMessage = 'User account has been disabled.';
            break;
          default:
            errorMessage = 'An undefined error occurred.';
        }
        emit(LoginError(errorMessage: errorMessage));
      } catch (e) {
        emit(LoginError(errorMessage: e.toString()));
      }
    });
  }
}
