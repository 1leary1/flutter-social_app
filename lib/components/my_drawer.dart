import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(
                  Icons.people,
                  size: 70,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
        
                const SizedBox(height: 10),
        
                // app name
                const Text(
                  "T H R E A D B O A R D",
                 style: TextStyle(fontSize: 14),
                ),
              ]
            ),
          ),

          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.pop(context);
              }
            ),
          ),

          //profile tile
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text("P R O F I L E"),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/profile_page');
              }
            ),
          ),

          //users tile
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child:ListTile(
              leading: const Icon(Icons.group),
              title: const Text("U S E R S"),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/users_page');
              }
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);

                FirebaseAuth.instance.signOut();
              }
            )
          ),
        ]
      ),
    );
  }
}