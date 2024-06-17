import 'package:bmi_app/bottom_navigation.dart';
import 'package:flutter/material.dart';

class BMICalculatorHome extends StatefulWidget {
  const BMICalculatorHome({super.key});

  @override
  _BMICalculatorHomeState createState() => _BMICalculatorHomeState();
}

class _BMICalculatorHomeState extends State<BMICalculatorHome>
    with TickerProviderStateMixin {
  double _height = 1.75;
  double _weight = 70.0;
  double _bmi = 0;
  String _message = "";
  Color _textColor = Colors.black;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void _calculateBMI() {
    if (_height <= 0 || _weight <= 0) {
      setState(() {
        _message = "Please enter valid values!";
        _textColor = Colors.red;
      });
      return;
    }

    setState(() {
      _bmi = _weight / (_height * _height);
      _message = _interpretBMI(_bmi);
      _textColor = _getColorForBMI(_bmi);
    });

    _animationController.forward(from: 0);
  }

  String _interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  Color _getColorForBMI(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 29.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _height = 1.75;
            _weight = 70.0;
            _bmi = 0;
            _message = "";
          });
        },
      ),
      backgroundColor: Colors.teal.shade50,
      bottomNavigationBar:
          NavigationBottomBar(bottomBarController: _tabController),
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Height (m): ${_height.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.teal,
                inactiveTrackColor: Colors.teal.withOpacity(0.3),
                trackHeight: 4.0,
                thumbColor: Colors.orange,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.orange.withOpacity(0.2),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 28.0),
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.teal,
                valueIndicatorTextStyle: const TextStyle(color: Colors.white),
              ),
              child: Slider(
                value: _height,
                min: 1.0,
                max: 2.5,
                divisions: 150,
                label: _height.toStringAsFixed(2),
                onChanged: (double value) {
                  setState(() {
                    _height = value;
                  });
                },
              ),
            ),
            Text(
              'Weight (kg): ${_weight.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 18),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.teal,
                inactiveTrackColor: Colors.teal.withOpacity(0.3),
                trackHeight: 4.0,
                thumbColor: Colors.orange,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.orange.withOpacity(0.2),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 28.0),
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.teal,
                valueIndicatorTextStyle: const TextStyle(color: Colors.white),
              ),
              child: Slider(
                value: _weight,
                min: 30.0,
                max: 150.0,
                divisions: 240,
                label: _weight.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _weight = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.orangeAccent;
                  }
                  return Colors.teal;
                }),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                overlayColor: WidgetStateProperty.all<Color>(
                    Colors.teal.withOpacity(0.5)),
                elevation: WidgetStateProperty.all<double>(8.0),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Text(
                _bmi > 0 ? "Your BMI is ${_bmi.toStringAsFixed(2)}" : '',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 24, color: _textColor),
            ),
          ],
        ),
      ),
    );
  }
}
