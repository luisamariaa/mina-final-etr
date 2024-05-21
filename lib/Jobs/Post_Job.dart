import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mad_final_project/Screens/EmployerScreen/Employer_Screen.dart';

class CreateJobScreen extends StatefulWidget {
  CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _jobTitleController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _jobSalary = TextEditingController();
  final _jobLevel = TextEditingController();
  final _jobDuration = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAvailable = false;

  void _postJob() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('jobs').add({
          'title': _jobTitleController.text,
          'description': _jobDescriptionController.text,
          'jobLevel': _jobLevel.text,
          'jobSalary': _jobSalary.text,
          'jobDuration': _jobDuration.text,
          'isAvailable': _isAvailable,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'postedAt': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job Posted Successfully')),
        );
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (_) => EmployerScreen()));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post job')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post a Job')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  controller: _jobTitleController,
                  decoration: InputDecoration(
                      labelText: 'Job Title', border: OutlineInputBorder()),
                ),
                Gap(6),
                TextField(
                  controller: _jobDescriptionController,
                  decoration: InputDecoration(
                      labelText: 'Job Description',
                      border: OutlineInputBorder()),
                  maxLines: 10,
                ),
                Gap(6),
                TextField(
                  controller: _jobLevel,
                  decoration: InputDecoration(
                      labelText: 'Job Level', border: OutlineInputBorder()),
                ),
                Gap(6),
                TextField(
                  controller: _jobSalary,
                  decoration: InputDecoration(
                      labelText: 'Job Salary', border: OutlineInputBorder()),
                ),
                Gap(6),
                TextField(
                  controller: _jobDuration,
                  decoration: InputDecoration(
                      labelText: 'Job Duration', border: OutlineInputBorder()),
                ),
                SwitchListTile(
                  title: Text('Is Available'),
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _postJob();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 60, 3, 107))),
                      child: Text(
                        'POST JOB',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 60, 3, 107),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
