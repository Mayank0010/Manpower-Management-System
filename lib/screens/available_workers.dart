import 'package:flutter/material.dart';

class AvailableWorkersWidget extends StatelessWidget {
  final List<Map<String, dynamic>> availableWorkers = [
    {'name': 'John Doe', 'occupation': 'Plumber', 'available': true},
    {'name': 'Jane Smith', 'occupation': 'Electrician', 'available': false},
    {'name': 'Bob Johnson', 'occupation': 'Carpenter', 'available': true},
    {'name': 'Mary Williams', 'occupation': 'Painter', 'available': true},
    {'name': 'Tom Brown', 'occupation': 'Handyman', 'available': false},
    {'name': 'Samantha Lee', 'occupation': 'Mover', 'available': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Workers'),
      ),
      body: ListView.builder(
        itemCount: availableWorkers.length,
        itemBuilder: (BuildContext context, int index) {
          final worker = availableWorkers[index];
          return Card(
            child: ListTile(
              title: Text(worker['name']),
              subtitle: Text('${worker['occupation']} - ${worker['available'] ? 'Available' : 'Not Available'}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // navigate to worker details screen
              },
            ),
          );
        },
      ),
    );
  }
}
