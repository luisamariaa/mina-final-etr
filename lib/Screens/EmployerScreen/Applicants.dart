import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_final_project/Jobs/JobDetail.dart';

class ApplicantsListScreen extends StatelessWidget {
  const ApplicantsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the page to add a new job/application
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddJobPage()),
              // );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('applications').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final applicant = applications[index];
              bool isAvailable = applicant[
                  'isAvailable']; // Assuming 'isAvailable' is a boolean field

              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(applicant['applicant']),
                      subtitle: Text(applicant['appliedAt']
                          .toDate()
                          .toString()), // Convert Timestamp to Date
                      trailing: isAvailable
                          ? Text('Available', style: TextStyle(color: Colors.green))
                          : Text('Not Available',
                              style: TextStyle(color: Colors.red)),
                    
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(applicant[
                                'jobId']), // Pass the jobId to the JobDetailPage
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
