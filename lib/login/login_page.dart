import 'package:bloc_with_rxdart_app/widgets/custom_plain_button.dart';
import 'package:bloc_with_rxdart_app/widgets/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit? _loginCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loginCubit?.clearStreams();
    });
    super.initState();
  }

  _onLogin() {
    if (kDebugMode) {
      print('Login Button Pressed');
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginCubit = BlocProvider.of<LoginCubit>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Validation with BloC')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Expanded(child: _buildMiddleView()),
              _buildBottomButtonView()
            ],
          ),
        ),
      ),
    );
  }

  _buildMiddleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Login In',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: _loginCubit?.userNameStream,
          builder: (context, snapshot) {
            return CustomTextField(
              onChange: (text) {
                _loginCubit?.updateUserName(text);
              },
              labelText: 'Username',
              textInputType: TextInputType.emailAddress,
            );
          },
        ),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: _loginCubit?.passwordStream,
          builder: (context, snapshot) {
            return CustomTextField(
              onChange: (text) {
                _loginCubit?.updatePassword(text);
              },
              labelText: 'Password',
              textInputType: TextInputType.text,
              isObscureText: true,
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  _buildBottomButtonView() {
    return StreamBuilder(
      stream: _loginCubit?.validateForm,
      builder: (context, snapshot) {
        return CustomPlainButton(
          isEnabled: snapshot.hasData,
          btnColor: snapshot.hasData ? Colors.red : Colors.grey,
          height: 67,
          onTap: snapshot.hasData ? _onLogin : null,
          label: 'Log in',
          lblColor: Colors.white,
        );
      },
    );
  }
}
