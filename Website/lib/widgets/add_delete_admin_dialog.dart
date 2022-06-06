import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/widgets/custom_user.dart';

import 'manage_users_functions.dart';

Future<dynamic> addAdminDialog(
    BuildContext context,
    CollectionReference metadataCollectionRef,
    CollectionReference adminDataCollectionRef) async {
  final GlobalKey<FormState> _formKey = GlobalKey();
  CustomAdminUser newAdminUser = CustomAdminUser();
  List departmentList =
      (((await metadataCollectionRef.doc('CollegeMetadata').get()).data()
          as Map<String, dynamic>?)!['department']);
  departmentList.sort();

  List<Map<String, dynamic>> _formFieldsList = [
    {
      "fieldLabel": "Name of Admin",
      "validator": (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter admin name';
        }
        return null;
      },
      "onSaved": (String? value) {
        newAdminUser.name = value;
      },
      "keyboardType": TextInputType.text,
    },
    {
      "fieldLabel": "Email ID",
      "validator": (String? email) {
        if (email == null || email.isEmpty) {
          return 'Please enter email id';
        }
        bool _emailValid =
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@vnrvjiet.in")
                .hasMatch(email);
        if (!_emailValid) {
          return 'Please enter valid email id';
        }
        return null;
      },
      "onSaved": (String? email) {
        newAdminUser.email = email;
      },
      "keyboardType": TextInputType.emailAddress,
    },
    {
      "fieldLabel": "Phone Number",
      "validator": (String? phone) {
        if (phone == null || phone.isEmpty) {
          return 'Please enter phone number';
        }
        bool _phoneValid = RegExp(r"^[0-9]{10}$").hasMatch(phone);
        if (!_phoneValid) {
          return 'Please enter valid phone number';
        }
        return null;
      },
      "onSaved": (String? phone) {
        newAdminUser.phone = phone;
      },
      "keyboardType": TextInputType.phone,
    },
    {
      "fieldLabel": "Employee ID",
      "validator": (String? employeeId) {
        if (employeeId == null || employeeId.isEmpty) {
          return 'Please enter employee ID';
        }
        return null;
      },
      "onSaved": (String? employeeId) {
        newAdminUser.employeeId = employeeId;
      },
      "keyboardType": TextInputType.text,
    },
    {
      "fieldLabel": "Password",
      "validator": (String? password) {
        if (password == null || password.isEmpty) {
          return 'Please enter password';
        }
        bool _passwordValid = RegExp(
                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
            .hasMatch(password);
        if (!_passwordValid) {
          return 'Please enter valid password';
        }
        newAdminUser.password = password;
        return null;
      },
      "onSaved": (String? password) {
        newAdminUser.password = password;
      },
      "keyboardType": TextInputType.visiblePassword,
      "obscureText": true
    },
    {
      "fieldLabel": "Confirm Password",
      "validator": (String? confirmPassword) {
        if (newAdminUser.password == null) {
          return null;
        }
        if (confirmPassword == null || confirmPassword.isEmpty) {
          return 'Please confirm password';
        }
        if (newAdminUser.password != confirmPassword) {
          return 'Passwords do not match';
        }
        return null;
      },
      "onSaved": (String? confirmPassword) {},
      "keyboardType": TextInputType.text,
    }
  ];

  void _saveForm() async {
    Map<String, dynamic> result = await registerAdminWithEmailPassword(
        adminDataCollectionRef, newAdminUser);
    Navigator.of(context).pop(result);
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
                child: Text("Add Admin Details"),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: departmentList.map((var dept) {
                          return DropdownMenuItem(
                            value: dept,
                            child: Text(dept),
                          );
                        }).toList(),

                        // value: dropDownValue,
                        focusColor: Colors.white,
                        onChanged: (var department) {},
                        hint: const Text(
                          'Select Department',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        validator: (var department) {
                          if (department == null) {
                            return 'Please select department';
                          }
                          return null;
                        },
                        onSaved: (var department) {
                          newAdminUser.department = department.toString();
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ..._formFieldsList.map((e) => Column(
                            children: [
                              TextFormField(
                                onSaved: e["onSaved"],
                                validator: e["validator"],
                                decoration: InputDecoration(
                                  labelText: e['fieldLabel'],
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: const OutlineInputBorder(),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  suffixIcon: e['fieldLabel'] == 'Password'
                                      ? IconButton(
                                          icon: Icon(
                                            e['obscureText']
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              e['obscureText'] =
                                                  !e['obscureText'];
                                            });
                                          },
                                        )
                                      : null,
                                ),
                                keyboardType: e["keyboardType"],
                                toolbarOptions:
                                    e['fieldLabel'] != "Confirm Password"
                                        ? const ToolbarOptions(
                                            paste: true,
                                            cut: true,
                                            copy: true,
                                            selectAll: true)
                                        : null,
                                style: const TextStyle(fontSize: 12),
                                obscureText: e['fieldLabel'] == 'Password'
                                    ? e['obscureText']
                                    : e['fieldLabel'] == "Confirm Password",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          )),
                    ],
                  ),
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveForm();
                  }
                },
                icon: const Icon(Icons.person_add_rounded, size: 25),
                label: const Text('Add Admin', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        );
      });
}

Future<dynamic> deleteAdminDialog(
    BuildContext context, CollectionReference adminDataCollectionRef) async {
  List<CustomAdminUser> _adminList = (await adminDataCollectionRef
          .withConverter<CustomAdminUser>(
            fromFirestore: (snapshot, _) =>
                CustomAdminUser.fromJSON(snapshot.data()!),
            toFirestore: (company, _) => company.toJson(),
          )
          .orderBy('department')
          .get())
      .docs
      .map((e) => e.data())
      .toList();

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
                child: Text("Delete Admin"),
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
          content: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                          children: [
                        "Department",
                        "Admin Name",
                        "Admin Email",
                        "Admin Phone",
                        "Employee ID",
                        "Delete Action"
                      ]
                              .map((e) => TableCell(
                                      child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(e,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )))
                              .toList()),
                      ..._adminList
                          .map((admin) => TableRow(
                                children: [
                                  ...[
                                    admin.department,
                                    admin.name,
                                    admin.email,
                                    admin.phone,
                                    admin.employeeId
                                  ].map(
                                    (cellValue) => TableCell(
                                        child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(cellValue!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: (cellValue ==
                                                        admin.department)
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                      ),
                                    )),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Delete Admin?",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                        Icons.close_rounded),
                                                    color: Colors.red,
                                                    iconSize: 20,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    splashRadius: 15,
                                                  ),
                                                ],
                                              ),
                                              content: Text(
                                                  "Are you sure you want to delete ${admin.name} as admin?"),
                                              actions: const []);
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.delete_forever_rounded),
                                    color: Colors.red,
                                    iconSize: 30,
                                    padding: const EdgeInsets.all(0),
                                    splashRadius: 15,
                                  )
                                ],
                              ))
                          .toList()
                    ]),
              )),
        );
      });
}
