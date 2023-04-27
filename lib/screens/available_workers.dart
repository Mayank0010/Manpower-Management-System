import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpower_management_app/screens/worker_verification.dart';
import 'package:manpower_management_app/services/rejected_workers.dart';
import 'package:manpower_management_app/services/verified_workers.dart';

class AvailableWorkersWidget extends StatefulWidget {
  @override
  _AvailableWorkersWidgetState createState() => _AvailableWorkersWidgetState();
}

class _AvailableWorkersWidgetState extends State<AvailableWorkersWidget> {
  List<Map<String, dynamic>> availableWorkers = [];
  List<Map<String, dynamic>> searchedWorkers = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkers();
  }

  void _fetchWorkers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('worker_users').get();
    List<Map<String, dynamic>> workers = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> worker = {'name': doc['name'], 'occupation': doc['occupation']};
      workers.add(worker);
    });
    setState(() {
      availableWorkers = List.from(workers);
      searchedWorkers = List.from(workers);
    });
  }

  void _filterWorkers(value) {
    setState(() {
      searchedWorkers = availableWorkers
          .where((worker) =>
          worker['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Verified Workers"),
                value: "verified_workers",
              ),
              PopupMenuItem(
                child: Text("Rejected Workers"),
                value: "rejected_workers",
              ),
            ],
            onSelected: (value) {
              if (value == "verified_workers") {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => VerifiedWorkersPage()
                ));

              } else if (value == "rejected_workers") {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => RejectedWorkersPage()
                ));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: 'Search for worker..',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) => _filterWorkers(value),
            ),
          ),
          Expanded(
            child: searchedWorkers.isEmpty
                ? Center(child: Text('No workers found'))
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: searchedWorkers.length,
                itemBuilder: (BuildContext context, int index) {
                  final worker = searchedWorkers[index];
                  return Card(
                    child: ListTile(
                      title: Text(worker['name']),
                      subtitle: Text('${worker['occupation']}'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // navigate to worker details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkerVerificationPage(name: worker['name'],
                              occupation: worker['occupation'],),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}