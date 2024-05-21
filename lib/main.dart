import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/Screens/LoginScreen.dart';
import 'package:mad_final_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(JobAlley());
}

class JobAlley extends StatelessWidget {
  const JobAlley({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       //circular progress indicator
        //       return Scaffold(
        //         body: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       // user is currently signed in
        //       String userId = snapshot.data!.uid;
        //       return EmployeeScreen(userId: userId);
        //     }
        //     return WelcomeScreen();
        //   },
        // ),
        home: LoginScreen(),
        builder: EasyLoading.init(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(foregroundColor: Colors.white),
          useMaterial3: true,
          colorSchemeSeed: Color.fromARGB(255, 22, 1, 54),
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(
            displaySmall: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
