// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TabNavigationEvent {

 int get index;
/// Create a copy of TabNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabNavigationEventCopyWith<TabNavigationEvent> get copyWith => _$TabNavigationEventCopyWithImpl<TabNavigationEvent>(this as TabNavigationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabNavigationEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'TabNavigationEvent(index: $index)';
}


}

/// @nodoc
abstract mixin class $TabNavigationEventCopyWith<$Res>  {
  factory $TabNavigationEventCopyWith(TabNavigationEvent value, $Res Function(TabNavigationEvent) _then) = _$TabNavigationEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$TabNavigationEventCopyWithImpl<$Res>
    implements $TabNavigationEventCopyWith<$Res> {
  _$TabNavigationEventCopyWithImpl(this._self, this._then);

  final TabNavigationEvent _self;
  final $Res Function(TabNavigationEvent) _then;

/// Create a copy of TabNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TabNavigationEvent].
extension TabNavigationEventPatterns on TabNavigationEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ChangeTab value)?  changeTab,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeTab() when changeTab != null:
return changeTab(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ChangeTab value)  changeTab,}){
final _that = this;
switch (_that) {
case _ChangeTab():
return changeTab(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ChangeTab value)?  changeTab,}){
final _that = this;
switch (_that) {
case _ChangeTab() when changeTab != null:
return changeTab(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int index)?  changeTab,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeTab() when changeTab != null:
return changeTab(_that.index);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int index)  changeTab,}) {final _that = this;
switch (_that) {
case _ChangeTab():
return changeTab(_that.index);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int index)?  changeTab,}) {final _that = this;
switch (_that) {
case _ChangeTab() when changeTab != null:
return changeTab(_that.index);case _:
  return null;

}
}

}

/// @nodoc


class _ChangeTab implements TabNavigationEvent {
  const _ChangeTab(this.index);
  

@override final  int index;

/// Create a copy of TabNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeTabCopyWith<_ChangeTab> get copyWith => __$ChangeTabCopyWithImpl<_ChangeTab>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeTab&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'TabNavigationEvent.changeTab(index: $index)';
}


}

/// @nodoc
abstract mixin class _$ChangeTabCopyWith<$Res> implements $TabNavigationEventCopyWith<$Res> {
  factory _$ChangeTabCopyWith(_ChangeTab value, $Res Function(_ChangeTab) _then) = __$ChangeTabCopyWithImpl;
@override @useResult
$Res call({
 int index
});




}
/// @nodoc
class __$ChangeTabCopyWithImpl<$Res>
    implements _$ChangeTabCopyWith<$Res> {
  __$ChangeTabCopyWithImpl(this._self, this._then);

  final _ChangeTab _self;
  final $Res Function(_ChangeTab) _then;

/// Create a copy of TabNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_ChangeTab(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TabNavigationState {

 int get currentIndex;
/// Create a copy of TabNavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabNavigationStateCopyWith<TabNavigationState> get copyWith => _$TabNavigationStateCopyWithImpl<TabNavigationState>(this as TabNavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabNavigationState&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentIndex);

@override
String toString() {
  return 'TabNavigationState(currentIndex: $currentIndex)';
}


}

/// @nodoc
abstract mixin class $TabNavigationStateCopyWith<$Res>  {
  factory $TabNavigationStateCopyWith(TabNavigationState value, $Res Function(TabNavigationState) _then) = _$TabNavigationStateCopyWithImpl;
@useResult
$Res call({
 int currentIndex
});




}
/// @nodoc
class _$TabNavigationStateCopyWithImpl<$Res>
    implements $TabNavigationStateCopyWith<$Res> {
  _$TabNavigationStateCopyWithImpl(this._self, this._then);

  final TabNavigationState _self;
  final $Res Function(TabNavigationState) _then;

/// Create a copy of TabNavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentIndex = null,}) {
  return _then(_self.copyWith(
currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TabNavigationState].
extension TabNavigationStatePatterns on TabNavigationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabNavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabNavigationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabNavigationState value)  $default,){
final _that = this;
switch (_that) {
case _TabNavigationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabNavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _TabNavigationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabNavigationState() when $default != null:
return $default(_that.currentIndex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentIndex)  $default,) {final _that = this;
switch (_that) {
case _TabNavigationState():
return $default(_that.currentIndex);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentIndex)?  $default,) {final _that = this;
switch (_that) {
case _TabNavigationState() when $default != null:
return $default(_that.currentIndex);case _:
  return null;

}
}

}

/// @nodoc


class _TabNavigationState implements TabNavigationState {
  const _TabNavigationState({this.currentIndex = 0});
  

@override@JsonKey() final  int currentIndex;

/// Create a copy of TabNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabNavigationStateCopyWith<_TabNavigationState> get copyWith => __$TabNavigationStateCopyWithImpl<_TabNavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabNavigationState&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentIndex);

@override
String toString() {
  return 'TabNavigationState(currentIndex: $currentIndex)';
}


}

/// @nodoc
abstract mixin class _$TabNavigationStateCopyWith<$Res> implements $TabNavigationStateCopyWith<$Res> {
  factory _$TabNavigationStateCopyWith(_TabNavigationState value, $Res Function(_TabNavigationState) _then) = __$TabNavigationStateCopyWithImpl;
@override @useResult
$Res call({
 int currentIndex
});




}
/// @nodoc
class __$TabNavigationStateCopyWithImpl<$Res>
    implements _$TabNavigationStateCopyWith<$Res> {
  __$TabNavigationStateCopyWithImpl(this._self, this._then);

  final _TabNavigationState _self;
  final $Res Function(_TabNavigationState) _then;

/// Create a copy of TabNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentIndex = null,}) {
  return _then(_TabNavigationState(
currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
