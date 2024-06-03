import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.purple[100],
            child: const Text(
              "Praszka aktualnie ",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
