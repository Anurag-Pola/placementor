import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../screens/tabs_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();



  RegExp emailexp = RegExp(r'_[a-z][0-9][0-9]@vnrvjiet.in');

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occured'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('OKAY'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        // _isLoading = true;
      });
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }
      showErrorDialog(message);
    } catch (error) {
      var errorMessage = 'Could not authenticate you. Please try again later.';
      showErrorDialog(errorMessage);
      // setState(() {
      //   // _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffe5b2ca), Color(0xffcd83de)],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/login_pic.png',
                        height: 300,
                        width: 450,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Welcome Back!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please, Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: w * 0.8,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (!emailexp.hasMatch(value!)) {
                                    return 'Email is Invalid';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.02,
                                  ),
                                  // isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  border: OutlineInputBorder(
                                    gapPadding: 15,
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 15.0),
                                    borderRadius:
                                        BorderRadius.circular(h * 0.035),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),
                            SizedBox(
                              width: w * 0.8,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'Password is too short';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.02,
                                  ),
                                  // isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  border: OutlineInputBorder(
                                    gapPadding: 15,
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 15.0),
                                    borderRadius:
                                        BorderRadius.circular(h * 0.035),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _submit();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          width: w * 0.67,
                          height: h * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff925ffc),
                                Color(0xff3b57ff),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.102,
                            vertical: h * 0.02,
                          ),
                          child: const Center(
                            child: Text(
                              "Log In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return TabsScreen();
        });
  }
}
