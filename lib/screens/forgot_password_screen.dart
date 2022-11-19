import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ninety/api/user.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/main.dart';

import '../models/user.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _tokenController;
  bool _isLoading = false;
  bool _emailSend = false;
  bool _loadingChangePassword = false;
  late AppUser _appUser;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _tokenController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  _changePassword() async {
    var userService = UserService();
    setState(() {
      _loadingChangePassword = true;
    });
    var result = await userService.changePassword(
        _tokenController.text, _passwordController.text, _appUser.id);
    if (result) {
      final snackBar = SnackBar(
        content: const Text('Password changed succesfully!'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (!mounted) {
        return;
      }

      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(snackBar);
      }
    } else {
      setState(() {
        _loadingChangePassword = true;
      });
      final snackBar = SnackBar(
        content: const Text('Error in changing the password'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (!mounted) {
        return;
      }

      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(snackBar);
      }
    }
    setState(() {
      _loadingChangePassword = false;
    });
  }

  _resetPassword(context) async {
    var userService = UserService();
    var result = await userService.resetPassword(_emailController.text);
    if (result != null) {
      _appUser = result;
      setState(() {
        _emailSend = true;
      });
      final snackBar = SnackBar(
        content: const Text('Successfully sended the email'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (!mounted) {
        return;
      }

      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(snackBar);
      }
    } else {
      // error in sending the result
      final snackBar = SnackBar(
        content: const Text('Error in sending the email'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (!mounted) {
        return;
      }

      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(snackBar);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: PADDING_TOP,
            right: PADDING_RIGHT,
            left: PADDING_LEFT,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reset your Password",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Enter your email to reset the password",
                style: TextStyle(
                  color: Color(0xfffACB2B8),
                ),
              ),
              const SizedBox(
                height: 40,
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
                child: TextFormField(
                  readOnly: _emailSend,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color(0xfffCED4DA),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xfffCED4DA),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xfffCED4DA),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    var _error = EmailValidator(errorText: "Enter Valid email");
                    if (!_error.isValid(value)) {
                      return _error.errorText;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _emailSend
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() {
                                _isLoading = true;
                              });
                              _resetPassword(context);
                            }
                          },
                style: raisedButtonStylePurple,
                child: _isLoading
                    ? const SpinKitPulse(
                        color: Colors.white,
                      )
                    : const Text(
                        "Send Email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              !_emailSend
                  ? const SizedBox()
                  : Column(
                      children: [
                        Form(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _tokenController,

                                decoration: const InputDecoration(
                                  labelText: "OTP code",
                                  labelStyle: TextStyle(
                                    color: Color(0xfffCED4DA),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  var _requiredValidator = RequiredValidator(
                                      errorText: "Password is required!");
                                  var _minLengthValidator =
                                      LengthRangeValidator(
                                          min: 6,
                                          max: 6,
                                          errorText: 'OTP should be 6 digits');
                                  try {
                                    if (value != null) {
                                      int code = int.parse(value);
                                    }
                                  } catch (e) {
                                    return "OTP code must be integer";
                                  }

                                  if (!_requiredValidator.isValid(value)) {
                                    return _requiredValidator.errorText;
                                  } else if (!_minLengthValidator
                                      .isValid(value)) {
                                    return _minLengthValidator.errorText;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: Color(0xfffCED4DA),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  var _requiredValidator = RequiredValidator(
                                      errorText: "Password is required!");
                                  var _minLengthValidator = MinLengthValidator(
                                      8,
                                      errorText:
                                          'Password must be at least 8 digits long');
                                  var _patternValidator = PatternValidator(
                                      r'(?=.*?[#?!@$%^&*-])',
                                      errorText:
                                          'Passwords must have at least one special character');

                                  if (!_requiredValidator.isValid(value)) {
                                    return _requiredValidator.errorText;
                                  } else if (!_minLengthValidator
                                      .isValid(value)) {
                                    return _minLengthValidator.errorText;
                                  } else if (!_patternValidator
                                      .isValid(value)) {
                                    return _patternValidator.errorText;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(
                                    color: Color(0xfffCED4DA),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xfffCED4DA),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  var _requiredValidator = RequiredValidator(
                                      errorText: "Password is required!");
                                  var _minLengthValidator = MinLengthValidator(
                                      8,
                                      errorText:
                                          'Password must be at least 8 digits long');
                                  var _patternValidator = PatternValidator(
                                      r'(?=.*?[#?!@$%^&*-])',
                                      errorText:
                                          'Passwords must have at least one special character');

                                  if (!_requiredValidator.isValid(value)) {
                                    return _requiredValidator.errorText;
                                  } else if (!_minLengthValidator
                                      .isValid(value)) {
                                    return _minLengthValidator.errorText;
                                  } else if (!_patternValidator
                                      .isValid(value)) {
                                    return _patternValidator.errorText;
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "Passwords should match";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: _loadingChangePassword
                                    ? null
                                    : () {
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          _changePassword();
                                        }
                                      },
                                style: raisedButtonStylePurple,
                                child: _loadingChangePassword
                                    ? const SpinKitPulse(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Reset Password",
                                      ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
