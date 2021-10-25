import 'package:flutter/material.dart';

class MyExpandableCard extends StatefulWidget {
  final String heading;
  final String content;

  const MyExpandableCard({
    Key? key,
    required this.content,
    required this.heading,
  }) : super(key: key);

  @override
  State<MyExpandableCard> createState() => _MyExpandableCardState();
}

class _MyExpandableCardState extends State<MyExpandableCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.75,
            child: Text(
              widget.heading,
              style: const TextStyle(
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
          ExpandableCardContainer(
            collapsedChild: SizedBox(
              height: height * 0.1,
              child: Text(
                widget.content,
                overflow: TextOverflow.clip,
              ),
            ),
            expandedChild: SizedBox(child: Text(widget.content)),
            isExpanded: expanded,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  expanded ? "See less" : "See more",
                  style: const TextStyle(
                    color: Color(0xff1c58f2),
                    fontSize: 13,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  expanded
                      ? Icons.arrow_drop_up_sharp
                      : Icons.arrow_drop_down_sharp,
                  color: const Color(0xff1c58f2),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ExpandableCardContainer extends StatefulWidget {
  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  const ExpandableCardContainer(
      {Key? key,
      required this.isExpanded,
      required this.collapsedChild,
      required this.expandedChild})
      : super(key: key);

  @override
  _ExpandableCardContainerState createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
    );
  }
}
