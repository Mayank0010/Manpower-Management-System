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
      time: '14:45 PM',
    ),
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notification_important),
            title: Text(notifications[index].title),
            subtitle: Text(notifications[index].description),
            trailing: Text(notifications[index].time),
          );
        },
      ),
    );
  }
}