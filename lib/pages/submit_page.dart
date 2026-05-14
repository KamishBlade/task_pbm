import 'package:flutter/material.dart';

class SubmitPage extends StatelessWidget {
  const SubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Tugas'),
      ),
      body: const Center(
        child: Text('Halaman Submit'),
      ),
    );
  }
}