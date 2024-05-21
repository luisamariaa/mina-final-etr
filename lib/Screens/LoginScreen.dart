import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:mad_final_project/Screens/Employee_Screen/Employee_Screen.dart';
import 'package:mad_final_project/Screens/EmployerScreen/Employer_Screen.dart';
import 'package:mad_final_project/Screens/WelcomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void goToWelcomeScreen() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => WelcomeScreen(),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'Logging in...');
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);

        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login successful!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );

        String userId = userCredential.user!.uid;
        final document = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        var data = document.data()!;
        Widget landing;

        if (data['type'] == 'employee') {
          landing = EmployeeSreen(userId: userId);
        } else {
          landing = EmployerScreen();
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => landing),
        );

        email.clear();
        password.clear();
      } catch (error) {
        EasyLoading.dismiss();
        print('ERROR $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Incorrect Username and/or Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 60, 3, 107),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                left: 22,
              ),
              child: Text(
                'Hello\nLog in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(50),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            )),
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                      ),
                      const Gap(50),
                      GestureDetector(
                        onTap: login,
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color.fromARGB(255, 60, 3, 107),
                          ),
                          child: Center(
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Do not have and account?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: goToWelcomeScreen,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 17, 255)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
