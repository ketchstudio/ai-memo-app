import 'package:flutter/material.dart';

class EditMemoScreen extends StatelessWidget {
  const EditMemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EditMemo'), leading: BackButton()),
      body: Center(child: Text("EditMemoScreen")),
    );
  }
}
