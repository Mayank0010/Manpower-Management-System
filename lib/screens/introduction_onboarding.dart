import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:manpower_management_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Connect With Everyone',
      body: 'Connect with us to request a service for your home.',
      footer: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            "Let's Go",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ),
      ),
      image: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(
          'assets/images/pest.png',
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    ),
    PageViewModel(
        title: 'Have Access Everywhere!',
        body: 'Leading Home Service and Products Provider',
        footer: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              "Why to wait!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        image: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(
            'assets/images/paint.png',
          ),
        ),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            )
        )
    ),
    PageViewModel(
        title: 'Here We Start!',
        body: 'Customized Services',
        footer: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              "Let's Start",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        image: AnimatedContainer(
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          height: 200,
          width: 200,
          child: Image.asset(
            'assets/images/electrician.png',
          ),
        ),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'All Type Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: IntroductionScreen(
          pages: pages,
          globalBackgroundColor: Colors.white,
          showSkipButton: true,
          skip: Text(
            'Skip',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward, color: Colors.orange, size: 30.0,),
          showDoneButton: true,
          done: const Text(
            'Get Started',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
          dotsDecorator: DotsDecorator(
            activeColor: Colors.orangeAccent,
            size: Size(8.0, 8.0),
            color: Colors.grey,
            activeSize: Size(14.0, 14.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),

        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}