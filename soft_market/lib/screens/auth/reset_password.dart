import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // ignore: non_constant_identifier_names
  String Email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 44.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Enter Email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      )),
                  onChanged: (value) {
                    Email = value;
                  },
                ),
                const SizedBox(
                  height: 88.0,
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tight(const Size(350, 66)),
                  fillColor: Colors.blue,
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: Email)
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
