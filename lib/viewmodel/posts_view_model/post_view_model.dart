import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/posts_model.dart';

class PostsProvider extends ChangeNotifier {
  PostModel? postModel;
  bool isLoading = false;
  String? error;

  Future<void> fetchPosts() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await FirebaseFirestore.instance
          .collection('posts')
          .doc("fAAeY5Ajcoc10pxqao8o")
          .get();

      postModel = PostModel.fromJson(result.data()!);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
