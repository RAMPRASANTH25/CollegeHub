import 'package:flutter/material.dart';
import 'package:college_hub/about/about.dart';
import 'package:college_hub/about/notification.dart';
import 'package:college_hub/Dashboard/message/chat.dart';
import 'package:college_hub/Dashboard/schedule/schedule.dart';
import 'Dashboard/attendance/attendance.dart';
import 'Dashboard/result/result_screen.dart';
import 'Dashboard/fees/fees_screen.dart';
import 'Dashboard/club/club.dart';

class TeachDash extends StatefulWidget {
  const TeachDash({Key? key}) : super(key: key);
  @override
  TeachDashState createState() => TeachDashState();
}

class TeachDashState extends State<TeachDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('CollegeHub'),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
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
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Notify()));
              },
            )
          ]),
      body: Center(
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
                  color: Colors.black,
                  destination: HomePage()),
              DashboardCard(
                title: 'SCHEDULE',
                text1: '',
                text2: 'NEXT:   Period-I',
                iconData: Icons.calendar_today,
                color: Colors.black,
                destination: Schedule(),
              ),
              DashboardCard(
                title: 'ATTENDANCE',
                text1: '85%',
                text2: '',
                iconData: Icons.check_box,
                color: Colors.black,
                destination: Attend(),
              ),
              DashboardCard(
                title: 'SCORES',
                text1: '',
                text2:
                    'CAT - I \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t View Results',
                iconData: Icons.bar_chart,
                color: Colors.black,
                destination: ResultScreen(),
              ),
              DashboardCard(
                title: 'FEES',
                text1: '',
                text2: 'Pending - Nil',
                iconData: Icons.currency_rupee,
                color: Colors.black,
                destination: FeeScreen(),
              ),
              DashboardCard(
                title: 'CLUBS',
                text1: '',
                text2: 'View Clubs',
                iconData: Icons.group,
                color: Colors.black,
                destination: Club(),
              ),
            ],
          ),
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
    return Card(
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            ])));
  }
}
