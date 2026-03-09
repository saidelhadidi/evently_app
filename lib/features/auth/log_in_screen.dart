import 'package:flutter/material.dart';

import '../../core/widgets/header_image.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = "logIn_screen";

  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(title: const HeaderImage()));
  }
}
