import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaiseTicketPage extends StatefulWidget {
  const RaiseTicketPage({Key? key}) : super(key: key);

  @override
  _RaiseTicketPageState createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends State<RaiseTicketPage> {
  final _formKey = GlobalKey<FormState>();
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 248,
                      height: 100,
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
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              return validateFunction(value);
                            },
                            decoration: textFormFieldDecoration,
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
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        return validateFunction(value);
                      },
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: null,
                      maxLines: null,
                      decoration: textFormFieldDecoration,
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
                    width: 265,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff925ffc), Color(0xff3b57ff)],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Raise a Ticket",
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
