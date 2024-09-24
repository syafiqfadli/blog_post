import 'package:blog_post/features/volume_control/presentation/cubit/choose_color_cubit.dart';
import 'package:color_parser/color_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorButton extends StatefulWidget {
  final Color color;

  const ColorButton({super.key, required this.color});

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _chooseColor,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
      ),
      child: Text(ColorParser.color(widget.color).toHex()),
    );
  }

  void _chooseColor() {
    context.read<ChooseColorCubit>().setColor(widget.color);
  }
}
