import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const SquizhyApp(),
    ),
  );
}

class SquizhyApp extends StatelessWidget {
  const SquizhyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squizhy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
