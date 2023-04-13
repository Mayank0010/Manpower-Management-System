import 'package:flutter/material.dart';

class Worker {
  String name;
  String area;
  String occupation;
  String profileImage;
  List<String> pastWorks;

  Worker({
    required this.name,
    required this.area,
    required this.occupation,
    required this.profileImage,
    required this.pastWorks,
  });
}

class WorkerListScreen1 extends StatelessWidget {
  final List<Worker> workers = [
    Worker(
      name: 'John Doe',
      area: 'New York',
      occupation: 'Engineer',
      profileImage: 'assets/images/im1.png',
      pastWorks: [
        'Electrician'
      ],
    ),
    Worker(
      name: 'Jane Smith',
      area: 'Los Angeles',
      occupation: 'Teacher',
      profileImage: 'assets/images/im1.png',
      pastWorks: [
        'Painter',
        'Cleaner'
      ],
    ),
    // add more workers here
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
                leading: CircleAvatar(
                  backgroundImage: AssetImage(worker.profileImage),
                ),
                title: Text(
                  worker.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${worker.area}, ${worker.occupation}',
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
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(worker.profileImage),
                ),
              ),
              SizedBox(height: 16),
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
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Area',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                worker.area,
                style: TextStyle(
                  fontSize: 18,
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
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Past Works',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: worker.pastWorks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pastWork = worker.pastWorks[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(pastWork, style: TextStyle(
                        fontSize: 18,
                      ),),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
