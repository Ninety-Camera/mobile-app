import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ninety/api/user.dart';
import 'package:ninety/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _invalidEmail = false;
  bool _invalidPassword = false;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  signInUser() async {
    try {
      var result =
          await signIn(_emailController.text, _passwordController.text);
      var decodedResponse = jsonDecode(utf8.decode(result.bodyBytes)) as Map;
      if (decodedResponse['status'] == 200) {
        // Sign in success
      } else {
        // Invalid username or password
      }
    } catch (e) {
      // Network error occured
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: PADDING_TOP,
          left: PADDING_LEFT,
          right: PADDING_RIGHT,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Sign in to continue",
              style: TextStyle(
                color: Color(0xfffACB2B8),
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 200,
              child: SvgPicture.asset(
                "assets/images/login-screen.svg",
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: _invalidEmail ? Colors.red : Color(0xfffCED4DA),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xfffCED4DA),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xfffCED4DA),
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      var _error =
                          EmailValidator(errorText: "Enter Valid email");
                      if (!_error.isValid(value)) {
                        setState(() {
                          _invalidEmail = true;
                        });
                        return _error.errorText;
                      } else {
                        setState(() {
                          _invalidEmail = false;
                        });
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color:
                            _invalidPassword ? Colors.red : Color(0xfffCED4DA),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xfffCED4DA),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xfffCED4DA),
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      var _requiredValidator =
                          RequiredValidator(errorText: "Password is required!");
                      var _minLengthValidator = MinLengthValidator(8,
                          errorText: 'Password must be at least 8 digits long');
                      var _patternValidator = PatternValidator(
                          r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                              'Passwords must have at least one special character');
                      setState(() {
                        _invalidPassword = true;
                      });
                      if (!_requiredValidator.isValid(value)) {
                        return _requiredValidator.errorText;
                      } else if (!_minLengthValidator.isValid(value)) {
                        return _minLengthValidator.errorText;
                      } else if (!_patternValidator.isValid(value)) {
                        return _patternValidator.errorText;
                      } else {
                        setState(() {
                          _invalidPassword = false;
                        });
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xfffF50057)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        signInUser();
                      }
                    },
                    style: raisedButtonStylePurple,
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Color(0xfffF50057)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
