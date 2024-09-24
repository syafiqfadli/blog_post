import 'package:blog_post/features/feature_injection.dart';
import 'package:blog_post/features/volume_control/presentation/cubit/choose_color_cubit.dart';
import 'package:blog_post/features/volume_control/presentation/cubit/control_volume_cubit.dart';
import 'package:blog_post/features/volume_control/presentation/widgets/color_picker.dart';
import 'package:blog_post/features/volume_control/presentation/widgets/volume_knob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolumeControlPage extends StatefulWidget {
  const VolumeControlPage({super.key});

  @override
  State<VolumeControlPage> createState() => _VolumeControlPageState();
}

class _VolumeControlPageState extends State<VolumeControlPage> {
  final ControlVolumeCubit _controlVolumeCubit =
      featureInjection<ControlVolumeCubit>();
  final ChooseColorCubit _chooseColorCubit =
      featureInjection<ChooseColorCubit>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _controlVolumeCubit),
        BlocProvider.value(value: _chooseColorCubit),
      ],
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          height: screenHeight,
          width: screenWidth,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text("Circular Slider"),
              ),
              VolumeKnob(),
              ColorPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
