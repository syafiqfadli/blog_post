import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ChooseColorCubit extends Cubit<Color> {
  ChooseColorCubit() : super(Colors.purple);

  void setColor(Color value) {
    emit(value);
  }
}
