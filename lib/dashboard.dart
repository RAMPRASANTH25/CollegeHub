import 'package:college_hub/Dashboard/message/chat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:college_hub/about/about.dart';
import 'Dashboard/schedule/schedule.dart';
import 'Dashboard/attendance/attendance.dart';
import 'Dashboard/result/result_screen.dart';
import 'Dashboard/fees/fees_screen.dart';
import 'Dashboard/club/club.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  DashState createState() => DashState();
}

class DashState extends State<Dash> {
  double? attendancePercentage; // Added this variable

  @override
  void initState() {
    super.initState();
    fetchAttendancePercentage();
  }

  Future<void> fetchAttendancePercentage() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        Map<String, dynamic>? attendanceData =
            userData['attendance'] as Map<String, dynamic>?;

        if (attendanceData != null) {
          String fourthSemesterPercentage = attendanceData['perc']['semester'];

          // Parse the string percentage to double
          double parsedPercentage =
              double.tryParse(fourthSemesterPercentage) ?? 0.0;

          setState(() {
            attendancePercentage = parsedPercentage;
          });
        }
      }
    } catch (e) {
      print("Error fetching attendance percentage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollegeHub'),
        backgroundColor: const Color(0xff24272b),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xfffcfcfc),
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/AiCLub.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/technos.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/mathsclub.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: const [
                    DashboardCard(
                      title: 'NEW MESSAGES',
                      text1: '90',
                      text2: 'GROUP NAME',
                      iconData: Icons.message,
                      color: Color(0xff58a4b0),
                      destination: HomePage(),
                    ),
                    DashboardCard(
                      title: 'SCHEDULE',
                      text1: '',
                      text2: 'NEXT:   Period-I',
                      iconData: Icons.calendar_today,
                      color: Color(0xff8a4fff),
                      destination: Schedule(),
                    ),
                    DashboardCard(
                      title: 'ATTENDANCE',
                      text1: '50%',
                      text2: '',
                      iconData: Icons.check_box,
                      color: Color(0xff58a4b0),
                      destination: Attend(),
                    ),
                    DashboardCard(
                      title: 'SCORES',
                      text1: '',
                      text2:
                          'CAT - I \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t View Results',
                      iconData: Icons.bar_chart,
                      color: Color(0xff8a4fff),
                      destination: ResultScreen(),
                    ),
                    DashboardCard(
                      title: 'FEES',
                      text1: '',
                      text2: 'Pending - Nil',
                      iconData: Icons.currency_rupee,
                      color: Color(0xff58a4b0),
                      destination: FeeScreen(),
                    ),
                    DashboardCard(
                      title: 'CLUBS',
                      text1: '',
                      text2: 'View Clubs',
                      iconData: Icons.group,
                      color: Color(0xff8a4fff),
                      destination: Club(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String text1;
  final Color color;
  final String text2;
  final IconData iconData;
  final Widget destination;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.text1,
    required this.color,
    required this.text2,
    required this.iconData,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          color: color,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destination),
                );
              },
              child: Stack(children: [
                SizedBox(
                  height: 150,
                  child: Column(
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                        child: Text(
                          text1,
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          text2,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ]))),
    );
  }
}
