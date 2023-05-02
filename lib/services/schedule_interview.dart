import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/services/update_schedule.dart';

class InterviewSchedule extends StatefulWidget {
  final String name;
  final String occupation;
  final String userId;

  InterviewSchedule({required this.name, required this.occupation, required this.userId});

  @override
  _InterviewScheduleState createState() => _InterviewScheduleState();
}

class _InterviewScheduleState extends State<InterviewSchedule> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late TextEditingController _nameController;
  late TextEditingController _occupationController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late User _user = FirebaseAuth.instance.currentUser!;
  late String _userId  = _user.uid;
  bool _workerAccepted = false;

  @override
  void initState() {
    super.initState();
    _nameController  = TextEditingController(text: widget.name);
    _occupationController = TextEditingController(text: widget.occupation);
    fetchDetails();
  }

  void fetchDetails() async {
    DocumentSnapshot<Map<String, dynamic>> adminDetail = await _db
        .collection('schedule_worker')
        .doc(_userId)
        .get() as DocumentSnapshot<Map<String, dynamic>>;

    setState(() {
      _addressController.text = '';
      _selectedDate = adminDetail['date'] != null ? DateTime.parse(adminDetail['date']) : null;
      _selectedTime = adminDetail['time'] != null ? TimeOfDay.fromDateTime(DateTime.parse(adminDetail['time'])) : null;
      _dateController.text = _selectedDate != null ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}' : '';
      _timeController.text = _selectedTime != null ? '${_selectedTime!.hour}:${_selectedTime!.minute}' : '';
    });
  }

  Future<void> saveDetails() async {
    if (_selectedDate != null && _selectedTime != null) {
      String formattedDate =
          '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!
          .day}';
      String formattedTime =
          '${_selectedTime!.hour}:${_selectedTime!.minute}';

      await _db.collection('schedule_worker').add({
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
              Row(
                children:[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        saveDetails();
                      },
                      child: Text('Schedule Interview', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ScheduleUpdate(
                              name: _nameController.text,
                              occupation: _occupationController.text,
                              date: _dateController.text,
                              time: _timeController.text,
                              address: _addressController.text,
                            )
                        ));
                      },
                      child: Text('Update Schedule', style: TextStyle(color: Colors.white),),
                    ),
                  ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _occupationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}