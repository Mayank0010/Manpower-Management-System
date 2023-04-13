import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/worker_verification.dart';

class AvailableWorkersWidget extends StatefulWidget {
  @override
  _AvailableWorkersWidgetState createState() => _AvailableWorkersWidgetState();
}

class _AvailableWorkersWidgetState extends State<AvailableWorkersWidget> {
  List<Map<String, dynamic>> availableWorkers = [    {'name': 'John Doe', 'occupation': 'Plumber'},    {'name': 'Jane Smith', 'occupation': 'Electrician'},    {'name': 'Bob Johnson', 'occupation': 'Carpenter'},    {'name': 'Mary Williams', 'occupation': 'Painter'},    {'name': 'Tom Brown', 'occupation': 'Handyman'},    {'name': 'Samantha Lee', 'occupation': 'Cleaner'},  ];

  List<Map<String, dynamic>> searchedWorkers = [];

  @override
  void initState() {
    super.initState();
    searchedWorkers = List.from(availableWorkers);
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
            child: Padding(
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
                            builder: (context) => WorkerVerificationPage(),
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