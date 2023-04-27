import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final String time;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
  });
}

class NotificationsPage extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'Service booked',
      description: 'Home cleaning service has been booked',
      time: '10:30 AM',
    ),
    NotificationModel(
      title: 'Service booked',
      description: 'Bathroom cleaning service has been booked',
      time: '12:30 PM',
    ),
    NotificationModel(
      title: 'Product purchased',
      description: 'Order for the new sofa has been placed',
      time: '11:45 AM',
    ),
    NotificationModel(
      title: 'Service booked',
      description: 'Carpenter service has been booked',
      time: '8:30 AM',
    ),
    NotificationModel(
      title: 'Product purchased',
      description: 'Order for the new AC has been placed',
      time: '2:45 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey[100],
                      child: Icon(
                        Icons.notifications,
                        color: Colors.blueGrey,
                      ),
                    ),
                    title: Text(
                      notifications[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        Text(
                          notifications[index].description,
                          style: TextStyle(
                            color: Colors.blueGrey[500],
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          notifications[index].time,
                          style: TextStyle(
                            color: Colors.blueGrey[500],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
