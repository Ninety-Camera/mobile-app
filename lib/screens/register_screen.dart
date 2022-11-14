import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ninety/api/user.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  registerUser(context) async {
    var userService = UserService();
    var appUser = await userService.register(
      email: _emailController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      password: _passwordController.text,
    );

    if (appUser == null) {
      final snackBar = SnackBar(
        content: const Text('Error in creating the user'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("Created user: " + appUser.email);
    }
    setState(() {
      _isLoading = false;
    });
  }

  getFirebaseToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM token is: " + fcmToken.toString());
  }

  @override
  Widget build(BuildContext context) {
    getFirebaseToken();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: PADDING_TOP,
          left: PADDING_LEFT,
          right: PADDING_RIGHT,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Register \nwith Us",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.person_add,
                  size: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
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
                      if (value != null && value.isEmpty) {
                        return "First name is required!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
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
                      if (value != null && value.isEmpty) {
                        return "Last name is required!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
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
                      var _error =
                          EmailValidator(errorText: "Enter Valid email");
                      if (!_error.isValid(value)) {
                        return _error.errorText;
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
                    decoration: const InputDecoration(
                      labelText: "Password",
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
                      var _requiredValidator =
                          RequiredValidator(errorText: "Password is required!");
                      var _minLengthValidator = MinLengthValidator(8,
                          errorText: 'Password must be at least 8 digits long');
                      var _patternValidator = PatternValidator(
                          r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                              'Passwords must have at least one special character');

                      if (!_requiredValidator.isValid(value)) {
                        return _requiredValidator.errorText;
                      } else if (!_minLengthValidator.isValid(value)) {
                        return _minLengthValidator.errorText;
                      } else if (!_patternValidator.isValid(value)) {
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
                      var _requiredValidator =
                          RequiredValidator(errorText: "Password is required!");
                      var _minLengthValidator = MinLengthValidator(8,
                          errorText: 'Password must be at least 8 digits long');
                      var _patternValidator = PatternValidator(
                          r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                              'Passwords must have at least one special character');

                      if (!_requiredValidator.isValid(value)) {
                        return _requiredValidator.errorText;
                      } else if (!_minLengthValidator.isValid(value)) {
                        return _minLengthValidator.errorText;
                      } else if (!_patternValidator.isValid(value)) {
                        return _patternValidator.errorText;
                      } else if (value != _passwordController.text) {
                        return "Passwords should match";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() {
                                _isLoading = true;
                              });
                              registerUser(context);
                            }
                          },
                    style: raisedButtonStylePurple,
                    child: _isLoading
                        ? const SpinKitPulse(
                            color: Colors.white,
                          )
                        : const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(_createLoginRoute());
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color(0xfffF50057),
                        fontWeight: FontWeight.bold,
                      ),
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

Route _createLoginRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
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
