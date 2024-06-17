import 'package:bmi_app/bmi_page.dart';
import 'package:bmi_app/feedback_page.dart';
import 'package:bmi_app/recommendations_page.dart';
import 'package:bmi_app/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const BMICalculatorHome(),
        '/feedback': (context) => const FeedbackPage(),
        '/recommendations': (context) => const RecommendationsPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.grey[800]),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orangeAccent),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}
