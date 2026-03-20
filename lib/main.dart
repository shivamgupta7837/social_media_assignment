import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/presentation/home_screen.dart';
import 'package:social_media/presentation/screens/splash_screen.dart';
import 'package:social_media/utils/themes/app_colors.dart';
import 'package:social_media/viewmodel/connectivity_provider.dart';
import 'package:social_media/viewmodel/posts_view_model/post_view_model.dart';
import 'package:social_media/viewmodel/reel_view_model/reel_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This helps ignore internal SDK debug logs
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostsProvider()),
        ChangeNotifierProvider(create: (_) => ReelsProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: .fromSeed(seedColor: AppColors.primaryAccent),
      ),
      home: SplashScreen(),
    );
  }
}
