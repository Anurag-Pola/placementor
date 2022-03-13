import 'package:flutter/material.dart';

class NewsfeedPoll extends StatefulWidget {
  const NewsfeedPoll({Key? key}) : super(key: key);

  @override
  State<NewsfeedPoll> createState() => _NewsfeedPollState();
}

class _NewsfeedPollState extends State<NewsfeedPoll> {
  final List<bool> _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Did you register for Wiley-mthree?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[0] = !_isSelected[0];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[0] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'Yes, Registered!',
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[1] = !_isSelected[1];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[1] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  "I'll register now.",
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_isSelected.contains(true)) {
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = false;
                  }
                }
                _isSelected[2] = !_isSelected[2];
              });
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                color: _isSelected[2] ? Colors.lightBlue : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'No, I have other plans.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
