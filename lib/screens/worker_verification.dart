import 'package:flutter/material.dart';
import 'package:manpower_management_app/services/schedule_interview.dart';

class WorkerVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Verification'),
      ),
      body: Column(
        children: <Widget>[
          // List of uploaded documents, images, and videos
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
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Photo ID'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Open photo ID image
                  },
                ),
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
          // Buttons to schedule or reject the worker
          SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Reject worker
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                  ),
                  child: Text('Reject Worker', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Schedule interview
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => InterviewSchedule()
                    ));
                  },
                  child: Text('Schedule Interview', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
