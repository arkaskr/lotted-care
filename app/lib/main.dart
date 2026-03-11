import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

import 'features/auth/presentation/pages/splash_screen.dart';

void main() {
  runApp(const LottedCareApp());
}

class LottedCareApp extends StatelessWidget {
  const LottedCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotted Care',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
