import 'package:flutter/material.dart';

import 'maths_club.dart';
import 'ai_club.dart';
import 'cyber_security.dart';
import 'technos_club.dart';

class Club extends StatefulWidget {
  const Club({Key? key}) : super(key: key);
  @override
  ClubState createState() => ClubState();
}

class ClubState extends State<Club> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: const [
              ClubboardCard(
                title: 'Club 1',
                text2: 'Maths Club',
                color: Colors.black,
                destination: Mathsclub(),
                imagePath: 'assets/mathsclub.jpg',
                alignment: Alignment.topCenter,
              ),
              ClubboardCard(
                title: 'Club 2',
                text2: 'Technos',
                color: Colors.grey,
                destination: Technosclub(),
                imagePath: 'assets/technos.jpg',
                alignment: Alignment.topCenter,
              ),
              ClubboardCard(
                title: 'Club 3',
                text2: 'Cyber Security',
                color: Colors.grey,
                destination: Cyberclub(),
                imagePath: 'assets/Cyber Security.jpg',
                alignment: Alignment.topRight,
              ),
              ClubboardCard(
                title: 'Club 4',
                text2: 'AI Techies',
                color: Color.fromRGBO(158, 158, 158, 1),
                destination: Aiclub(),
                imagePath: 'assets/AiCLub.jpg',
                alignment: Alignment.topLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClubboardCard extends StatelessWidget {
  final String title;
  final Color color;
  final String text2;
  final Widget destination;
  final String imagePath;

  const ClubboardCard({
    Key? key,
    required this.title,
    required this.color,
    required this.text2,
    required this.destination,
    required this.imagePath,
    required Alignment alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Stack(
          fit: StackFit.loose,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 252, 252),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 125, 0, 5),
                  child: Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
