import 'package:flutter/material.dart';

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
          // Schedule interview button
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Schedule interview
              },
              child: Text('Schedule Interview', style: TextStyle(color: Colors.white)),
            ),
          ),

        ],
      ),
    );
  }
}
