import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

import '../widgets/company_class.dart';

final firebaseInstance =
    FirebaseFirestore.instance.collection('Companies').withConverter<Company>(
          fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
          toFirestore: (company, _) => company.toJson(),
        );

class OffCampusCompanyForm extends StatefulWidget {
  final String id;
  final String companyName;
  final String roleName;
  final String jobDescription;
  final String linkToApply;

  const OffCampusCompanyForm(
      {Key? key,
      this.id = "",
      this.companyName = "",
      this.roleName = "",
      this.jobDescription = "",
      this.linkToApply = ""})
      : super(key: key);
  @override
  State<OffCampusCompanyForm> createState() => _OffCampusCompanyFormState();
}

class _OffCampusCompanyFormState extends State<OffCampusCompanyForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _companyNameController =
      TextEditingController(text: widget.companyName);

  late final TextEditingController _roleNameController =
      TextEditingController(text: widget.roleName);

  late final TextEditingController _jobDescriptionController =
      TextEditingController(text: widget.jobDescription);

  late final TextEditingController _linkToApplyController =
      TextEditingController(text: widget.linkToApply);
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

    return Scaffold(
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
                    "Add an Off-Campus Company",
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
                  Field(
                    text: "Company Name",
                    validateFunction: validateFunction,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    controller: _companyNameController,
                  ),
                  Field(
                    text: "Role Name",
                    validateFunction: validateFunction,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _roleNameController,
                  ),
                  Field(
                    text: "Description",
                    validateFunction: validateFunction,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    controller: _jobDescriptionController,
                  ),
                  Field(
                    text: "Link for Applying",
                    validateFunction: validateFunction,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _linkToApplyController,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                // if (_formKey.currentState!.validate()) {
                final company = Company.fromJson({
                  "companyName": _companyNameController.text,
                  "roleName": _roleNameController.text,
                  "jobDescription": _jobDescriptionController.text,
                  "linkToApply": _linkToApplyController.text,
                  "id": widget.id == ""
                      ? DateTime.now().millisecondsSinceEpoch.toString()
                      : widget.id,
                  "offerType": "Off Campus",
                });
                firebaseInstance.doc(company.id).set(company);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🤘Done and Dusted!!✌️')),
                );
                await Future.delayed(const Duration(seconds: 2));
                Navigator.pop(context);
                // }
              },
              child: Container(
                width: 215,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff925ffc),
                      Color(0xff3b57ff),
                    ],
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.text,
    this.validateFunction,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    this.expand = false,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final Function? validateFunction;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool expand;

  final TextStyle textStyle = const TextStyle(
    color: Color(0xff252b42),
    fontSize: 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );

  final InputDecoration textFormFieldDecoration = const InputDecoration(
    errorStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w100,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        color: Color(0xffe5e5e5),
        width: 1,
      ),
    ),
    contentPadding: EdgeInsets.all(18),
    fillColor: Color(0xfff8f8f8),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.633,
      height: textInputType == TextInputType.multiline ? 300 : 90,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              return validateFunction == null ? validateFunction!(value) : true;
            },
            decoration: textFormFieldDecoration,
            autocorrect: true,
            controller: controller,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            maxLines: textInputType == TextInputType.multiline ? 10 : 1,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
