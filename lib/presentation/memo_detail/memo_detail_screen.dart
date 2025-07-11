import 'package:flutter/material.dart';

class MemoDetailScreen extends StatelessWidget {
  const MemoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MemoDetail'), leading: BackButton()),
      body: Center(child: Text("MemoDetailScreen")),
    );
  }
}
