import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mad_final_project/Jobs/JobDetail.dart';
import 'package:mad_final_project/Jobs/Job_List.dart';
import 'package:mad_final_project/Jobs/Post_Job.dart';
import 'package:mad_final_project/Screens/EmployerScreen/Applicants.dart';
import 'package:mad_final_project/Screens/EmployerScreen/EmployerProfile.dart';
import 'package:mad_final_project/Screens/EmployerScreen/MarkedApplicants.dart';

class EmployerScreen extends StatefulWidget {
  const EmployerScreen({super.key});

  @override
  State<EmployerScreen> createState() => _EmployerScreenState();
}

class _EmployerScreenState extends State<EmployerScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // JobDetailPage(jobId),
    JobListPage(),
    MarkedApplicants(),
    CreateJobScreen(),
    EmployerProfile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 60, 3, 107),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 223, 176, 231),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 223, 176, 231),
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 223, 176, 231),
            icon: Icon(FontAwesomeIcons.checkDouble),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 223, 176, 231),
            icon: Icon(
              FontAwesomeIcons.userCheck,
            ),
            label: 'Applicants',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 223, 176, 231),
            icon: Icon(Icons.add_card),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 223, 176, 231),
            icon: Icon(FontAwesomeIcons.userPen),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 60, 3, 107),
        onTap: _onItemTapped,
      ),
    );
  }
}
