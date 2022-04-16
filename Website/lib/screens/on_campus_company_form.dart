import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/experience_tile_class.dart';
import '../widgets/faq_tiles_class.dart';
import '../widgets/on_campus_process_timeline.dart';
import '../widgets/previosly_placed_contact_details_class.dart';
import '../widgets/process_timeline_class.dart';

class OnCampusCompanyForm extends StatefulWidget {
  const OnCampusCompanyForm(
      {Key? key,
      this.companyName = "",
      this.companyType = "",
      this.roleName = "",
      this.aboutTheFirm = "",
      this.experienceTilesInfo = const [],
      this.faqTilesInfo = const [],
      this.previouslyPlacedContactDetails = const [],
      this.processTimeline = const ProcessTimelineClass(
          dates: [], steps: [], names: [], descriptions: []),
      this.jobDescription = "",
      this.lastDate = "",
      this.roleType = "",
      this.salary = "",
      this.skillset = const [],
      this.linkToApply = "",
      this.driveLink = "",
      this.eligibility = ""})
      : super(key: key);

  final String companyName;
  final String companyType;
  final String roleName;
  final String aboutTheFirm;
  final String roleType;
  final String jobDescription;
  final List<String> skillset;
  final ProcessTimelineClass processTimeline;
  final List<PreviouslyPlacedContactDetailsClass>
      previouslyPlacedContactDetails;
  final List<ExperienceTileClass> experienceTilesInfo;
  final List<FAQTilesClass> faqTilesInfo;
  final String lastDate;
  final String salary;
  final String linkToApply;
  final String driveLink;
  final String eligibility;

  @override
  State<OnCampusCompanyForm> createState() => _OnCampusCompanyFormState();
}

