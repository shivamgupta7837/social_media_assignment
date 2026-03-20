import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/posts_model.dart';
import 'package:social_media/models/reels_models.dart';

class ReelsProvider extends ChangeNotifier {
  ReelModel? reelModel;
  bool isLoading = false;
  String? error;

  Future<void> fetchReels() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await FirebaseFirestore.instance
          .collection('reels')
          .doc("zaKe2MVVrBbpuIyRdWRi")
          .get();

      reelModel = ReelModel.fromJson(result.data()!);

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}