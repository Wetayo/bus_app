import 'package:flutter/material.dart';
import 'package:wetayo_bus/components/text_field_container.dart';

class RoundedBusNumField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedBusNumField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Bus Number",
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
