import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilebody;
  final Widget desktopbody;

  ResponsiveLayout({required this.mobilebody, required this.desktopbody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 451) {
          return mobilebody;
        } else {
          return desktopbody;
        }
      },
    );
  }
}
