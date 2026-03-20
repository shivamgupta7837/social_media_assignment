import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/posts_model.dart';
import 'package:social_media/utils/themes/App_typography.dart';
import 'package:social_media/utils/themes/app_colors.dart';
import 'package:social_media/viewmodel/posts_view_model/post_view_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState() {
    super.initState();

    // fetch data once
    Future.microtask(() {
      context.read<PostsProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Feed", style: AppTypography.h2),
      ),
      body: Builder(
        builder: (_) {

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text("Error: ${provider.error}"),
            );
          }

          if (provider.postModel == null ||
              provider.postModel!.listOfPosts.isEmpty) {
            return const Center(child: Text("No Posts"));
          }

          final posts = provider.postModel!.listOfPosts;

          return ListView.builder(
            itemCount: posts.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) =>
                PostItem(listofPost: posts[index]),
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final ListOfPost listofPost;
  const PostItem({super.key, required this.listofPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Username
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.surface,
                  backgroundImage:
                      listofPost.userImage != null &&
                          listofPost.userImage!.isNotEmpty
                      ? NetworkImage(listofPost.userImage!)
                      : null,
                ),
                const SizedBox(width: 12),
                Text("${listofPost.username}", style: AppTypography.h4),
                const Spacer(),
                Icon(Icons.more_horiz, color: AppColors.textMuted),
              ],
            ),
          ),

          // Post Content (Image Placeholder)
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // Modern rounded corners
            ),
            child: Image.network(listofPost.mediaUrl ?? ""),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border, color: AppColors.surface),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.surface,
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () async {
                      
                      },
                      icon: Icon(Icons.send_outlined, color: AppColors.surface),
                    ),
                    const Spacer(),
                    const Icon(Icons.bookmark_border, color: AppColors.surface),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "${listofPost.likesCount} Likes",
                  style: AppTypography.label,
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: AppTypography.body,
                    children: [
                      TextSpan(
                        text: "${listofPost.username} ",
                        style: AppTypography.h4.copyWith(fontSize: 14),
                      ),
                      TextSpan(text: "${listofPost.caption}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
adding posts
 await FirebaseFirestore.instance.collection('posts').doc("fAAeY5Ajcoc10pxqao8o").update({
                            "listOfPost": FieldValue.arrayUnion([
                              {
                                "postId": 10,
                                "userId": "traveler_01",
                                "username": "Shivam",
                                "userImage":
                                    "https://images.pexels.com/photos/2245436/pexels-photo-2245436.png",
                                "mediaUrl":
                                    "https://images.pexels.com/photos/10415856/pexels-photo-10415856.jpeg",
                                "caption": "Exploring mountains 🏔️",
                                "likesCount": "1200",
                              },
                              {
                                "postId": 2,
                                "userId": "foodie_02",
                                "username": "Aman",
                                "userImage":
                                    "https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fHww",
                                "mediaUrl": "https://picsum.photos/500?2",
                                "caption": "Delicious food 😋",
                                "likesCount": "5400",
                              },
*/


/*

   await FirebaseFirestore.instance
                              .collection('reels')
                              .doc(
                                "zaKe2MVVrBbpuIyRdWRi",
                              ) // 👈 replace with your actual doc id
                              .update({
                                "liostOfReels": FieldValue.arrayUnion( [
  {
    "reelId": 1,
    "username": "shivam",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Nature vibes 🐝",
    "likes": "1200",
    "comments": "150",
  },
  {
    "reelId": 2,
    "username": "aman",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Morning energy 🌅",
    "likes": "3400",
    "comments": "320",
  },
  {
    "reelId": 3,
    "username": "riya",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Peaceful moments 🌿",
    "likes": "2100",
    "comments": "180",
  },
  {
    "reelId": 4,
    "username": "rahul",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Chill time 😎",
    "likes": "5000",
    "comments": "600",
  },
  {
    "reelId": 5,
    "username": "neha",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Workout done 💪",
    "likes": "2800",
    "comments": "250",
  },
  {
    "reelId": 6,
    "username": "kabir",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Art life 🎨",
    "likes": "1700",
    "comments": "140",
  },
  {
    "reelId": 7,
    "username": "simran",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Travel diaries ✈️",
    "likes": "6200",
    "comments": "700",
  },
  {
    "reelId": 8,
    "username": "arjun",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Music vibes 🎵",
    "likes": "3100",
    "comments": "290",
  },
  {
    "reelId": 9,
    "username": "pooja",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Daily life ✨",
    "likes": "900",
    "comments": "80",
  },
  {
    "reelId": 10,
    "username": "vikas",
    "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "caption": "Adventure time 🚀",
    "likes": "4500",
    "comments": "520",
  }
]),
                              });


                              

*/