import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadioTile extends StatelessWidget {
  RadioTile({
    required this.titleText,
    required this.value,
    required this.groupValue,
    required this.onchanged,
    super.key,
  });

  String titleText;
  int value;
  List<int?> groupValue = [5,null];
  ValueChanged onchanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text('$titleText'),
      value: value,
      groupValue: groupValue,
      onChanged: onchanged,
    );
  }
}
