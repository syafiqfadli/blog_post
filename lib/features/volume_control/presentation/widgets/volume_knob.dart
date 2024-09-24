import 'package:blog_post/features/volume_control/presentation/cubit/choose_color_cubit.dart';
import 'package:blog_post/features/volume_control/presentation/cubit/control_volume_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class VolumeKnob extends StatefulWidget {
  const VolumeKnob({super.key});

  @override
  State<VolumeKnob> createState() => _VolumeKnobState();
}

class _VolumeKnobState extends State<VolumeKnob> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlVolumeCubit, double>(
      builder: (context, volume) {
        return BlocBuilder<ChooseColorCubit, Color>(
          builder: (context, color) {
            return SleekCircularSlider(
              initialValue: volume,
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  dotColor: Colors.amber,
                  trackColor: Colors.amber,
                  progressBarColor: color,
                ),
              ),
              onChange: _changeVolume,
            );
          },
        );
      },
    );
  }

  void _changeVolume(double value) {
    context.read<ControlVolumeCubit>().setVolume(value);
  }
}
