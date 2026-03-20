import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:social_media/models/reels_models.dart';
import 'package:video_player/video_player.dart';
import 'package:social_media/utils/themes/app_typography.dart';
import 'package:social_media/utils/themes/app_colors.dart';

class ReelItem extends StatefulWidget {
  final ListOfReel videoData;
  const ReelItem({super.key, required this.videoData});

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeWithCache();
    // _controller =
    //     VideoPlayerController.networkUrl(
    //         Uri.parse(widget.videoData.videoUrl ?? ""),
    //       )
    //       ..initialize().then((_) {
    //         setState(() => _isInitialized = true);
    //         _controller.setLooping(true);
    //         _controller.play();
    //       });

    // print("_isInitialized: $_isInitialized");
  }

  Future<void> _initializeWithCache() async {
    final url = widget.videoData.videoUrl;

    // 1. Check if the video is already in cache
    final FileInfo? checkCache = await DefaultCacheManager().getFileFromCache(
      url ?? "",
    );

    if (checkCache != null) {
      // Video found in cache! Play from file.
      _controller = VideoPlayerController.file(checkCache.file);
    } else {
      // Video not in cache. Download and cache it.
      final File file = await DefaultCacheManager().getSingleFile(url ?? "");
      _controller = VideoPlayerController.file(file);
    }

    // 2. Initialize the controller
    await _controller.initialize();
    setState(() {
      _isInitialized = true;
    });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_controller.value.isPlaying) {
            setState(() {
              _controller.pause();
            });
          } else {
            setState(() {
              _controller.play();
            });
          }
        },
        child: Stack(
          children: [
            // 1. The Video Player
            _isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),

            Align(
              alignment: Alignment.bottomCenter,

              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,

                      AppColors.background.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Right Side Interaction Bar
            _icons(),
            // 3. Bottom Text Content
            _idAndCaptions(context),
          ],
        ),
      ),
    );
  }

  Positioned _idAndCaptions(BuildContext context) {
    return Positioned(
      left: 15,

      bottom: 60,

      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,

          children: [
            // Username Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(
                      color: AppColors.primaryAccent,
                      width: 1.5,
                    ),
                  ),

                  child: const CircleAvatar(
                    radius: 16,

                    backgroundColor: AppColors.surface,

                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  "@${widget.videoData.username}",

                  style: AppTypography.h4.copyWith(
                    color: AppColors.textPrimary,
                  ), // Using H4 for Username
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Caption
            Text(
              widget.videoData.caption ?? "",

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
              ), // Using Body for Caption
            ),
          ],
        ),
      ),
    );
  }

  Positioned _icons() {
    return Positioned(
      right: 15,

      bottom: 100,

      child: Column(
        children: [
          _buildGlassIconButton(
            Icons.favorite_rounded,
            widget.videoData.likes.toString(),
            iconColor: AppColors.textPrimary,
          ),

          const SizedBox(height: 20),

          _buildGlassIconButton(
            Icons.chat_bubble_rounded,
            widget.videoData.comments.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassIconButton(
    IconData icon,
    String label, {
    Color iconColor = Colors.white,
  }) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

            child: Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: AppColors.glassWhite,

                shape: BoxShape.circle,

                border: Border.all(color: AppColors.glassBorder),
              ),

              child: IconButton(
                onPressed: () async {},
                icon: Icon(icon, color: iconColor, size: 28),
              ),
            ),
          ),
        ),

        if (label.isNotEmpty) ...[
          const SizedBox(height: 6),

          Text(
            label,

            style: AppTypography.label.copyWith(
              color: AppColors.textPrimary,
            ), // Using Label for stats
          ),
        ],
      ],
    );
  }

  Stream<List<ReelModel>> getReelsStream() {
    return FirebaseFirestore.instance
        .collection('reels')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ReelModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
