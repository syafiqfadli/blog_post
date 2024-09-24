import 'package:blog_post/features/volume_control/presentation/widgets/color_button.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColorButton(color: Colors.purple),
          ColorButton(color: Colors.red),
          ColorButton(color: Colors.brown),
        ],
      ),
    );
  }
}
