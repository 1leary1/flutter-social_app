import 'package:flutter/material.dart';
import 'package:social_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
        centerTitle: true,
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
      ),
      drawer: SafeArea(child: MyDrawer()),
    );
  }
}
