import 'package:flutter/material.dart';

class MainLoadingIndecator extends StatelessWidget {
  const MainLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.orange,
      ),
    );
  }
}
