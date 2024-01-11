import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_button.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void register() async {
    // show loading
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // passwirds match
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);

      displayMessageToUser("Passwords dont match!", context);
    }

    // try creating the user
    else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.people,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            // app name
            const Text(
              "T H R E A D B O A R D",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 50),

            // username textfield
            MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController),

            const SizedBox(height: 10),

            // email textfield
            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),

            const SizedBox(height: 10),

            // password textfield
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController),

            const SizedBox(height: 10),

            // confirm password textfield
            MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController),

            const SizedBox(height: 25),

            // sign in button
            MyButton(
              text: "Register",
              onTap: register,
            ),

            const SizedBox(height: 25),

            // don't have account?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "Login Here",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
