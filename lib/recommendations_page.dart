import 'package:bmi_app/bottom_navigation.dart';
import 'package:flutter/material.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({super.key});

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          NavigationBottomBar(bottomBarController: _tabController),
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text(
          'BMI Recommendations',
          style: TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecommendationCard(
              'Underweight',
              'Try to consume more calories to increase your body weight.',
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              'Normal Weight',
              'Maintain a balanced diet and continue regular physical exercises.',
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              'Overweight',
              'Reduce calorie intake and increase physical activity to lose weight.',
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              'Obesity',
              'Consult a healthcare professional to develop a personalized weight loss plan.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String recommendation) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendation,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
