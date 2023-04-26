import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InterviewSchedule extends StatefulWidget {
  final String name;
  final String occupation;

  InterviewSchedule({required this.name, required this.occupation});

  @override
  _InterviewScheduleState createState() => _InterviewScheduleState();
}

class _InterviewScheduleState extends State<InterviewSchedule> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late String _userId;
  late FirebaseFirestore _db;
  late User _user;

  bool _workerAccepted = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _db = FirebaseFirestore.instance;
    _userId = _user.uid;
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    DocumentSnapshot<Map<String, dynamic>> adminDetail = await _db
        .collection('schedule_worker')
        .doc(_userId)
        .get() as DocumentSnapshot<Map<String, dynamic>>;

    setState(() {
      _addressController.text = adminDetail['address'] ?? '';
      _selectedDate = adminDetail['date'] != null ? DateTime.parse(adminDetail['date']) : null;
      _selectedTime = adminDetail['time'] != null ? TimeOfDay.fromDateTime(DateTime.parse(adminDetail['time'])) : null;
      _dateController.text = _selectedDate != null ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}' : '';
      _timeController.text = _selectedTime != null ? '${_selectedTime!.hour}:${_selectedTime!.minute}' : '';
      _nameController.text = widget.name;
      _occupationController.text = widget.occupation;
    });
  }

  Future<void> saveDetails() async {
    if (_selectedDate != null && _selectedTime != null) {
      String formattedDate =
          '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!
          .day}';
      String formattedTime =
          '${_selectedTime!.hour}:${_selectedTime!.minute}';

      await _db.collection('schedule_worker').doc(_userId).set({
        'name': _nameController.text.trim(),
        'occupation': _occupationController.text.trim(),
        'date': formattedDate,
        'time': formattedTime,
        'address': _addressController.text.trim(),
        'accepted': _workerAccepted,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Interview scheduled.')),
      );
      // Code to send the interview schedule to the worker
      print('Interview scheduled for $formattedDate at $formattedTime');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
        _timeController.text = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Interview'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the details for scheduling the interview:',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.account_box),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _occupationController,
                decoration: InputDecoration(
                  hintText: 'Occupation',
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
                onTap: () {
                  _selectTime(context);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              /*
              SizedBox(height: 16),
              Text(
                'Worker acceptance:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _workerAccepted,
                    onChanged: (value) {
                      setState(() {
                        _workerAccepted = value as bool;
                      });
                    },
                  ),
                  Text('Accepted'),
                  SizedBox(width: 16),
                  Radio(
                    value: false,
                    groupValue: _workerAccepted,
                    onChanged: (value) {
                      setState(() {
                        _workerAccepted = value as bool;
                      });
                    },
                  ),
                  Text('Not Accepted'),
                ],
              ),
              */
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    saveDetails();
                  },
                  child: Text('Schedule Interview', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}