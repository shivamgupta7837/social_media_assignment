import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/presentation/screens/reel_video_player.dart';
import 'package:social_media/utils/themes/App_typography.dart';
import 'package:social_media/viewmodel/connectivity_provider.dart';
import 'package:social_media/viewmodel/reel_view_model/reel_view_model.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {

  @override
  void initState() {
    super.initState();

    // 🔥 Fetch reels once
    Future.microtask(() {
      context.read<ReelsProvider>().fetchReels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReelsProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (_) {


          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text("Error: ${provider.error}",
                  style: AppTypography.body),
            );
          }

          if (provider.reelModel == null ||
              provider.reelModel!.listOfReels.isEmpty) {
            return const Center(child: Text("No Reels"));
          }

          final reels = provider.reelModel!.listOfReels;

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            itemBuilder: (context, index) =>
                ReelItem(videoData: reels[index]),
          );
        },
      ),
    );
  }
}