class _OnCampusCompanyFormState extends State<OnCampusCompanyForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _companyNameController =
      TextEditingController(text: widget.companyName);
  late final TextEditingController _roleNameController =
      TextEditingController(text: widget.roleName);
  late final TextEditingController _aboutTheFirmController =
      TextEditingController(text: widget.aboutTheFirm);
  late final TextEditingController _applyLinkController =
      TextEditingController(text: widget.linkToApply);
  late final TextEditingController _googleDriveLinkController =
      TextEditingController(text: widget.driveLink);
  late final TextEditingController _eligibilityController =
      TextEditingController(text: widget.eligibility);
  late final TextEditingController _jobDescriptionController =
      TextEditingController(text: widget.jobDescription);
  late final TextEditingController _packageController =
      TextEditingController(text: widget.salary);

  late var lastdate = widget.lastDate.split('/').reversed.join('-');
  late DateTime selectedDate =
      widget.lastDate == "" ? DateTime.now() : DateTime.parse(lastdate);
  late final TextEditingController _date =
      TextEditingController(text: lastdate);

  late String? companyType =
      widget.companyType == "" ? "Select an Option" : widget.companyType;
  late String? roleType =
      widget.roleType == "" ? "Select an Option" : widget.roleType;

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
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      controller: _jobDescriptionController,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: const TextStyle(
                              color: Color(0xff252b42),
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
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
                    ComplexField(
                      text: "Skillset Required",
                      validateFunction: validateFunction,
                      options: widget.skillset,
                      optionsFor: "Skillset",
                    ),
                    ComplexField(
                      text: "Previously Placed Contact Details",
                      validateFunction: validateFunction,
                      options: widget.previouslyPlacedContactDetails,
                      optionsFor: "Previously Placed Contact Details",
                    ),
                    ComplexField(
                      text: "Experiences",
                      validateFunction: validateFunction,
                      options: widget.experienceTilesInfo,
                      optionsFor: "Experiences",
                    ),
                    ComplexField(
                      text: "Process Timeline",
                      validateFunction: validateFunction,
                      options: [widget.processTimeline],
                      optionsFor: "Process Timeline",
                      buttonText: "Add or Update",
                    ),
                    ComplexField(
                      text: "FAQs",
                      validateFunction: validateFunction,
                      options: widget.faqTilesInfo,
                      optionsFor: "FAQs",
                    ),
                  ],
                ),
              ),
              InkWell(
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
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - safeAreaHeight;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.633,
      height: textInputType == TextInputType.multiline ? 125 : 90,
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
            maxLines: textInputType == TextInputType.multiline ? 2 : 1,
          ),
          const SizedBox(
            height: 10,
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
    return Column(
      children: [
        FormField<T>(
          builder: (FormFieldState<T> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                labelText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
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
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class ComplexField extends StatefulWidget {
  const ComplexField({
    Key? key,
    required this.text,
    required this.validateFunction,
    required this.options,
    required this.optionsFor,
    this.expand = false,
    this.buttonText = 'Add',
  }) : super(key: key);

  final String text;
  final Function? validateFunction;
  final List options;
  final String optionsFor;
  final bool expand;
  final String buttonText;

  @override
  State<ComplexField> createState() => _ComplexFieldState();
}

class _ComplexFieldState extends State<ComplexField> {
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

  late List options;

  @override
  void initState() {
    super.initState();
    options = widget.options.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> optionsContent = [];
    for (var option in options) {
      switch (widget.optionsFor) {
        case "Skillset":
          optionsContent.add(
            SkillsetOption(
              skill: option,
              func: () {
                options.remove(option);
                setState(() {});
              },
            ),
          );
          break;
        case "Previously Placed Contact Details":
          optionsContent.add(
            PreviouslyPlacedContactDetailsOption(
              previoslyPlacedContact: option,
              func: () {
                options.remove(option);
                setState(() {});
              },
            ),
          );
          break;
        case "Experiences":
          optionsContent.add(
            ExperiencesOption(
              experience: option,
              func: () {
                options.remove(option);
                setState(() {});
              },
            ),
          );
          break;
        case "FAQs":
          optionsContent.add(
            FAQsOption(
              faq: option,
              func: () {
                options.remove(option);
                setState(() {});
              },
            ),
          );
          break;
        case "Process Timeline":
          optionsContent.add(
            ProcessTimelineOption(
              processTimeline: option,
              func: () {
                options.remove(option);
                setState(() {});
              },
            ),
          );
          break;
        default:
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: textStyle,
              ),
              const SizedBox(width: 5),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    switch (widget.optionsFor) {
                      case "Skillset":
                        showDialog(
                          context: context,
                          builder: (context) => skillsetDialog(context),
                        );
                        break;
                      case "Previously Placed Contact Details":
                        showDialog(
                          context: context,
                          builder: (context) =>
                              previouslyPlacedContactDetailsDialog(context),
                        );
                        break;
                      case "Experiences":
                        showDialog(
                          context: context,
                          builder: (context) => experiencesDialog(context),
                        );
                        break;
                      case "FAQs":
                        showDialog(
                          context: context,
                          builder: (context) => faqsDialog(context),
                        );
                        break;
                      case "Process Timeline":
                        showDialog(
                          context: context,
                          builder: (context) =>
                              processTimelineDialog(context, widget.options),
                        );
                        break;
                      default:
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Center(
                      child: Text(
                        widget.buttonText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: optionsContent),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  AlertDialog skillsetDialog(BuildContext context) {
    final TextEditingController _skillController = TextEditingController();
    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new skill",
            style: textStyle,
          ),
          TextFormField(
            validator: (value) {
              return widget.validateFunction!(value);
            },
            decoration: textFormFieldDecoration,
            autocorrect: true,
            controller: _skillController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_skillController.text != '') {
              options.add(_skillController.text);
              _skillController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  AlertDialog previouslyPlacedContactDetailsDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _batchController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _linkedinController = TextEditingController();

    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new contact",
            style: textStyle,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Name"),
            autocorrect: true,
            controller: _nameController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Batch"),
            autocorrect: true,
            controller: _batchController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Email"),
            autocorrect: true,
            controller: _emailController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Phone"),
            autocorrect: true,
            controller: _phoneController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Linkedin"),
            autocorrect: true,
            controller: _linkedinController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_nameController.text != '' &&
                _batchController.text != '' &&
                _emailController.text != '' &&
                _phoneController.text != '' &&
                _linkedinController.text != '') {
              options.add(
                PreviouslyPlacedContactDetailsClass(
                  name: _nameController.text,
                  batch: _batchController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  linkedin: _linkedinController.text,
                ),
              );
              _nameController.text = '';
              _batchController.text = '';
              _emailController.text = '';
              _phoneController.text = '';
              _linkedinController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  AlertDialog experiencesDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _batchController = TextEditingController();
    final TextEditingController _experienceController = TextEditingController();

    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new contact",
            style: textStyle,
          ),
          TextFormField(
            decoration:
                textFormFieldDecoration.copyWith(hintText: "Experience"),
            autocorrect: true,
            controller: _experienceController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Name"),
            autocorrect: true,
            controller: _nameController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Batch"),
            autocorrect: true,
            controller: _batchController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_nameController.text != '' &&
                _batchController.text != '' &&
                _experienceController.text != '') {
              options.add(
                ExperienceTileClass(
                  experience: _experienceController.text,
                  name: _nameController.text,
                  batch: _batchController.text,
                ),
              );
              _experienceController.text = '';
              _nameController.text = '';
              _batchController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  AlertDialog faqsDialog(BuildContext context) {
    final TextEditingController _questionController = TextEditingController();
    final TextEditingController _answerController = TextEditingController();

    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new FAQ",
            style: textStyle,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Question"),
            autocorrect: true,
            controller: _questionController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Answer"),
            autocorrect: true,
            controller: _answerController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_questionController.text != '' &&
                _answerController.text != '') {
              options.add(
                FAQTilesClass(
                  question: _questionController.text,
                  answer: _answerController.text,
                ),
              );
              _questionController.text = '';
              _answerController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  AlertDialog processTimelineDialog(
      BuildContext context, List processTimeline) {
    final TextEditingController _stepsController =
        TextEditingController(text: processTimeline[0].steps.join(";"));
    final TextEditingController _namesController =
        TextEditingController(text: processTimeline[0].names.join(";"));
    final TextEditingController _datesController =
        TextEditingController(text: processTimeline[0].dates.join(";"));
    final TextEditingController _descriptionsController =
        TextEditingController(text: processTimeline[0].descriptions.join(";"));

    return AlertDialog(
      title: const Text("Add or Update"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add or Update the Process Timeline",
            style: textStyle,
          ),
          Text(
            "Note : Enter equal number of steps, names, dates and descriptions\n"
            "Separate each field with a semi-colon (Ex : Steps : 1;2;3;4)\n",
            style: textStyle,
          ),
          TextFormField(
            decoration:
                textFormFieldDecoration.copyWith(hintText: "Step Numbers"),
            autocorrect: true,
            controller: _stepsController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Names"),
            autocorrect: true,
            controller: _namesController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Dates"),
            autocorrect: true,
            controller: _datesController,
          ),
          TextFormField(
            decoration:
                textFormFieldDecoration.copyWith(hintText: "Descriptions"),
            autocorrect: true,
            controller: _descriptionsController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Update",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            if (_stepsController.text != '' &&
                _namesController.text != '' &&
                _datesController.text != '' &&
                _descriptionsController.text != '' &&
                _stepsController.text.split(";").length ==
                    _namesController.text.split(";").length &&
                _namesController.text.split(";").length ==
                    _datesController.text.split(";").length &&
                _datesController.text.split(";").length ==
                    _descriptionsController.text.split(";").length) {
              final steps = _stepsController.text.split(";");
              final names = _namesController.text.split(";");
              final dates = _datesController.text.split(";");
              final descriptions = _descriptionsController.text.split(";");
              final newProcessTimeline = ProcessTimelineClass(
                steps: steps,
                names: names,
                dates: dates,
                descriptions: descriptions,
              );
              options.clear();
              options.add(newProcessTimeline);
              _stepsController.text = '';
              _namesController.text = '';
              _datesController.text = '';
              _descriptionsController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class SkillsetOption extends StatelessWidget {
  const SkillsetOption({Key? key, required this.skill, required this.func})
      : super(key: key);

  final String skill;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(skill),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                func();
              },
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 15,
              ),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
    );
  }
}

class PreviouslyPlacedContactDetailsOption extends StatelessWidget {
  const PreviouslyPlacedContactDetailsOption({
    Key? key,
    required this.previoslyPlacedContact,
    required this.func,
  }) : super(key: key);

  final PreviouslyPlacedContactDetailsClass previoslyPlacedContact;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(previoslyPlacedContact.name),
              Text(previoslyPlacedContact.batch),
              Text(previoslyPlacedContact.email),
              Text(previoslyPlacedContact.phone),
              Text(previoslyPlacedContact.linkedin),
            ],
          ),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                func();
              },
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 15,
              ),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
    );
  }
}

class ExperiencesOption extends StatelessWidget {
  const ExperiencesOption({
    Key? key,
    required this.experience,
    required this.func,
  }) : super(key: key);

  final ExperienceTileClass experience;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                Text(
                  experience.experience,
                ),
                const SizedBox(height: 10),
                Text(
                  experience.name,
                ),
                Text(
                  experience.batch,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                func();
              },
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 25,
              ),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
    );
  }
}

class FAQsOption extends StatelessWidget {
  const FAQsOption({
    Key? key,
    required this.faq,
    required this.func,
  }) : super(key: key);

  final FAQTilesClass faq;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                Text(
                  faq.question,
                ),
                const SizedBox(height: 10),
                Text(
                  faq.answer,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                func();
              },
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 25,
              ),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
    );
  }
}

class ProcessTimelineOption extends StatelessWidget {
  const ProcessTimelineOption({
    Key? key,
    required this.processTimeline,
    required this.func,
  }) : super(key: key);

  final ProcessTimelineClass processTimeline;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return processTimeline.steps.isNotEmpty
        ? Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      ProcessTimeline(
                        processTimeline: processTimeline,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      func();
                    },
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(4),
          )
        : Container();
  }
}
