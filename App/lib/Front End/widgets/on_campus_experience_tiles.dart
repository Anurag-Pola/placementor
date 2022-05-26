import 'package:flutter/material.dart';
import '../models/experience_tile_class.dart';

class ExperienceTiles extends StatelessWidget {
  final List<ExperienceTileClass> experienceTilesInfo;

  const ExperienceTiles({
    Key? key,
    required this.height,
    required this.experienceTilesInfo,
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
              "EXPERIENCES",
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
            height: height * 0.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ExperienceTile(
                experienceTileInfo: experienceTilesInfo[index],
              ),
              itemCount: experienceTilesInfo.length,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ExperienceTile extends StatelessWidget {
  final ExperienceTileClass experienceTileInfo;

  const ExperienceTile({
    Key? key,
    required this.experienceTileInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.6,
      height: height * 0.5,
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
          // const SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  experienceTileInfo.experience,
                  style: const TextStyle(
                    color: Color(0xff727272),
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/tnp_coordinators_image.png',
                    scale: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experienceTileInfo.name,
                    style: const TextStyle(
                      color: Color(0xff23a6f0),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    experienceTileInfo.batch,
                    style: const TextStyle(
                      color: Color(0xff252b42),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
