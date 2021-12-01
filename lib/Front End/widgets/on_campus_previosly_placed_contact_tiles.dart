import 'package:flutter/material.dart';

class PrevioslyPlacedContactTiles extends StatelessWidget {
  const PrevioslyPlacedContactTiles({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
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
          const Opacity(
            opacity: 0.75,
            child: Text(
              "PREVIOUSLY PLACED CONTACTS",
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
            height: height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  const PrevioslyPlacedContactTile(),
              itemCount: 6,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PrevioslyPlacedContactTile extends StatelessWidget {
  const PrevioslyPlacedContactTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Name",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // const SizedBox(height: 5),
          const Text(
            "Batch",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call_outlined,
                  color: Color(0xFF46B35C),
                  size: 36,
                ),
              ),
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mail_outline_rounded,
                  color: Color(0xFF1B7AF3),
                  size: 36,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
