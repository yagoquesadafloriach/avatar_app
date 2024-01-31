import 'package:avatars_app/avatar_generator/view/avatar_generator_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar App'),
        centerTitle: true,
      ),
      body: const AvatarGeneratorPage(),
    );
  }
}
