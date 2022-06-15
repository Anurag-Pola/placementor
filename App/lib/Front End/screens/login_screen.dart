import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

CollectionReference students =
    FirebaseFirestore.instance.collection('Students');
FirebaseAuth auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _email = "";

  String _password = "";

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
              setState(() {
                _isLoading = false;
              });
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      bool _isStudent = await checkIfUserIsStudent();

      if (!_isStudent) {
        await auth.signOut();
        throw Exception('You are not a student');
      }

      print(
          "Succesfully logged in ${user.user!.email} with uid : ${user.user!.uid}");

      setState(() {
        _isLoading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }
      showErrorDialog(message);
    } catch (error) {
      var errorMessage = error.toString().endsWith('You are not a student')
          ? 'You are not a student.'
          : 'Could not authenticate you.';
      showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
                          _email = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: h * 0.02,
                          ),
                          // isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          border: OutlineInputBorder(
                            gapPadding: 15,
                            borderSide: const BorderSide(
                                color: Colors.black, width: 15.0),
                            borderRadius: BorderRadius.circular(h * 0.035),
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
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontSize: h * 0.02,
                            ),
                            // isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                              gapPadding: 15,
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 15.0),
                              borderRadius: BorderRadius.circular(h * 0.035),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            )),
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
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
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
}

Future<bool> checkIfUserIsStudent() async {
  DocumentSnapshot studentDocument =
      await students.doc(auth.currentUser!.uid).get();

  return studentDocument.exists;
}
