import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/widgets/newsfeed_firebase_functions.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<dynamic> createPollWidget(BuildContext context) {
  final GlobalKey<FormState> _formQuestionKey = GlobalKey();
  final GlobalKey<FormState> _formAddOptionKey = GlobalKey();
  List<String> _pollOptions = [];
  String? question;

  void _saveForm() async {
    if (_pollOptions.isNotEmpty) {
      String result = await createPollFunction(
          options: _pollOptions,
          question: question,
          pollBy: _auth.currentUser?.email);
      // print(result);
      if (result == "SUCCESS") {
        Navigator.of(context).pop();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text("Error"),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close_rounded),
                      color: Colors.red,
                      iconSize: 30,
                      padding: const EdgeInsets.all(0),
                      splashRadius: 15,
                    ),
                  ],
                ),
                content: Text(result),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text("Error"),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.red,
                    iconSize: 30,
                    padding: const EdgeInsets.all(0),
                    splashRadius: 15,
                  ),
                ],
              ),
              content: const Text("No Options added"),
            );
          });
    }
  }

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text("Create Poll"),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.red,
                iconSize: 30,
                padding: const EdgeInsets.all(0),
                splashRadius: 15,
              ),
            ],
          ),
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Poll By: ${_auth.currentUser?.email}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Question for Poll:",
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formQuestionKey,
                      child: TextFormField(
                        onSaved: (value) {
                          question = value.toString().trim();
                        },
                        validator: (value) {
                          if (value == null || value.trim() == '') {
                            return 'Please enter the Poll Question';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter the Poll Question',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1)),
                        ),
                        maxLines: null,
                        minLines: null,
                        keyboardType: TextInputType.multiline,
                        toolbarOptions: const ToolbarOptions(
                            paste: true,
                            cut: true,
                            copy: true,
                            selectAll: true),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Options for Poll:",
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formAddOptionKey,
                            child: TextFormField(
                              onSaved: (String? value) {
                                _pollOptions.add(value.toString().trim());
                              },
                              validator: (value) {
                                if (value == null || value.trim() == '') {
                                  return 'Please enter the Poll Option';
                                } else if (_pollOptions
                                    .contains(value.trim())) {
                                  return 'Option already exists';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter the Poll Option',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
                              ),
                              toolbarOptions: const ToolbarOptions(
                                  paste: true,
                                  cut: true,
                                  copy: true,
                                  selectAll: true),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(5))),
                            onPressed: () {
                              if (_formAddOptionKey.currentState!.validate()) {
                                setState(() {
                                  _formAddOptionKey.currentState!.save();

                                  _formAddOptionKey.currentState!.reset();
                                });
                              }
                            },
                            icon: const Icon(Icons.my_library_add_rounded,
                                size: 15),
                            label: const Text('Add Option',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pollOptions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.orange, width: 1)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 2),
                          child: ListTile(
                            title: Text(_pollOptions[index],
                                style: const TextStyle(fontSize: 12)),
                            trailing: ElevatedButton.icon(
                              label: const Text(
                                "Delete",
                                style: TextStyle(fontSize: 10),
                              ),
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _pollOptions.removeAt(index);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            leading: const Icon(
                              Icons.alternate_email_rounded,
                              color: Colors.amber,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 25),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15))),
                onPressed: () {
                  // print(1);
                  // print(_formQuestionKey.currentState!.validate());
                  if (_formQuestionKey.currentState!.validate()) {
                    // print(2);
                    _formQuestionKey.currentState!.save();
                    // print(3);
                    // print(_pollOptions.isNotEmpty);

                    _saveForm();
                  }
                },
                icon: const Icon(Icons.add_chart_rounded, size: 25),
                label: const Text('Poll', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        );
      });
}
