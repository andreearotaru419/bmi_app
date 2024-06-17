import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  int _currentLength = 0;
  bool _showMaxLengthMessage = false;
  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));

      Flushbar(
        message: 'Feedback sent!',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
      ).show(context);

      _feedbackController.clear();
      _currentLength = 0;
      _showMaxLengthMessage = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _feedbackController.addListener(_updateLength);
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _updateLength() {
    setState(() {
      _currentLength = _feedbackController.text.length;
      if (_currentLength >= 400) {
        _showMaxLengthMessage = true;
      } else {
        _showMaxLengthMessage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.teal,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your feedback:',
                style: TextStyle(
                  color: Colors.teal,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _feedbackController,
                maxLength: 400,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here...',
                  hintStyle: TextStyle(color: Colors.teal.shade200),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  counterText: _showMaxLengthMessage
                      ? 'You have reached the maximum character limit!'
                      : '$_currentLength / 400',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.orangeAccent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                    ),
                  ),
                  child: const Text(
                    'Send feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
