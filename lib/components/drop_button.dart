import 'package:flutter/material.dart';

class DropdownButtonFormFieldShowcase extends StatefulWidget {
  const DropdownButtonFormFieldShowcase({
    super.key,
  });

  @override
  State<DropdownButtonFormFieldShowcase> createState() =>
      _DropdownButtonFormFieldShowcaseState();
}

class _DropdownButtonFormFieldShowcaseState
    extends State<DropdownButtonFormFieldShowcase> {
  String selectedItem = '1 DropdownButtonFormField';
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: (String? value) {
              setState(() {
                selectedItem = value ?? '1 DropdownButtonFormField';
              });
            },
            items: <String>[
              '1 DropdownButtonFormField',
              '2 DropdownButtonFormField',
              '3 DropdownButtonFormField',
              '4 DropdownButtonFormField',
              '5 DropdownButtonFormField',
              '6 DropdownButtonFormField',
              '7 DropdownButtonFormField',
              '8 DropdownButtonFormField',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
