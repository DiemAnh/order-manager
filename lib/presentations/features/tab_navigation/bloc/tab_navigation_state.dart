part of 'tab_navigation_bloc.dart';

@freezed
abstract class TabNavigationState with _$TabNavigationState {
  const factory TabNavigationState({
    @Default(0) int currentIndex,
  }) = _TabNavigationState;
}