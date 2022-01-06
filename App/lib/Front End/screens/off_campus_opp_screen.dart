import 'package:flutter/material.dart';

class OffCampusOppScreen extends StatelessWidget {
  const OffCampusOppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_today_rounded,
                color: Colors.black,
                size: 16,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
