import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  ScheduleState createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> {
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final List<List<Map<String, dynamic>>> periods = [
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
    [
      {'Class': 'A', 'time': '9:00 AM - 10:00 AM'},
      {'Class': 'B', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'C', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'D', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Lunch', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'E', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'F', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'Break', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'G', 'time': '10:15 AM - 11:15 AM'},
      {'Class': 'H', 'time': '10:15 AM - 11:15 AM'},
    ],
  ];

  int _selectedDayIndex = DateTime.now().weekday -
      1; // Initialize with the current day index (0 for Monday)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50, // Adjust the height as needed
            child: Row(
              children: days.map((day) {
                final index = days.indexOf(day);
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: _selectedDayIndex == index
                          ? Colors.blue
                          : Colors.grey,
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView(
              children: _selectedDayIndex < periods.length
                  ? periods[_selectedDayIndex]
                      .map((period) => Card(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(period['subject']),
                                  Text(period['time']),
                                ],
                              ),
                            ),
                          ))
                      .toList()
                  : [], // Show an empty list if no day is selected
            ),
          ),
        ],
      ),
    );
  }
}
