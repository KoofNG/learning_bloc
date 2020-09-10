import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CityInputField extends StatelessWidget {
  final ValueChanged<String> onSubmitted;

  CityInputField({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => onSubmitted(value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
