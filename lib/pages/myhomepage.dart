import 'package:flutter/material.dart';
import './responsive/responsive.dart';
import './responsive/mobilebody.dart';
import './responsive/desktopbody.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
          mobilebody: const MobileBody(), desktopbody: const DesktopBody()),
    );
  }
}
