import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:mad_final_project/Screens/LoginScreen.dart';
import 'package:mad_final_project/Screens/Register_Employee.dart';
import 'package:mad_final_project/Screens/Register_Employer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void goToLogin() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }

  void goToRegisterEmployee() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => RegisterEmployeeScreen(),
      ),
    );
  }

  void goToRegisterEmployer() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => RegisterEmployerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 223, 176, 231),
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   Color(0xffB81736),
        //   Color(0xff281537),
        // ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Image(
                image: AssetImage('lib/Assets/Images/mad_logo.png'),
                height: 100,
                width: 10,
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 60, 3, 107),
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Gap(30),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const LoginScreen()));
            //   },
            //   child: Container(
            //     height: 53,
            //     width: 320,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       border: Border.all(color: Colors.white),
            //     ),
            //     child: const Center(
            //       child: Text(
            //         'SIGN IN',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            // const Gap(30),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const RegisterScreen()));
            //   },
            //   child: Container(
            //     height: 53,
            //     width: 320,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30),
            //       border: Border.all(color: Colors.white),
            //     ),
            //     child: const Center(
            //       child: Text(
            //         'SIGN UP',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: goToLogin,
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 60, 3, 107),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: OutlinedButton(
                  onPressed: goToRegisterEmployee,
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 2.0, color: Color.fromARGB(255, 60, 3, 107))),
                  child: Text(
                    'REGISTER AS EMPLOYEE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 60, 3, 107),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: OutlinedButton(
                onPressed: goToRegisterEmployer,
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 60, 3, 107))),
                child: Text(
                  'REGISTER AS EMPLOYER',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 60, 3, 107),
                  ),
                ),
              ),
            ),

            // const Spacer(),
            // const Text(
            //   'Login with Social Media',
            //   style: TextStyle(fontSize: 17, color: Colors.white),
            // ), //
            // const Gap(12),
            // const Image(image: AssetImage('assets/social.png'))
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.facebook,
                  color: Color.fromARGB(255, 60, 3, 107),
                ),
                const Gap(10),
                Icon(
                  FontAwesomeIcons.google,
                  color: Color.fromARGB(255, 60, 3, 107),
                ),
                const Gap(10),
                Icon(
                  FontAwesomeIcons.instagram,
                  color: Color.fromARGB(255, 60, 3, 107),
                ),
                const Gap(10),
                Icon(
                  FontAwesomeIcons.linkedin,
                  color: Color.fromARGB(255, 60, 3, 107),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
