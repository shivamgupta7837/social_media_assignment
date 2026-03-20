import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/presentation/screens/post_screen.dart';
import 'package:social_media/presentation/screens/reel_screen.dart';
import 'package:social_media/utils/themes/App_typography.dart';
import 'package:social_media/utils/themes/app_colors.dart';
import 'package:social_media/viewmodel/connectivity_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Screens to navigate between
  final List<Widget> _screens = [
    const PostScreen(), // Modern Post Feed
     ReelsScreen(), // Your Reels UI
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       extendBody: true, // Crucial for modern floating/translucent bars
      backgroundColor: AppColors.background,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.glassBorder, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.background.withOpacity(0.8), // Blurred effect
          selectedItemColor: AppColors.primaryAccent,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: AppTypography.label,
          unselectedLabelStyle: AppTypography.label.copyWith(fontSize: 10),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Posts"),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline_rounded), label: "Reels"),
          ],
          onTap: (index) {
            _pageController.animateToPage(index, 
                duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          },
        ),
      ),
    );
  }
}