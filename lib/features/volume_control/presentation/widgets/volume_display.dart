import 'package:blog_post/features/volume_control/presentation/cubit/control_volume_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolumeDisplay extends StatefulWidget {
  const VolumeDisplay({super.key});

  @override
  State<VolumeDisplay> createState() => _VolumeDisplayState();
}

class _VolumeDisplayState extends State<VolumeDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlVolumeCubit, double>(
      builder: (context, value) {
        return Text("${(value).toStringAsFixed(0)}%");
      },
    );
  }
}
