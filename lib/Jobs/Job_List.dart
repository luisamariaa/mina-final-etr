import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_final_project/Jobs/JobDetail.dart';
import 'package:mad_final_project/Jobs/Post_Job.dart';

class JobListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateJobScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final jobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];

              return ListTile(
                title: Text(job['title']),
                subtitle: Text(job['description']),
                trailing: job['isAvailable']
                    ? Text('Available', style: TextStyle(color: Colors.green))
                    : Text('Not Available',
                        style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailPage(job.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
