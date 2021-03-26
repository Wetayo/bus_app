import 'package:flutter/material.dart';
import 'package:wetayo_bus/components/text_field_container.dart';

class RoundedRouteIdField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedRouteIdField({
    Key key,
    this.hintText,
    this.icon = Icons.directions_bus,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
