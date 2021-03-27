import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key key,
    this.menuIcons,
    this.menuItems,
    this.index,
    this.selected,
  }) : super(key: key);

  final String menuIcons;
  final String menuItems;
  final int index;
  final int selected;

  @override
  Widget build(BuildContext context) {
    print('index >> $selected');
    return Container(
      color: selected == index ? Color(0xFFB1F1B26) : Color(0xFFB1F2B36),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('assets/$menuIcons.png'),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              menuItems,
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          )
        ],
      ),
    );
  }
}
