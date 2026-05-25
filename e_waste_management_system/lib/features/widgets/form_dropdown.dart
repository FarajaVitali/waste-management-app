// lib/widgets/custom_dropdown_field.dart

import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List<T> items;
  final String Function(T item)? itemLabel; // How to display each item
  final void Function(T? newValue)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final bool isRequired;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    this.value,
    this.itemLabel,
    this.onChanged,
    this.validator,
    this.hintText,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        final displayText = itemLabel != null
            ? itemLabel!(item)
            : item.toString();
        return DropdownMenuItem<T>(value: item, child: Text(displayText));
      }).toList(),
      onChanged: onChanged,
      validator:
          validator ??
          (value) {
            if (isRequired && value == null) {
              return "$labelText is required";
            }
            return null;
          },
    );
  }
}
