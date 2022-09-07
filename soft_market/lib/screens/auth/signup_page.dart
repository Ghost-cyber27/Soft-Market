import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close Dialog"))
            ],
          );
        });
  }

  //Create a new user
  Future<String?> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail, password: registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exist for that email';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void submitForm() async {
    String? createAccountFeedBack = await createAccount();
    if (createAccountFeedBack != null) {
      _alertDialogBuilder(createAccountFeedBack);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  String registerEmail = "";
  String registerPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 44,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 44,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Enter Email", prefixIcon: Icon(Icons.mail)),
                  onChanged: (value) {
                    registerEmail = value;
                  },
                ),
                const SizedBox(
                  height: 26.0,
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(
                        Icons.lock,
                      )),
                  onChanged: (value) {
                    registerPassword = value;
                  },
                ),
                const SizedBox(
                  height: 44.0,
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tight(const Size(350, 66)),
                  fillColor: Colors.blue,
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    submitForm();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
