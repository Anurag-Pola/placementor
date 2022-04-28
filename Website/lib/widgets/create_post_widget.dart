import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/widgets/newsfeed_firebase_functions.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<dynamic> createPostWidget(BuildContext context) {
  final GlobalKey<FormState> _formPostKey = GlobalKey();
  String? postText;

  void _saveForm() async {
    String result = await createPostFunction(
        postText: postText, postBy: _auth.currentUser?.email);
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
              content: Text(result),
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
                child: Text("Create Post"),
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
                    Text("Post By: ${_auth.currentUser?.email}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Content for Post:",
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formPostKey,
                      child: TextFormField(
                        onSaved: (value) {
                          postText = value.toString().trim();
                        },
                        validator: (value) {
                          if (value == null || value.trim() == '') {
                            return 'Please enter the Post Content';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter the Post Content',
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
                  if (_formPostKey.currentState!.validate()) {
                    _formPostKey.currentState!.save();
                    _saveForm();
                  }
                },
                icon: const Icon(Icons.post_add, size: 25),
                label: const Text('Post', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        );
      });
}
