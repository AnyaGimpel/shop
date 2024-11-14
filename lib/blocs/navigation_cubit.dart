import 'package:flutter_bloc/flutter_bloc.dart';

/// A simple navigation cubit to manage the index of the currently selected screen.
class NavigationCubit extends Cubit<int> {
  /// Initializes the navigation state to the first screen (index 0).
  NavigationCubit() : super(0);
  
  /// Sets the current screen by emitting the specified [index].
  void setScreen(int index) => emit(index);
}