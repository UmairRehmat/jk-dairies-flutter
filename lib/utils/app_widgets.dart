import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final error;
  final String label;
  final String hint;
  final bool isSecure;
  final IconData icon;
  final Function onChange;
  final TextInputType inputType;

  const TextInput(
      {@required this.controller,
      this.error,
      this.label,
      this.hint,
      this.isSecure = false,
      this.icon,
      this.onChange,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isSecure,
      onChanged: onChange,
      keyboardType: inputType,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          labelText: label,
          suffixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          errorText: error,
          hintText: hint,
          hintStyle: TextStyle(
            color: Theme.of(context).accentColor,
          )),
    );
  }
}

class SelectionItem extends StatelessWidget {
  final text;
  final isSelected;
  final icon;

  const SelectionItem(
      {Key key, @required this.text, @required this.isSelected, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: new BoxDecoration(
          border: Border.all(
              width: 2, color: isSelected ? kPrimaryColor : Color(0xFFCDD1DE)),
          borderRadius: new BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          text,
          if (icon != null)
            SizedBox(
              width: 15,
            ),
          if (icon != null)
            Icon(
              icon,
              color: isSelected ? kPrimaryColor : Color(0xFFCDD1DE),
            ),
        ],
      ),
    );
  }
}

class divider extends StatelessWidget {
  final color;
  const divider({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
      child: Container(
        height: 2,
        width: double.infinity,
        color: color != null ? color : Color(0xFFD3D3D3),
      ),
    );
  }
}
