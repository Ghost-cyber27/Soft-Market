import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soft_market/screens/auth/reset_password.dart';
import 'package:soft_market/screens/auth/signup_page.dart';
import 'package:soft_market/screens/home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  Future<String?> loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmail, password: loginPassword);

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

  void _submitForm() async {
    String? createAccountFeedBack = await loginAccount();
    if (createAccountFeedBack != null) {
      _alertDialogBuilder(createAccountFeedBack);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  String loginEmail = "";
  String loginPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to Soft-Market",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Login",
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
                    loginEmail = value;
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
                        color: Colors.black,
                      )),
                  onChanged: (value) {
                    loginPassword = value;
                  },
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  "Forgot your password ?",
                  style: TextStyle(color: Colors.blue),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ResetPassword())));
                    }),
                    child: const Text("Forgotten Password")),
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
                    _submitForm();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
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
