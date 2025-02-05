import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: onChanged,
      maxLines: 4,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 253, 247, 254),
        hintText: 'Make description...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 131, 129, 131),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
