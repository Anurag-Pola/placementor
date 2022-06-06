import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class OffCampusFormScreen extends StatefulWidget {
  const OffCampusFormScreen({Key? key}) : super(key: key);

  @override
  State<OffCampusFormScreen> createState() => _OffCampusFormScreenState();
}

class _OffCampusFormScreenState extends State<OffCampusFormScreen> {
  final _formKey = GlobalKey<FormState>();
  double paddingToElements = 39;
  String? validateFunction(value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference offCampusOpportunities =
        FirebaseFirestore.instance.collection('offCampusOpportunities');
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
    final TextEditingController _companyNameController =
        TextEditingController();
    final TextEditingController _roleNameController = TextEditingController();
    final TextEditingController _packageController = TextEditingController();
    final TextEditingController _urlController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F9FC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                      left: paddingToElements, right: paddingToElements),
                  children: [
                    const Text(
                      "Let us know about an off campus opportunity, which is not available in the app",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.027,
                    ),
                    EachQuestion(
                      question: "Name of the Company",
                      textFormFieldValidator: validateFunction,
                      controller: _companyNameController,
                    ),
                    EachQuestion(
                      question: "Role",
                      textFormFieldValidator: validateFunction,
                      controller: _roleNameController,
                    ),
                    EachQuestion(
                      question: "Package (in LPA)",
                      textFormFieldValidator: validateFunction,
                      controller: _packageController,
                    ),
                    EachQuestion(
                      question: "URL through which we can apply",
                      textFormFieldValidator: validateFunction,
                      controller: _urlController,
                    ),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var timestamp =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      offCampusOpportunities.doc(timestamp).set({
                        'companyName': _companyNameController.text,
                        'roleName': _roleNameController.text,
                        'package': _packageController.text,
                        'url': _urlController.text,
                        'timestamp': timestamp,
                        'postedBy': _auth.currentUser?.email,
                      });
                      _companyNameController.clear();
                      _roleNameController.clear();
                      _packageController.clear();
                      _urlController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Succesfully sent!')),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    width: width * 0.67,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff925ffc), Color(0xff3b57ff)],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.102,
                      vertical: height * 0.02,
                    ),
                    child: const Center(
                      child: Text(
                        "Send Information to T&P",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                        ),
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

class EachQuestion extends StatelessWidget {
  final String question;
  final TextEditingController controller;
  final Function textFormFieldValidator;
  final bool necessary;
  const EachQuestion(
      {required this.question,
      required this.controller,
      required this.textFormFieldValidator,
      this.necessary = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.633,
      height: height * 0.14,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question + (necessary ? " *" : ""),
            style: const TextStyle(
              color: Color(0xff252b42),
              fontSize: 14,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: height * 0.014),
          TextFormField(
            controller: controller,
            validator: (value) {
              return textFormFieldValidator(value);
            },
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w100,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xffe5e5e5),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.only(
                left: min(height, width) * 0.046,
                right: min(height, width) * 0.046,
              ),
              fillColor: const Color(0xfff8f8f8),
            ),
          ),
        ],
      ),
    );
  }
}
