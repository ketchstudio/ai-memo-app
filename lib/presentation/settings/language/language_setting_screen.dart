import 'package:flutter/material.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LanguageSetting'),
        leading: BackButton(),
      ),
      body: Center(child: Text("LanguageSettingScreen")),
    );
  }
}
