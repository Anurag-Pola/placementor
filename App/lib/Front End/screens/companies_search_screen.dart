import 'package:flutter/material.dart';

class CompaniesSearchScreen extends StatefulWidget {
  const CompaniesSearchScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesSearchScreen> createState() => _CompaniesSearchScreenState();
}

class _CompaniesSearchScreenState extends State<CompaniesSearchScreen> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(
            controller: myController,
            width: width,
            onChanged: (i) {},
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Function onChanged;
  const SearchBar(
      {Key? key,
      required this.controller,
      required this.width,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: width * 0.8,
            child: Center(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xffc4c4c4),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 13),
                    border: InputBorder.none,
                    hintText: 'Enter a search term'),
                onChanged: (value) => onChanged(value),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            child: const Icon(Icons.filter_list_rounded),
            onTap: () {},
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
    );
  }
}
