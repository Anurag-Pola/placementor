import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({Key? key}) : super(key: key);

  @override
  _RaiseTicketScreenState createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference tickets =
      FirebaseFirestore.instance.collection('Tickets');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double paddingToElements = 39;
  String? validateFunction(value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    return null;
  }

  InputDecoration textFormFieldDecoration = InputDecoration(
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
    contentPadding: const EdgeInsets.only(
      left: 18,
      right: 18,
    ),
    fillColor: const Color(0xfff8f8f8),
  );

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
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
                  padding: EdgeInsets.only(
                      left: paddingToElements, right: paddingToElements),
                  children: [
                    const Text(
                      "Want to tell us about a missing or incorrect information ? \n(or)\nWant to  suggest us a new feature ?\n(or)\nWant to give feedback or complaint ?\n\nThis is the right place",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * 0.027,
                    ),
                    SizedBox(
                      width: width * 0.633,
                      height: height * 0.14,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Title of the Concern *",
                            style: TextStyle(
                              color: Color(0xff252b42),
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height * 0.014),
                          TextFormField(
                            validator: (value) {
                              return validateFunction(value);
                            },
                            decoration: textFormFieldDecoration,
                            autocorrect: true,
                            controller: _titleController,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Description *",
                      style: TextStyle(
                        color: Color(0xff252b42),
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.014),
                    TextFormField(
                      validator: (value) {
                        return validateFunction(value);
                      },
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: null,
                      maxLines: null,
                      decoration: textFormFieldDecoration,
                      controller: _descriptionController,
                    ),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      tickets.add({
                        'title': _titleController.text,
                        'description': _descriptionController.text,
                      });
                      _titleController.clear();
                      _descriptionController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Posted Successfully')),
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
                        colors: [
                          Color(0xff925ffc),
                          Color(0xff3b57ff),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.102,
                      vertical: height * 0.02,
                    ),
                    child: const Center(
                      child: Text(
                        "Raise a Ticket",
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
