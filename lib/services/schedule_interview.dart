import 'package:flutter/material.dart';

class InterviewSchedule extends StatefulWidget {
  @override
  _InterviewScheduleState createState() => _InterviewScheduleState();
}

class _InterviewScheduleState extends State<InterviewSchedule> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  bool _workerAccepted = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Interview'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Select Interview Date:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : 'Date: ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Select Interview Time:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(
                _selectedTime == null
                    ? 'Select Time'
                    : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Send interview schedule to worker
                if (_selectedDate != null && _selectedTime != null) {
                  String formattedDate =
                      '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
                  String formattedTime =
                      '${_selectedTime!.hour}:${_selectedTime!.minute}';
                  // Code to send the interview schedule to the worker
                  print('Interview scheduled for $formattedDate at $formattedTime');
                }
              },
              child: Text(
                  'Schedule Interview',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          SizedBox(height: 20),
          _selectedDate != null && _selectedTime != null
              ? Center(
            child: ElevatedButton(
              onPressed: () {
                // Code to accept or reject the worker based on the interview
                setState(() {
                  _workerAccepted = true;
                });
              },
              child: Text(
                _workerAccepted ? 'Worker Accepted' : 'Accept Worker',
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      _workerAccepted ? Colors.green : Colors.grey)),

            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
