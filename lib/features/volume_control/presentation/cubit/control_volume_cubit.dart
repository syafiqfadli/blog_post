import 'package:bloc/bloc.dart';

class ControlVolumeCubit extends Cubit<double> {
  ControlVolumeCubit() : super(10);

  void setVolume(double value) {
    emit(value);
  }
}
