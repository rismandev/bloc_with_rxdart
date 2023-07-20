import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // Membuat subject username & password untuk mengelola aliran data pada input
  final _userNameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Membuat getter username & password sebagai tipe data Stream
  Stream<String> get userNameStream => _userNameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  // Membuat getter validasi input dengan tipe data stream
  // Validasi dilakukan dengan memanggil method combineLatest2 yang dimiliki rxdart
  Stream<bool> get validateForm =>
      Rx.combineLatest2(userNameStream, passwordStream, (a, b) => true);

  /// Fungsi updateUserName
  /// Melakukan pengecekan dan perubahan aliran data untuk subject username
  /// Proses perubahan aliran data dilakukan dengan method sink.add atau sink.addError
  void updateUserName(String userName) {
    if (userName.length < 4) {
      _userNameController.sink.addError(
        "Please enter at least 4 characters of your name here",
      );
    } else {
      _userNameController.sink.add(userName);
    }
  }

  /// Fungsi updatePassword
  /// Melakukan pengecekan dan perubahan aliran data untuk subject password
  /// Proses perubahan aliran data dilakukan dengan method sink.add atau sink.addError
  void updatePassword(String password) {
    if (password.length < 4) {
      _passwordController.sink.addError(
        "Please enter at least 4 character of the password here",
      );
    } else {
      _passwordController.sink.add(password);
    }
  }

  /// Fungsi clearStreams
  /// Mereset data dengan memanggil fungsi masing-masing subject untuk perubahan aliran data.
  void clearStreams() {
    updateUserName('');
    updatePassword('');
  }
}
