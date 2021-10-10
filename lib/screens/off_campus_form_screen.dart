import 'package:flutter/material.dart';

class OffCampusFormScreen extends StatelessWidget {
  const OffCampusFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: SizedBox(
              width: 309,
              height: 56,
              child: Text(
                "Let us know about an off campus opportunity, which is not available in the app",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
