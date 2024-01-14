import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_drawer.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/components/wallpost.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final postTextController = TextEditingController();

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //post message
  void postMessage() {
    // post if is not empty

    if (postTextController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': postTextController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    postTextController.clear();
  }

  //UI
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
      drawer: const SafeArea(child: MyDrawer()),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
        children: [
            const SizedBox(height: 10),

            // post message
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: postTextController),
                ),
                IconButton(
                  onPressed: postMessage,
                  icon: Icon(Icons.arrow_circle_down,
                      size: 30,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ],
            ),

            // wall
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("User Posts")
                      .orderBy("TimeStamp", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            // get message
                            final post = snapshot.data!.docs[index];
                            return WallPost(
                              user: post['UserEmail'],
                              message: post['Message'],
                              postId: post.id,
                              likes: List<String>.from(post['Likes'] ?? []),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
