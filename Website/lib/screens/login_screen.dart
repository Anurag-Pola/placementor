import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:placementor_tnp/screens/tabs_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference admins = FirebaseFirestore.instance.collection('Admins');
  // .withConverter<Admins>(
  //     fromFirestore: (snapshots, _) => Admins.fromJson(snapshots.data()!),
  //     toFirestore: (admins, _) => admins.toJson());

  Future<bool> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await admins.get();

    // Get data from docs and convert map to List
    final allData =
        querySnapshot.docs.map((doc) => doc.data().toString()).toList();
    // print(allData);
    // print(FirebaseAuth.instance.currentUser!.email);
    // print(allData
    //     .contains('{mailid: ${FirebaseAuth.instance.currentUser!.email}}'));
    return allData
        .contains('{mailid: ${FirebaseAuth.instance.currentUser!.email}}');
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
                child: OrientationBuilder(
                  builder: (context, orientation) =>
                      orientation == Orientation.portrait
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/Images/login_pic.png',
                                    height: h * 0.5,
                                    width: w * 0.5,
                                  ),
                                  const LoginWidget(),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: w * 0.45,
                                  child: Image.asset(
                                    'assets/Images/login_pic.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 40),
                                const LoginWidget(),
                              ],
                            ),
                ),
              ),
            );
          }
          return FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.data == true) {
                    return const TabsScreen();
                  } else {
                    return const Scaffold(
                        body: Center(child: Text('You are not an admin')));
                  }
                  //.docs.map((doc)=>doc.data()['email']).contains(FirebaseAuth.instance.currentUser?.email)){
                  // return const Scaffold(
                  //   body: Center(
                  //     child: Text('You are not an admin'),
                  //   ),
                  // );
                }
              });
        });
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
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
    final h = MediaQuery.of(context).size.height / 2;
    final w = MediaQuery.of(context).size.width / 2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        const SizedBox(height: 5),
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
        const SizedBox(
          height: 5,
        ),
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
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(h * 0.035),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.05,
                    ),
                    // isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                      gapPadding: 15,
                      borderSide:
                          const BorderSide(color: Colors.black, width: 15.0),
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
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(h * 0.035),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.05,
                    ),
                    // isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                      gapPadding: 15,
                      borderSide:
                          const BorderSide(color: Colors.black, width: 15.0),
                      borderRadius: BorderRadius.circular(h * 0.035),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.04,
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
            height: h * 0.15,
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
    );
  }
}

class Admins {
  final String email;

  Admins({required this.email});

  Admins.fromJson(Map<String, Object?> json)
      : this(email: json['email'] as String);

  Map<String, Object?> toJson() {
    return {'email': email};
  }
}
