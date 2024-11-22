import 'package:college_hub/constant.dart';
import 'package:college_hub/Dashboard/result/result_component.dart';
import 'package:college_hub/Dashboard/result/result_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future<void> getUsername() async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(userUid)
          .get();
      setState(() {
        username = userDoc['username'];
      });
    } catch (e) {}
  }

  Future<void> getResults() async {
    try {
      var docs = await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("scores")
          .get();
      List<ResultData> res = [];
      for (var e in docs.docs) {
        print(e.data());
        List data = e.data()['subjects'];
        res.addAll(data.map((e) => ResultData.fromJson(e)));
      }
      setState(() {
        results = res;
      });
    } catch (e) {
      print(e);
    }
  }

  String username = ''; // Store the username
  List<ResultData> results = [];

  @override
  void initState() {
    super.initState();
    getUsername(); // Fetch the username when the widget is initialized
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    int oMarks = results.map((e) => e.obtainedScore).sum.toInt();
    int tMarks = results.map((e) => e.score).sum.toInt();
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              width: 100,
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  foregroundPainter: CircularPainter(
                    backgroundColor: kPrimaryColor,
                    lineColor: kOtherColor,
                    width: 5.w * .5,
                  ),
                  child: Center(
                    child: Text(
                      '$oMarks/$tMarks',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Your Score',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            username, // Display the username dynamically
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16), // Add some spacing
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(kDefaultPadding),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: kDefaultPadding),
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                      boxShadow: const [
                        BoxShadow(
                          color: kTextLightColor,
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              results[index].subject,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${results[index].obtainedScore} /${results[index].score}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: results[index].score.toDouble(),
                                      height: 2.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700],
                                        borderRadius: const BorderRadius.only(
                                          topLeft:
                                              Radius.circular(kDefaultPadding),
                                          bottomRight:
                                              Radius.circular(kDefaultPadding),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 2.h,
                                      width: results[index]
                                          .obtainedScore
                                          .toDouble(),
                                      decoration: BoxDecoration(
                                        color: results[index].grade == 'F'
                                            ? kErrorBorderColor
                                            : kOtherColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft:
                                              Radius.circular(kDefaultPadding),
                                          bottomRight:
                                              Radius.circular(kDefaultPadding),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  results[index].grade,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
