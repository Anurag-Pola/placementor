import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

CollectionReference admins = FirebaseFirestore.instance.collection('Admins');
FirebaseAuth auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        child: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? Column(
                  children: [
                    Image.asset(
                      'assets/login_pic.png',
                      height: h * 0.5,
                      width: w * 0.5,
                    ),
                    const LoginWidget(),
                  ],
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
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  bool _obscurePassword = true;

  String _email = "";

  String _password = "";

  RegExp emailexp = RegExp(r'@vnrvjiet.in');

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
              _formKey.currentState!.reset();
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

      bool _isAdmin = await checkIfUserIsAdmin();

      if (!_isAdmin) {
        await auth.signOut();
        throw Exception('You are not an admin');
      }

      print(
          "Succesfully logged in ${user.user!.email} with uid : ${user.user!.uid}");

      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }
      showErrorDialog(message);
    } catch (error) {
      var errorMessage = error.toString().endsWith('You are not an admin')
          ? 'You are not an admin.'
          : 'Could not authenticate you.';
      showErrorDialog(errorMessage);
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
                  textInputAction: TextInputAction.next,
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
                  obscureText: _obscurePassword,
                  onFieldSubmitted: (_) {
                    _submit();
                  },
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
            child: Center(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
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
    );
  }
}

Future<bool> checkIfUserIsAdmin() async {
  DocumentSnapshot adminDocument =
      await admins.doc(auth.currentUser!.uid).get();

  return adminDocument.exists;
}
