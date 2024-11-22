import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Aiclub extends StatefulWidget {
  const Aiclub({Key? key}) : super(key: key);

  @override
  State<Aiclub> createState() => _AiclubState();
}

class _AiclubState extends State<Aiclub> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: height * 0.3,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/AiCLub.jpg"),
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Navigate back to previous page
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "AI Club",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const TitleDetail(title: "Coordinator", detail: "Ramprasanth"),
              const TitleDetail(title: "Contact", detail: "1234567889"),
              const TitleDetail(
                title: "Description",
                detail:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
              ),
              const TitleDetail(title: "Upcoming Events", detail: "Event A"),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleDetail extends StatelessWidget {
  final String title;
  final String detail;
  const TitleDetail({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(detail, style: GoogleFonts.montserrat(fontSize: 15)),
        ],
      ),
    );
  }
}
