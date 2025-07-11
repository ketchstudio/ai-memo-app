import 'package:flutter/material.dart';

class MindMapScreen extends StatelessWidget {
  const MindMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MindMap'), leading: BackButton()),
      body: Center(child: Text("MindMapScreen")),
    );
  }
}
