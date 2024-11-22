import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_service.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:college_hub/splash/splash.dart';
import 'package:college_hub/login/login.dart';
import 'package:college_hub/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (create) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        if (event == null) {
          loggedIn = false;
        } else {
          loggedIn = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(builder: (context, constraints) {
        SizerUtil.setScreenSize(
            constraints, MediaQuery.of(context).orientation);
        if (loggedIn) {
          return const Dash();
        }
        return const Splash();
      }),
      routes: {
        '/MyLogin': (context) => const MyLogin(),
        '/Dash': (context) => const Dash(),
      },
    );
  }
}
