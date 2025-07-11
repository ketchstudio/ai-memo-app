import 'package:flutter/material.dart';

class CreateFolderScreen extends StatelessWidget {
  const CreateFolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CreateFolder'), leading: BackButton()),
      body: Center(child: Text("CreateFolderScreen")),
    );
  }
}
