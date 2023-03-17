import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_register.dart';
import 'package:manpower_management_app/screens/admin_dashboard.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return AdminDashboard();
            } else {
              return AdminRegister();
            }
          }
      ),
    );
  }
}