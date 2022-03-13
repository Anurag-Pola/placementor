import 'package:flutter/material.dart';
import './faq_tiles_class.dart';

class FAQTiles extends StatefulWidget {
  final List<FAQTilesClass> faqTilesInfo;
  const FAQTiles({
    Key? key,
    required this.height,
    required this.faqTilesInfo,
  }) : super(key: key);

  final double height;

  @override
  State<FAQTiles> createState() => _FAQTilesState();
}

class _FAQTilesState extends State<FAQTiles> {
  late List<bool> _isOpen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOpen = List.filled(widget.faqTilesInfo.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: widget.height * 0.5,
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
                    children: widget.faqTilesInfo.map<ExpansionPanel>((e) {
                      return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder: (context, isOpen) {
                            return ListTile(
                              title: Text(
                                e.question,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                          body: ListTile(
                            title: Text(
                              e.answer,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          isExpanded: _isOpen[widget.faqTilesInfo.indexOf(e)]);
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
