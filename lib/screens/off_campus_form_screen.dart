import 'dart:math';

import 'package:flutter/material.dart';

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
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
    print(safeAreaHeight);
    print(height);
    print(width);
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
                      "Name of the Company",
                      textFormFieldValidator: validateFunction,
                    ),
                    EachQuestion(
                      "Role",
                      textFormFieldValidator: validateFunction,
                    ),
                    EachQuestion(
                      "Package (in LPA)",
                      textFormFieldValidator: validateFunction,
                    ),
                    EachQuestion(
                      "URL through which we can apply",
                      textFormFieldValidator: validateFunction,
                    ),
                    EachQuestion(
                      "Last date of application",
                      textFormFieldValidator: validateFunction,
                    ),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Send Information to T&P",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
  final Function textFormFieldValidator;
  final bool necessary;
  const EachQuestion(this.question,
      {required this.textFormFieldValidator, this.necessary = true, Key? key})
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
