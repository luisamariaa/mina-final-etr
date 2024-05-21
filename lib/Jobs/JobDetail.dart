import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobDetailPage extends StatelessWidget {
  final String jobId;

  JobDetailPage(this.jobId);

  Future<void> _applyForJob(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('applications').add({
        'jobId': jobId,
        'applicant': user.email,
        'appliedAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Applied Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('jobs').doc(jobId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final job = snapshot.data!;
          final jobData = job.data() as Map<String, dynamic>?;

          bool isAvailable = false;
          if (jobData != null && jobData.containsKey('isAvailable')) {
            var isAvailableValue = jobData['isAvailable'];
            if (isAvailableValue is bool) {
              isAvailable = isAvailableValue;
            } else if (isAvailableValue is String) {
              isAvailable = isAvailableValue.toLowerCase() == 'true';
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobData != null ? jobData['title'] : 'No title',
                    style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                Text(jobData != null
                    ? jobData['description']
                    : 'No description'),
                SizedBox(height: 10),
                Text(
                    'Posted by: ${jobData != null ? jobData['userId'] : 'Unknown'}'),
                SizedBox(height: 20),
                if (isAvailable)
                  ElevatedButton(
                    onPressed: () => _applyForJob(context),
                    child: Text('Apply for Job'),
                  )
                else
                  Text('This job is no longer available',
                      style: TextStyle(color: Colors.red)),
              ],
            ),
          );
        },
      ),
    );
  }
}
