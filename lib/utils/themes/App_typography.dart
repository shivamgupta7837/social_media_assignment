import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';



class AppTypography {

  // Main Hero Titles (e.g., Onboarding or Profile Names)

  static TextStyle h1 = GoogleFonts.inter(

    fontSize: 28,

    fontWeight: FontWeight.w900,

    color: AppColors.surface,

    letterSpacing: -1.0,

  );



  // Section Headers (e.g., Settings categories)

  static TextStyle h2 = GoogleFonts.inter(

    fontSize: 22,

    fontWeight: FontWeight.w800,

    color: AppColors.surface,

    letterSpacing: -0.5,

  );



  // Video Captions / Subheaders

  static TextStyle h3 = GoogleFonts.inter(

    fontSize: 18,

    fontWeight: FontWeight.w700,

    color: AppColors.surface,

    letterSpacing: -0.2,

  );



  // Large Body Text / Username handles

  static TextStyle h4 = GoogleFonts.inter(

    fontSize: 16,

    fontWeight: FontWeight.w600,

    color: AppColors.surface,

  );



  // Standard Body Text (Captions)

  static TextStyle body = GoogleFonts.inter(

    fontSize: 14,

    fontWeight: FontWeight.w400,

    color: AppColors.surface,

    height: 1.5, // Line height for readability

  );



  // Small UI Elements (Like counts, button labels)

  static TextStyle label = GoogleFonts.inter(

    fontSize: 12,

    fontWeight: FontWeight.w700,

    color: AppColors.surface,

    letterSpacing: 0.5, // Slightly tracked out for clarity at small sizes

  );



  // Tiny metadata (Timestamps, version numbers)

  static TextStyle caption = GoogleFonts.inter(

    fontSize: 10,

    fontWeight: FontWeight.w500,

    color: AppColors.surface,

    letterSpacing: 0.2,

  );
}