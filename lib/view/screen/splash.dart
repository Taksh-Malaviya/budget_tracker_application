import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network("https://tse1.mm.bing.net/th?id=OIP.9C_Ii0vbuMvGC02OJOs8igAAAA&pid=Api&P=0&h=180"),
      ),
    );
  }
}
