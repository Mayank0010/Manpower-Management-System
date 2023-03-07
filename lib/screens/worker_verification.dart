import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WorkerVerificationScreen extends StatefulWidget {
  @override
  _WorkerVerificationScreenState createState() =>
      _WorkerVerificationScreenState();
}

class _WorkerVerificationScreenState extends State<WorkerVerificationScreen> {
  File _document;
  File _image;
  File _video;
  String _interviewDate;
  bool _isSubmitting = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickDocument() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        _document = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(minutes: 5),
    );

    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  Future<void> _scheduleInterview() async {
    // Call an API to schedule an interview with the admin
    // You can use a date picker widget or a text input field to get the interview date
    // Once the interview is scheduled, show a confirmation message to the user
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Call an API to submit the form data and the uploaded files
    // Once the submission is completed, show a success message to the user
    // You may also want to navigate to a different screen or pop the current screen from the stack
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Worker Verification'),
    ),
    body: Form(
    key: _formKey,
    child: GridView.count(
    crossAxisCount: 2,
    padding: EdgeInsets.all(16),
    childAspectRatio: 1,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    children: [
    GestureDetector(
    onTap: _pickDocument,
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.grey[300],
    width: 1,
    ),
    ),
    child: _document == null
    ? Icon(Icons.picture_as_pdf,
    size: 72, color: Colors.grey)
        : Image.file(_document, fit: BoxFit.cover),
    ),
    ),
    GestureDetector(
    onTap: _pickImage,
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.grey[300],
    width: 1,
    ),
      child: _image == null
          ? Icon(Icons.image, size: 72, color: Colors.grey)
          : Image.file(_image, fit: BoxFit.cover),
    ),
    ),
      GestureDetector(
        onTap: _pickVideo,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300],
              width: 1,
            ),
          ),
          child: _video == null
              ? Icon(Icons.videocam, size: 72, color: Colors.grey)
              : AspectRatio(
            aspectRatio: 1 / 1,
            child: VideoPlayerWidget(file: _video),
          ),
        ),
      ),
      GestureDetector(
        onTap: _scheduleInterview,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300],
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              'Schedule Interview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      ],
    ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isSubmitting ? null : _submitForm,
        icon: _isSubmitting
            ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        )
            : Icon(Icons.check),
        label: Text('Submit'),
      ),
    );
  }
}
