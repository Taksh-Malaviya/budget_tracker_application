import 'package:flutter/material.dart';

class spending extends StatelessWidget {
  const spending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [Text("All Spending")],
      ),
    );
  }
}
