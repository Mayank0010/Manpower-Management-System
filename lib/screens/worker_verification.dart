import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpower_management_app/services/schedule_interview.dart';

class WorkerVerificationPage extends StatefulWidget {
  String name;
  String occupation;

  WorkerVerificationPage({required this.name, required this.occupation});

  @override
  State<WorkerVerificationPage> createState() => _WorkerVerificationPageState();
}

class _WorkerVerificationPageState extends State<WorkerVerificationPage> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('worker_users')
        .where('name', isEqualTo: widget.name)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        userId = snapshot.docs.first.id;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Verification'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16.0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Worker Name:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Occupation:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Text(
                  widget.occupation,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Uploaded Documents, Images, and Videos',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Resume'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Open resume document
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Photo ID'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Open photo ID image
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.receipt),
                  title: Text('Criminal Records'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Open resume document
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.video_collection),
                  title: Text('Introduction Video'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Play introduction video
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // TODO: Reject worker
                      // Push worker details to rejected worker collection
                      final workerData = {
                        'name': widget.name,
                        'occupation': widget.occupation,
                      };
                      await FirebaseFirestore.instance
                          .collection('rejected_workers')
                          .add(workerData);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                    ),
                    child: Text('Reject Worker', style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Schedule interview
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => InterviewSchedule(
                            name: widget.name,
                            occupation: widget.occupation,
                            userId: userId,
                          )
                      ));
                    },
                    child: Text('Schedule Interview', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0,),
        ],
      ),
    );
  }
}
