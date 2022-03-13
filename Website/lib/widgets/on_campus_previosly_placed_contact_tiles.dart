import 'package:flutter/material.dart';
import './previosly_placed_contact_details_class.dart';

class PrevioslyPlacedContactTiles extends StatelessWidget {
  final List<PreviouslyPlacedContactDetailsClass>
      previoslyPlacedContactDetailsList;

  const PrevioslyPlacedContactTiles({
    Key? key,
    required this.height,
    required this.previoslyPlacedContactDetailsList,
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
            height: height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PrevioslyPlacedContactTile(
                previouslyPlacedContactDetails:
                    previoslyPlacedContactDetailsList[index],
              ),
              itemCount: previoslyPlacedContactDetailsList.length,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PrevioslyPlacedContactTile extends StatelessWidget {
  final PreviouslyPlacedContactDetailsClass previouslyPlacedContactDetails;

  const PrevioslyPlacedContactTile({
    Key? key,
    required this.previouslyPlacedContactDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            previouslyPlacedContactDetails.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff252b42),
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // const SizedBox(height: 5),
          Text(
            previouslyPlacedContactDetails.batch,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
                  icon: Image.asset(
                    "assets/Images/linkedin-logo.png",
                    width: 30,
                  )),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call_outlined,
                  color: Color(0xFF46B35C),
                  size: 30,
                ),
              ),
              // const SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mail_outline_rounded,
                  color: Color(0xFF1B7AF3),
                  size: 30,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
