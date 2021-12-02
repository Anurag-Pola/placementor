import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart' as intro;

class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  final List<String> descriptions = [
    "Get to know everything \nabout placements at \nyour fingertips",
    "With the help of \nnotifications, grab all \nopportunities",
    "Create your profile and \nlet T&P know where you \nstand",
    "Browse roles, processes, \nbasic info and skillsets \nrequired by companies",
    "Add remainders to \ncalender, make a to-do \nlist, get resume tips and \nmany more...",
  ];

  final List<int> colors = [
    0xccff7f50,
    0x7fff4757,
    0xb2ff6348,
    0xcc5352ed,
    0xff8574eb
  ];

  final List<String> images = [
    "assets/images/Carousel1.png",
    "assets/images/Carousel2.png",
    "assets/images/Carousel3.png",
    "assets/images/Carousel4.png",
    "assets/images/Carousel5.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: intro.IntroductionScreen(
            rawPages: [
              CarouselPage(
                description: descriptions[0],
                color: colors[0],
                image: images[0],
              ),
              CarouselPage(
                description: descriptions[1],
                color: colors[1],
                image: images[1],
              ),
              CarouselPage(
                description: descriptions[2],
                color: colors[2],
                image: images[2],
              ),
              CarouselPage(
                description: descriptions[3],
                color: colors[3],
                image: images[3],
              ),
              CarouselPage(
                description: descriptions[4],
                color: colors[4],
                image: images[4],
              ),
            ],
            onDone: () {
              Navigator.of(context).pushReplacementNamed('/loginPage');
            },
            showSkipButton: true,
            skip: const Text(
              'Skip',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
            next: const Text(
              "Next",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
            done: const Text(
              "Done",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
            curve: Curves.easeInOutCubic,
            dotsDecorator: intro.DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Colors.black,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          ),
        ),
      ),
    );
  }
}

class CarouselPage extends StatelessWidget {
  final String description;
  final int color;
  final String image;

  const CarouselPage({
    Key? key,
    required this.description,
    required this.color,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color),
      child: Column(children: [
        Image.asset(
          image,
          height: 450,
          width: 450,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
    );
  }
}
