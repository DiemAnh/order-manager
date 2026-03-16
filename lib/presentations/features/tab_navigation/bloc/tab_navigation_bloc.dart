import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_navigation_event.dart';
part 'tab_navigation_state.dart';
part 'tab_navigation_bloc.freezed.dart';

class TabNavigationBloc extends Bloc<TabNavigationEvent, TabNavigationState> {
  TabNavigationBloc() : super(const TabNavigationState()) {
    on<_ChangeTab>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }
}
