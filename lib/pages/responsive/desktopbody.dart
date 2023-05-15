import 'package:flutter/material.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  List bodyitems = <Widget>[
    Text('item1'),
    Text('item2'),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مدیریت چک ها',
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded)),
              ],
            ),
          ),
          leading: Align(
              alignment: Alignment.center, child: Icon(Icons.people_alt_sharp)),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.arrow_circle_up_outlined),
                          label: 'پرداختی'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'خانه'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.arrow_circle_down_outlined),
                          label: 'دریافتی'),
                    ],
                    onTap: (value) => _onItemTapped(value),
                    currentIndex: _selectedIndex,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
