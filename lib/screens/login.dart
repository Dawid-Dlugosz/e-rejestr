import 'package:e_rejestr/view_models/login_view_model.dart';
import 'package:e_rejestr/widgets/loading_widget.dart';

import 'package:flutter/material.dart';
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
    // _loginController.text = 'cpAdmin';
    // _passwordController.text = 'cpDomino';
    return loginViewModel.loaded
        ? Scaffold(
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
                        onFieldSubmitted: (value) async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await loginViewModel.login(
                                login: _loginController.text,
                                password: _passwordController.text);
                          }
                        },
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await loginViewModel.login(
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
          )
        : const LoadingWidget();
  }
}
