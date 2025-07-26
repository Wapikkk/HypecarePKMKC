import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Screen')), // AppBar bisa di setiap halaman
      body: const Center(
        child: Text('Selamat datang di halaman Feedback!'),
      ),
    );
  }
}