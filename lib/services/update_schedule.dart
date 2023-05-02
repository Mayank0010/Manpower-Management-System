
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScheduleUpdate extends StatefulWidget {
  final String name;
  final String occupation;
  final String date;
  final String time;
  final String address;

  ScheduleUpdate({
    required this.name,
    required this.occupation,
    required this.date,
    required this.time,
    required this.address,
  });

  @override
  _ScheduleUpdateState createState() => _ScheduleUpdateState();
}

class _ScheduleUpdateState extends State<ScheduleUpdate> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late User _user = FirebaseAuth.instance.currentUser!;
  late String _userId = _user.uid;
  late DocumentReference _workerDoc;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _workerDoc = _db.collection('schedule_worker').doc(_userId);
    _nameController.text = widget.name;
    _occupationController.text = widget.occupation;
    _timeController.text = widget.time;
    _dateController.text = widget.date;
    _addressController.text = widget.address;
  }

  Future<void> _updateWorkerSchedule() async {
    try {
      await _workerDoc.update({
        'name': _nameController.text,
        'occupation': _occupationController.text,
        'time': _timeController.text,
        'date': _dateController.text,
        'address': _addressController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update schedule: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Schedule'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                'Name',
                controller: _nameController,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Occupation',
                controller: _occupationController,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Time',
                controller: _timeController,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Date',
                controller: _dateController,
              ),
              SizedBox(height: 16),
              _buildTextField(
                'Address',
                controller: _addressController,
              ),
              SizedBox(height: 22),
              Center(
                child: ElevatedButton(
                  onPressed: _updateWorkerSchedule,
                  child: Text('Update Schedule', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
