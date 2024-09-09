import 'package:bloc/bloc.dart';

class RowChangedCubit extends Cubit<int> {
  RowChangedCubit() : super(15);

  void setRow(int row) {
    emit(row);
  }
}
