import 'package:flutter/material.dart';

class FAQTiles extends StatefulWidget {
  const FAQTiles({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  @override
  State<FAQTiles> createState() => _FAQTilesState();
}

class _FAQTilesState extends State<FAQTiles> {
  List<bool> _isOpen = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: widget.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Opacity(
              opacity: 0.75,
              child: Text(
                "FAQ",
                style: TextStyle(
                  color: Color(0xff18191e),
                  fontSize: 13,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.75,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: ExpansionPanelList(
                    expansionCallback: (i, isOpen) => setState(() {
                          _isOpen[i] = !_isOpen[i];
                        }),
                    children: [0, 1, 2, 3, 4].map<ExpansionPanel>((e) {
                      return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder: (context, isOpen) {
                            return const ListTile(
                              title: Text(
                                "What does the company expect from students?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                          body: const ListTile(
                            title: Text(
                              "Basic knowledge on mezzanine technologies like flutter, dart and firebase.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          isExpanded: _isOpen[e]);
                    }).toList()),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
