import 'package:flutter/material.dart';

class Worker {
  String name;
  String district;
  String occupation;

  Worker({
    required this.name,
    required this.district,
    required this.occupation,
  });
}

class WorkerListScreen extends StatelessWidget {
  final List<Worker> workers = [
    Worker(
      name: 'John Doe',
      district: 'New York',
      occupation: 'Engineer',
    ),
    Worker(
      name: 'Jane Smith',
      district: 'Los Angeles',
      occupation: 'Teacher',
    ),
    Worker(
      name: 'Bob Johnson',
      district: 'Chicago',
      occupation: 'Accountant',
    ),
    Worker(
      name: 'Sarah Lee',
      district: 'Houston',
      occupation: 'Nurse',
    ),
    Worker(
      name: 'Mike Brown',
      district: 'Philadelphia',
      occupation: 'Lawyer',
    ),
    Worker(
      name: 'Karen Davis',
      district: 'Phoenix',
      occupation: 'Developer',
    ),
    Worker(
      name: 'David Wilson',
      district: 'San Antonio',
      occupation: 'Chef',
    ),
    Worker(
      name: 'Lisa Baker',
      district: 'San Diego',
      occupation: 'Designer',
    ),
    Worker(
      name: 'Peter Green',
      district: 'Dallas',
      occupation: 'Salesperson',
    ),
    Worker(
      name: 'Amy Taylor',
      district: 'San Francisco',
      occupation: 'Writer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
        backgroundColor: Color(0xffF89669),
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (BuildContext context, int index) {
          final worker = workers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkerProfileScreen(worker: worker)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  worker.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${worker.district}, ${worker.occupation}',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WorkerProfileScreen extends StatelessWidget {
  final Worker worker;

  WorkerProfileScreen({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(worker.name),
        backgroundColor: Color(0xffF89669),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                worker.name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'District',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                worker.district,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Occupation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                worker.occupation,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}