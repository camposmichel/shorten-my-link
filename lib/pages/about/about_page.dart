import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class AboutPage extends StatelessWidget {
  static SizedBox get _spacer => const SizedBox(height: 10);
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Lottie.asset('assets/animations/coding.json'),
          ),
          Text('Hello, I\'m Michel', style: TextStyle(fontSize: 26)),
          Text(
            'I\'m a Frontend and Mobile Developer',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Flutter | Dart | JavaScript | Angular | NGRX | NodeJS',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('Contact me at:', textAlign: TextAlign.center),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, size: 24),
              SizedBox(width: 10),
              Text('michelcsilva@live.com'),
            ],
          ),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.linkedin, size: 24),
              SizedBox(width: 10),
              Text('/michelcsilva'),
            ],
          ),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.github, size: 24),
              SizedBox(width: 10),
              Text('/camposmichel'),
            ],
          ),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.discord, size: 24),
              SizedBox(width: 10),
              Text('camposmichel'),
            ],
          ),
        ],
      ),
    );
  }
}
