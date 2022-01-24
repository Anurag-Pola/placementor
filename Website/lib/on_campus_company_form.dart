import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class OnCampusCompanyForm extends StatefulWidget {
  const OnCampusCompanyForm({Key? key}) : super(key: key);

  @override
  State<OnCampusCompanyForm> createState() => _OnCampusCompanyFormState();
}

class _OnCampusCompanyFormState extends State<OnCampusCompanyForm> {
  final _formKey = GlobalKey<FormState>();

  // CollectionReference tickets =
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _roleNameController = TextEditingController();
  final TextEditingController _aboutTheFirmController = TextEditingController();
  final TextEditingController _applyLinkController = TextEditingController();
  final TextEditingController _googleDriveLinkController =
      TextEditingController();
  final TextEditingController _eligibilityController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _packageController = TextEditingController();
  final TextEditingController _skillsetRequiredController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();
  final TextEditingController _date = TextEditingController();

  String? companyType = "Select an Option";
  String? roleType = "Select an Option";

  double paddingToElements = 39;

  Future _selectDate(BuildContext context) async {
    DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //specifies day/month/year format

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365,
        ),
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(
            text: formatter.format(
                picked)); //Use formatter to format selected date and assign to text field
      });
    }
  }

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
                      "Add a Company",
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
                    AppDropdownInput(
                      hintText: "Company Type",
                      options: const ["Select an Option", "Product", "Service"],
                      value: companyType,
                      onChanged: (String? value) {
                        setState(() {
                          companyType = value;
                        });
                      },
                      getLabel: (String value) => value,
                    ),
                    Field(
                      text: "Link for Applying",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _applyLinkController,
                    ),
                    Field(
                      text: "Google Drive Link",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _googleDriveLinkController,
                    ),
                    Field(
                      text: "About the firm",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      controller: _aboutTheFirmController,
                    ),
                    Field(
                      text: "Eligibility",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _eligibilityController,
                    ),
                    Field(
                      text: "Job Description",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _jobDescriptionController,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12.0),
                            controller: _date,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              hintText: 'Last Date to Apply',
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 18.0, bottom: 18.0, top: 18.0),
                            ),
                            // onSaved: (value) => selectedDate  = value,
                          ),
                        ),
                      ),
                    ),
                    Field(
                      text: "Package",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _packageController,
                    ),
                    AppDropdownInput(
                      options: const [
                        "Select an Option",
                        "Full Time",
                        "Internship",
                        "Internship + Full Time",
                        "Internship Based Full Time"
                      ],
                      hintText: "Role Type",
                      value: roleType,
                      onChanged: (String? value) {
                        setState(() {
                          roleType = value;
                        });
                      },
                      getLabel: (String value) => value,
                    ),
                    Field(
                      text: "Skillset Required (Seperate with Commas)",
                      validateFunction: validateFunction,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _skillsetRequiredController,
                    ),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // tickets.add({
                      // 'title': _titleController.text,
                      // 'description': _descriptionController.text,
                      // });
                      // _titleController.clear();
                      // _descriptionController.clear();
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

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.text,
    required this.validateFunction,
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
    fontFamily: "Montserrat",
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
            text,
            style: textStyle,
          ),
          SizedBox(height: height * 0.014),
          TextFormField(
            validator: (value) {
              return validateFunction!(value);
            },
            decoration: textFormFieldDecoration,
            autocorrect: true,
            controller: controller,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T? value;
  final String Function(T)? getLabel;
  final void Function(T?)? onChanged;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    required this.options,
    this.value,
    this.getLabel,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null ||
              value == '' ||
              value == 'Please select an Option',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel!(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
