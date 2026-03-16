part of 'tab_navigation_bloc.dart';

@freezed
sealed class TabNavigationEvent with _$TabNavigationEvent {
  const factory TabNavigationEvent.changeTab(int index) = _ChangeTab;
}