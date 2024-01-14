import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/like_button.dart';

class WallPost extends StatefulWidget {
  final String user;
  final String message;
  final String postId;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.user,
    required this.message,
    required this.postId,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email) && widget.likes.isNotEmpty;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked){
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
    });
    } else{
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            children: [
              Text(
                widget.user,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.message,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.inverseSurface)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              
              const SizedBox(width: 5),
              
              Text(widget.likes.length.toString(), style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface)),
            ],
          )
        ]),
      ),
    );
  }
}
