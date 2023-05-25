import 'package:flutter/material.dart';

import 'pardakhticontainer.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  List bodyitems = <Widget>[
    PardakhtiContainer(),
    const Text('item2'),
    const Text('item3'),
  ];
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_circle_up_outlined),
                      label: 'پرداختی'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'خانه'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_circle_down_outlined),
                      label: 'دریافتی'),
                ],
                onTap: (value) => setState(() {
                  _onItemTapped(value);
                }),
                currentIndex: selectedIndex,
              ),
            ),
          ],
        ),
        Expanded(child: bodyitems.elementAt(selectedIndex)),
      ],
    );
  }
}
