import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextCubit extends Cubit<bool> {
  ObscureTextCubit({bool initial = true}) : super(initial);

  void toggle() => emit(!state);
  void show() => emit(false);
  void hide() => emit(true);
}