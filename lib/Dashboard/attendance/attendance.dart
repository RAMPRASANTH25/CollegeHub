import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Attend extends StatefulWidget {
  const Attend({Key? key}) : super(key: key);

  @override
  AttendState createState() => AttendState();
}

class AttendState extends State<Attend> {
  Map<String, dynamic> attendanceDetails = {};
  bool isLoading = true;
  Future<void> getAttendanceDetails(String semester) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var res = FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("attendance")
        .where(
          "semester",
          isEqualTo: semester.toLowerCase(),
        )
        .limit(1)
        .get();

    try {
      var doc = await res;
      if (doc.docs.isNotEmpty) {
        setState(() {
          attendanceDetails = {
            'perc': doc.docs[0]['perc'],
            'ratio': {
              'theory': doc.docs[0]['theory'],
              'practical': doc.docs[0]['practical'],
            },
          };
          isLoading = false;
        });
      } else {
        setState(() {
          attendanceDetails = {}; // Clear the data if not found
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching attendance: $e");
    }
  }

  List<String> attendanceOptions = ['First', 'Second', 'Third', 'Fourth'];
  String selectedOption = 'First';
  @override
  void initState() {
    getAttendanceDetails(selectedOption);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 30),
              child: Row(
                children: [
                  const Text(
                    'Select Attendance:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    'Sem:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                          getAttendanceDetails(selectedOption);
                        });
                      },
                      items: attendanceOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              const CircularProgressIndicator() // Show loading indicator
            else if (attendanceDetails.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 30),
                child: Column(children: [
                  Text(
                    "${attendanceDetails['perc']}%",
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            if (!isLoading && attendanceDetails.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircularGraph(
                          innerRadius: 50,
                          value: double.parse(
                              attendanceDetails['ratio']['theory']['present']),
                          total: 100,
                          graphColor: Colors.blue,
                        ),
                        CircularGraph(
                          innerRadius: 70,
                          value: double.parse(attendanceDetails['ratio']
                              ['practical']['present']),
                          total: 100,
                          graphColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Add two cards with text below the graph
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: 350,
                        height: 190,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Theory',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Present - ${attendanceDetails['ratio']['theory']['present']} hrs',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Absent - ${attendanceDetails['ratio']['theory']['absent']} hrs',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: 350,
                        height: 190,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Lab',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Present - ${attendanceDetails['ratio']['practical']['present']} hrs',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Absent - ${attendanceDetails['ratio']['practical']['absent']} hrs',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              )
            else
              const Text("No attendance data found."),
          ],
        ),
      ),
    );
  }
}

class CircularGraph extends StatelessWidget {
  final double value;
  final double total;
  final double innerRadius;
  final Color graphColor;

  const CircularGraph({
    Key? key,
    required this.innerRadius,
    required this.value,
    required this.total,
    required this.graphColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                startDegreeOffset: 270,
                sectionsSpace: 0,
                centerSpaceRadius: innerRadius,
                sections: [
                  PieChartSectionData(
                    color: graphColor,
                    value: value,
                    title: '',
                    radius: 10,
                  ),
                  PieChartSectionData(
                    color: Colors.grey,
                    value: total - value,
                    title: '',
                    radius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Flexible(
          child: Column(
            children: [
              Text("Theory"),
              Text("Practical"),
            ],
          ),
        )
      ],
    );
  }
}
