import 'package:e_rejestr/utils/firestore.dart';
import 'package:e_rejestr/view_models/login_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  late LoginViewModel loginViewModel;
  @override
  void initState() {
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _loginController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj login';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj hasło';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText == true
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    label: const Text('Hasło'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginViewModel.login(
                          login: _loginController.text,
                          password: _passwordController.text);
                    }
                  },
                  child: Text('Zaloguj'.toUpperCase()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
