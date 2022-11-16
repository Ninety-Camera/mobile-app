import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ninety/api/user.dart';
import 'package:ninety/constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninety/models/user.dart';
import 'package:ninety/providers/system.dart';
import 'package:ninety/screens/dashboard_screen.dart';
import 'package:ninety/screens/forgot_password_screen.dart';
import 'package:ninety/screens/qr_scanning_screen.dart';
import 'package:ninety/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _invalidEmail = false;
  bool _invalidPassword = false;
  bool _isLoading = false;

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  setSystemStatus(BuildContext context, AppUser appUser) {
    if (appUser.cctvSystem!.status == 'RUNNING') {
      context.read<System>().startSystem();
    } else {
      context.read<System>().stopSystem();
    }
  }

  signInUser(BuildContext context) async {
    var userService = UserService();
    var appUser = await userService.signIn(
        _emailController.text, _passwordController.text);
    if (appUser == null) {
      // Error in logging in
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: const Text('Invalid username or password'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (appUser.cctvSystem == null) {
        Navigator.of(context).push(_createScanQRCodeRoute(appUser));
      } else {
        setSystemStatus(context, appUser);
        print("In here!");
        var _deviceResult = await userService.checkUserMobileDevice(appUser.id);
        print("Device result is: " + _deviceResult.toString());
        if (_deviceResult) {
          Navigator.of(context).pushAndRemoveUntil(
              _createDashboardRoute(appUser), (route) => false);
        } else if (_deviceResult == false) {
          Navigator.of(context).push(_createScanQRCodeRoute(appUser));
        } else {
          print("Error occured");
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                          color:
                              _invalidEmail ? Colors.red : Color(0xfffCED4DA),
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
                          color: _invalidPassword
                              ? Colors.red
                              : Color(0xfffCED4DA),
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
                        var _requiredValidator = RequiredValidator(
                            errorText: "Password is required!");
                        var _minLengthValidator = MinLengthValidator(8,
                            errorText:
                                'Password must be at least 8 digits long');
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
                      onPressed: () {
                        Navigator.of(context)
                            .push(_createForgotPasswordRoute());
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xfffF50057)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {
                                  _isLoading = true;
                                });
                                signInUser(context);
                              }
                            },
                      style: raisedButtonStylePurple,
                      child: _isLoading
                          ? const SpinKitPulse(
                              color: Colors.white,
                            )
                          : const Text(
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
                      onPressed: () {
                        Navigator.of(context).push(_createRegisterRoute());
                      },
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
      ),
    );
  }
}

Route _createRegisterRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const RegisterScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createForgotPasswordRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ForgotPasswordScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createScanQRCodeRoute(appUser) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        QRCodeScanningScreen(
      appUser: appUser,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createDashboardRoute(appUser) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(
      appUser: appUser,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
