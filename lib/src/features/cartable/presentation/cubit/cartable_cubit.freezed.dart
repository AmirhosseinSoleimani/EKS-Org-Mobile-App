// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cartable_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartableStateData {

 SubordinatedUserEntity? get activeCartableUser; String? get activeCartableUserRoleTitle; SubordinatedUserEntity? get subordinatedUsersRoot; List<SubordinatedUserEntity> get subordinatedUsersTree; List<SubordinatedUserEntity> get filteredSubordinatedUsersTree; List<CartableItemEntity> get cartableItems; List<CartableItemEntity> get filteredCartableItems; String get cartableSearchText; String get subordinatedUserSearchText; bool get isSubordinatedUsersLoading; bool get isCartableItemsLoading; int get pageSize; bool? get includeSnoozedMessages;
/// Create a copy of CartableStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<CartableStateData> get copyWith => _$CartableStateDataCopyWithImpl<CartableStateData>(this as CartableStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartableStateData&&(identical(other.activeCartableUser, activeCartableUser) || other.activeCartableUser == activeCartableUser)&&(identical(other.activeCartableUserRoleTitle, activeCartableUserRoleTitle) || other.activeCartableUserRoleTitle == activeCartableUserRoleTitle)&&(identical(other.subordinatedUsersRoot, subordinatedUsersRoot) || other.subordinatedUsersRoot == subordinatedUsersRoot)&&const DeepCollectionEquality().equals(other.subordinatedUsersTree, subordinatedUsersTree)&&const DeepCollectionEquality().equals(other.filteredSubordinatedUsersTree, filteredSubordinatedUsersTree)&&const DeepCollectionEquality().equals(other.cartableItems, cartableItems)&&const DeepCollectionEquality().equals(other.filteredCartableItems, filteredCartableItems)&&(identical(other.cartableSearchText, cartableSearchText) || other.cartableSearchText == cartableSearchText)&&(identical(other.subordinatedUserSearchText, subordinatedUserSearchText) || other.subordinatedUserSearchText == subordinatedUserSearchText)&&(identical(other.isSubordinatedUsersLoading, isSubordinatedUsersLoading) || other.isSubordinatedUsersLoading == isSubordinatedUsersLoading)&&(identical(other.isCartableItemsLoading, isCartableItemsLoading) || other.isCartableItemsLoading == isCartableItemsLoading)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.includeSnoozedMessages, includeSnoozedMessages) || other.includeSnoozedMessages == includeSnoozedMessages));
}


@override
int get hashCode => Object.hash(runtimeType,activeCartableUser,activeCartableUserRoleTitle,subordinatedUsersRoot,const DeepCollectionEquality().hash(subordinatedUsersTree),const DeepCollectionEquality().hash(filteredSubordinatedUsersTree),const DeepCollectionEquality().hash(cartableItems),const DeepCollectionEquality().hash(filteredCartableItems),cartableSearchText,subordinatedUserSearchText,isSubordinatedUsersLoading,isCartableItemsLoading,pageSize,includeSnoozedMessages);

@override
String toString() {
  return 'CartableStateData(activeCartableUser: $activeCartableUser, activeCartableUserRoleTitle: $activeCartableUserRoleTitle, subordinatedUsersRoot: $subordinatedUsersRoot, subordinatedUsersTree: $subordinatedUsersTree, filteredSubordinatedUsersTree: $filteredSubordinatedUsersTree, cartableItems: $cartableItems, filteredCartableItems: $filteredCartableItems, cartableSearchText: $cartableSearchText, subordinatedUserSearchText: $subordinatedUserSearchText, isSubordinatedUsersLoading: $isSubordinatedUsersLoading, isCartableItemsLoading: $isCartableItemsLoading, pageSize: $pageSize, includeSnoozedMessages: $includeSnoozedMessages)';
}


}

/// @nodoc
abstract mixin class $CartableStateDataCopyWith<$Res>  {
  factory $CartableStateDataCopyWith(CartableStateData value, $Res Function(CartableStateData) _then) = _$CartableStateDataCopyWithImpl;
@useResult
$Res call({
 SubordinatedUserEntity? activeCartableUser, String? activeCartableUserRoleTitle, SubordinatedUserEntity? subordinatedUsersRoot, List<SubordinatedUserEntity> subordinatedUsersTree, List<SubordinatedUserEntity> filteredSubordinatedUsersTree, List<CartableItemEntity> cartableItems, List<CartableItemEntity> filteredCartableItems, String cartableSearchText, String subordinatedUserSearchText, bool isSubordinatedUsersLoading, bool isCartableItemsLoading, int pageSize, bool? includeSnoozedMessages
});




}
/// @nodoc
class _$CartableStateDataCopyWithImpl<$Res>
    implements $CartableStateDataCopyWith<$Res> {
  _$CartableStateDataCopyWithImpl(this._self, this._then);

  final CartableStateData _self;
  final $Res Function(CartableStateData) _then;

/// Create a copy of CartableStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeCartableUser = freezed,Object? activeCartableUserRoleTitle = freezed,Object? subordinatedUsersRoot = freezed,Object? subordinatedUsersTree = null,Object? filteredSubordinatedUsersTree = null,Object? cartableItems = null,Object? filteredCartableItems = null,Object? cartableSearchText = null,Object? subordinatedUserSearchText = null,Object? isSubordinatedUsersLoading = null,Object? isCartableItemsLoading = null,Object? pageSize = null,Object? includeSnoozedMessages = freezed,}) {
  return _then(_self.copyWith(
activeCartableUser: freezed == activeCartableUser ? _self.activeCartableUser : activeCartableUser // ignore: cast_nullable_to_non_nullable
as SubordinatedUserEntity?,activeCartableUserRoleTitle: freezed == activeCartableUserRoleTitle ? _self.activeCartableUserRoleTitle : activeCartableUserRoleTitle // ignore: cast_nullable_to_non_nullable
as String?,subordinatedUsersRoot: freezed == subordinatedUsersRoot ? _self.subordinatedUsersRoot : subordinatedUsersRoot // ignore: cast_nullable_to_non_nullable
as SubordinatedUserEntity?,subordinatedUsersTree: null == subordinatedUsersTree ? _self.subordinatedUsersTree : subordinatedUsersTree // ignore: cast_nullable_to_non_nullable
as List<SubordinatedUserEntity>,filteredSubordinatedUsersTree: null == filteredSubordinatedUsersTree ? _self.filteredSubordinatedUsersTree : filteredSubordinatedUsersTree // ignore: cast_nullable_to_non_nullable
as List<SubordinatedUserEntity>,cartableItems: null == cartableItems ? _self.cartableItems : cartableItems // ignore: cast_nullable_to_non_nullable
as List<CartableItemEntity>,filteredCartableItems: null == filteredCartableItems ? _self.filteredCartableItems : filteredCartableItems // ignore: cast_nullable_to_non_nullable
as List<CartableItemEntity>,cartableSearchText: null == cartableSearchText ? _self.cartableSearchText : cartableSearchText // ignore: cast_nullable_to_non_nullable
as String,subordinatedUserSearchText: null == subordinatedUserSearchText ? _self.subordinatedUserSearchText : subordinatedUserSearchText // ignore: cast_nullable_to_non_nullable
as String,isSubordinatedUsersLoading: null == isSubordinatedUsersLoading ? _self.isSubordinatedUsersLoading : isSubordinatedUsersLoading // ignore: cast_nullable_to_non_nullable
as bool,isCartableItemsLoading: null == isCartableItemsLoading ? _self.isCartableItemsLoading : isCartableItemsLoading // ignore: cast_nullable_to_non_nullable
as bool,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,includeSnoozedMessages: freezed == includeSnoozedMessages ? _self.includeSnoozedMessages : includeSnoozedMessages // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartableStateData].
extension CartableStateDataPatterns on CartableStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartableStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartableStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartableStateData value)  $default,){
final _that = this;
switch (_that) {
case _CartableStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartableStateData value)?  $default,){
final _that = this;
switch (_that) {
case _CartableStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubordinatedUserEntity? activeCartableUser,  String? activeCartableUserRoleTitle,  SubordinatedUserEntity? subordinatedUsersRoot,  List<SubordinatedUserEntity> subordinatedUsersTree,  List<SubordinatedUserEntity> filteredSubordinatedUsersTree,  List<CartableItemEntity> cartableItems,  List<CartableItemEntity> filteredCartableItems,  String cartableSearchText,  String subordinatedUserSearchText,  bool isSubordinatedUsersLoading,  bool isCartableItemsLoading,  int pageSize,  bool? includeSnoozedMessages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartableStateData() when $default != null:
return $default(_that.activeCartableUser,_that.activeCartableUserRoleTitle,_that.subordinatedUsersRoot,_that.subordinatedUsersTree,_that.filteredSubordinatedUsersTree,_that.cartableItems,_that.filteredCartableItems,_that.cartableSearchText,_that.subordinatedUserSearchText,_that.isSubordinatedUsersLoading,_that.isCartableItemsLoading,_that.pageSize,_that.includeSnoozedMessages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubordinatedUserEntity? activeCartableUser,  String? activeCartableUserRoleTitle,  SubordinatedUserEntity? subordinatedUsersRoot,  List<SubordinatedUserEntity> subordinatedUsersTree,  List<SubordinatedUserEntity> filteredSubordinatedUsersTree,  List<CartableItemEntity> cartableItems,  List<CartableItemEntity> filteredCartableItems,  String cartableSearchText,  String subordinatedUserSearchText,  bool isSubordinatedUsersLoading,  bool isCartableItemsLoading,  int pageSize,  bool? includeSnoozedMessages)  $default,) {final _that = this;
switch (_that) {
case _CartableStateData():
return $default(_that.activeCartableUser,_that.activeCartableUserRoleTitle,_that.subordinatedUsersRoot,_that.subordinatedUsersTree,_that.filteredSubordinatedUsersTree,_that.cartableItems,_that.filteredCartableItems,_that.cartableSearchText,_that.subordinatedUserSearchText,_that.isSubordinatedUsersLoading,_that.isCartableItemsLoading,_that.pageSize,_that.includeSnoozedMessages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubordinatedUserEntity? activeCartableUser,  String? activeCartableUserRoleTitle,  SubordinatedUserEntity? subordinatedUsersRoot,  List<SubordinatedUserEntity> subordinatedUsersTree,  List<SubordinatedUserEntity> filteredSubordinatedUsersTree,  List<CartableItemEntity> cartableItems,  List<CartableItemEntity> filteredCartableItems,  String cartableSearchText,  String subordinatedUserSearchText,  bool isSubordinatedUsersLoading,  bool isCartableItemsLoading,  int pageSize,  bool? includeSnoozedMessages)?  $default,) {final _that = this;
switch (_that) {
case _CartableStateData() when $default != null:
return $default(_that.activeCartableUser,_that.activeCartableUserRoleTitle,_that.subordinatedUsersRoot,_that.subordinatedUsersTree,_that.filteredSubordinatedUsersTree,_that.cartableItems,_that.filteredCartableItems,_that.cartableSearchText,_that.subordinatedUserSearchText,_that.isSubordinatedUsersLoading,_that.isCartableItemsLoading,_that.pageSize,_that.includeSnoozedMessages);case _:
  return null;

}
}

}

/// @nodoc


class _CartableStateData implements CartableStateData {
  const _CartableStateData({this.activeCartableUser, this.activeCartableUserRoleTitle, this.subordinatedUsersRoot, final  List<SubordinatedUserEntity> subordinatedUsersTree = const [], final  List<SubordinatedUserEntity> filteredSubordinatedUsersTree = const [], final  List<CartableItemEntity> cartableItems = const [], final  List<CartableItemEntity> filteredCartableItems = const [], this.cartableSearchText = '', this.subordinatedUserSearchText = '', this.isSubordinatedUsersLoading = false, this.isCartableItemsLoading = false, this.pageSize = 100, this.includeSnoozedMessages}): _subordinatedUsersTree = subordinatedUsersTree,_filteredSubordinatedUsersTree = filteredSubordinatedUsersTree,_cartableItems = cartableItems,_filteredCartableItems = filteredCartableItems;
  

@override final  SubordinatedUserEntity? activeCartableUser;
@override final  String? activeCartableUserRoleTitle;
@override final  SubordinatedUserEntity? subordinatedUsersRoot;
 final  List<SubordinatedUserEntity> _subordinatedUsersTree;
@override@JsonKey() List<SubordinatedUserEntity> get subordinatedUsersTree {
  if (_subordinatedUsersTree is EqualUnmodifiableListView) return _subordinatedUsersTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subordinatedUsersTree);
}

 final  List<SubordinatedUserEntity> _filteredSubordinatedUsersTree;
@override@JsonKey() List<SubordinatedUserEntity> get filteredSubordinatedUsersTree {
  if (_filteredSubordinatedUsersTree is EqualUnmodifiableListView) return _filteredSubordinatedUsersTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredSubordinatedUsersTree);
}

 final  List<CartableItemEntity> _cartableItems;
@override@JsonKey() List<CartableItemEntity> get cartableItems {
  if (_cartableItems is EqualUnmodifiableListView) return _cartableItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cartableItems);
}

 final  List<CartableItemEntity> _filteredCartableItems;
@override@JsonKey() List<CartableItemEntity> get filteredCartableItems {
  if (_filteredCartableItems is EqualUnmodifiableListView) return _filteredCartableItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCartableItems);
}

@override@JsonKey() final  String cartableSearchText;
@override@JsonKey() final  String subordinatedUserSearchText;
@override@JsonKey() final  bool isSubordinatedUsersLoading;
@override@JsonKey() final  bool isCartableItemsLoading;
@override@JsonKey() final  int pageSize;
@override final  bool? includeSnoozedMessages;

/// Create a copy of CartableStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartableStateDataCopyWith<_CartableStateData> get copyWith => __$CartableStateDataCopyWithImpl<_CartableStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartableStateData&&(identical(other.activeCartableUser, activeCartableUser) || other.activeCartableUser == activeCartableUser)&&(identical(other.activeCartableUserRoleTitle, activeCartableUserRoleTitle) || other.activeCartableUserRoleTitle == activeCartableUserRoleTitle)&&(identical(other.subordinatedUsersRoot, subordinatedUsersRoot) || other.subordinatedUsersRoot == subordinatedUsersRoot)&&const DeepCollectionEquality().equals(other._subordinatedUsersTree, _subordinatedUsersTree)&&const DeepCollectionEquality().equals(other._filteredSubordinatedUsersTree, _filteredSubordinatedUsersTree)&&const DeepCollectionEquality().equals(other._cartableItems, _cartableItems)&&const DeepCollectionEquality().equals(other._filteredCartableItems, _filteredCartableItems)&&(identical(other.cartableSearchText, cartableSearchText) || other.cartableSearchText == cartableSearchText)&&(identical(other.subordinatedUserSearchText, subordinatedUserSearchText) || other.subordinatedUserSearchText == subordinatedUserSearchText)&&(identical(other.isSubordinatedUsersLoading, isSubordinatedUsersLoading) || other.isSubordinatedUsersLoading == isSubordinatedUsersLoading)&&(identical(other.isCartableItemsLoading, isCartableItemsLoading) || other.isCartableItemsLoading == isCartableItemsLoading)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.includeSnoozedMessages, includeSnoozedMessages) || other.includeSnoozedMessages == includeSnoozedMessages));
}


@override
int get hashCode => Object.hash(runtimeType,activeCartableUser,activeCartableUserRoleTitle,subordinatedUsersRoot,const DeepCollectionEquality().hash(_subordinatedUsersTree),const DeepCollectionEquality().hash(_filteredSubordinatedUsersTree),const DeepCollectionEquality().hash(_cartableItems),const DeepCollectionEquality().hash(_filteredCartableItems),cartableSearchText,subordinatedUserSearchText,isSubordinatedUsersLoading,isCartableItemsLoading,pageSize,includeSnoozedMessages);

@override
String toString() {
  return 'CartableStateData(activeCartableUser: $activeCartableUser, activeCartableUserRoleTitle: $activeCartableUserRoleTitle, subordinatedUsersRoot: $subordinatedUsersRoot, subordinatedUsersTree: $subordinatedUsersTree, filteredSubordinatedUsersTree: $filteredSubordinatedUsersTree, cartableItems: $cartableItems, filteredCartableItems: $filteredCartableItems, cartableSearchText: $cartableSearchText, subordinatedUserSearchText: $subordinatedUserSearchText, isSubordinatedUsersLoading: $isSubordinatedUsersLoading, isCartableItemsLoading: $isCartableItemsLoading, pageSize: $pageSize, includeSnoozedMessages: $includeSnoozedMessages)';
}


}

/// @nodoc
abstract mixin class _$CartableStateDataCopyWith<$Res> implements $CartableStateDataCopyWith<$Res> {
  factory _$CartableStateDataCopyWith(_CartableStateData value, $Res Function(_CartableStateData) _then) = __$CartableStateDataCopyWithImpl;
@override @useResult
$Res call({
 SubordinatedUserEntity? activeCartableUser, String? activeCartableUserRoleTitle, SubordinatedUserEntity? subordinatedUsersRoot, List<SubordinatedUserEntity> subordinatedUsersTree, List<SubordinatedUserEntity> filteredSubordinatedUsersTree, List<CartableItemEntity> cartableItems, List<CartableItemEntity> filteredCartableItems, String cartableSearchText, String subordinatedUserSearchText, bool isSubordinatedUsersLoading, bool isCartableItemsLoading, int pageSize, bool? includeSnoozedMessages
});




}
/// @nodoc
class __$CartableStateDataCopyWithImpl<$Res>
    implements _$CartableStateDataCopyWith<$Res> {
  __$CartableStateDataCopyWithImpl(this._self, this._then);

  final _CartableStateData _self;
  final $Res Function(_CartableStateData) _then;

/// Create a copy of CartableStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeCartableUser = freezed,Object? activeCartableUserRoleTitle = freezed,Object? subordinatedUsersRoot = freezed,Object? subordinatedUsersTree = null,Object? filteredSubordinatedUsersTree = null,Object? cartableItems = null,Object? filteredCartableItems = null,Object? cartableSearchText = null,Object? subordinatedUserSearchText = null,Object? isSubordinatedUsersLoading = null,Object? isCartableItemsLoading = null,Object? pageSize = null,Object? includeSnoozedMessages = freezed,}) {
  return _then(_CartableStateData(
activeCartableUser: freezed == activeCartableUser ? _self.activeCartableUser : activeCartableUser // ignore: cast_nullable_to_non_nullable
as SubordinatedUserEntity?,activeCartableUserRoleTitle: freezed == activeCartableUserRoleTitle ? _self.activeCartableUserRoleTitle : activeCartableUserRoleTitle // ignore: cast_nullable_to_non_nullable
as String?,subordinatedUsersRoot: freezed == subordinatedUsersRoot ? _self.subordinatedUsersRoot : subordinatedUsersRoot // ignore: cast_nullable_to_non_nullable
as SubordinatedUserEntity?,subordinatedUsersTree: null == subordinatedUsersTree ? _self._subordinatedUsersTree : subordinatedUsersTree // ignore: cast_nullable_to_non_nullable
as List<SubordinatedUserEntity>,filteredSubordinatedUsersTree: null == filteredSubordinatedUsersTree ? _self._filteredSubordinatedUsersTree : filteredSubordinatedUsersTree // ignore: cast_nullable_to_non_nullable
as List<SubordinatedUserEntity>,cartableItems: null == cartableItems ? _self._cartableItems : cartableItems // ignore: cast_nullable_to_non_nullable
as List<CartableItemEntity>,filteredCartableItems: null == filteredCartableItems ? _self._filteredCartableItems : filteredCartableItems // ignore: cast_nullable_to_non_nullable
as List<CartableItemEntity>,cartableSearchText: null == cartableSearchText ? _self.cartableSearchText : cartableSearchText // ignore: cast_nullable_to_non_nullable
as String,subordinatedUserSearchText: null == subordinatedUserSearchText ? _self.subordinatedUserSearchText : subordinatedUserSearchText // ignore: cast_nullable_to_non_nullable
as String,isSubordinatedUsersLoading: null == isSubordinatedUsersLoading ? _self.isSubordinatedUsersLoading : isSubordinatedUsersLoading // ignore: cast_nullable_to_non_nullable
as bool,isCartableItemsLoading: null == isCartableItemsLoading ? _self.isCartableItemsLoading : isCartableItemsLoading // ignore: cast_nullable_to_non_nullable
as bool,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,includeSnoozedMessages: freezed == includeSnoozedMessages ? _self.includeSnoozedMessages : includeSnoozedMessages // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$CartableState {

 CartableStateData get data;
/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartableStateCopyWith<CartableState> get copyWith => _$CartableStateCopyWithImpl<CartableState>(this as CartableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartableState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState(data: $data)';
}


}

/// @nodoc
abstract mixin class $CartableStateCopyWith<$Res>  {
  factory $CartableStateCopyWith(CartableState value, $Res Function(CartableState) _then) = _$CartableStateCopyWithImpl;
@useResult
$Res call({
 CartableStateData data
});


$CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CartableStateCopyWithImpl<$Res>
    implements $CartableStateCopyWith<$Res> {
  _$CartableStateCopyWithImpl(this._self, this._then);

  final CartableState _self;
  final $Res Function(CartableState) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}
/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartableState].
extension CartableStatePatterns on CartableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _LoadingMore value)?  loadingMore,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _LoadingMore value)  loadingMore,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Initial():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _LoadingMore():
return loadingMore(_that);case _ConnectionError():
return connectionError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _LoadingMore value)?  loadingMore,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Initial() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CartableStateData data)?  idle,TResult Function( CartableStateData data)?  loading,TResult Function( CartableStateData data)?  loaded,TResult Function( CartableStateData data,  BottomSheetMessageModel message)?  error,TResult Function( CartableStateData data)?  loadingMore,TResult Function( CartableStateData data)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.data);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CartableStateData data)  idle,required TResult Function( CartableStateData data)  loading,required TResult Function( CartableStateData data)  loaded,required TResult Function( CartableStateData data,  BottomSheetMessageModel message)  error,required TResult Function( CartableStateData data)  loadingMore,required TResult Function( CartableStateData data)  connectionError,}) {final _that = this;
switch (_that) {
case _Initial():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _Error():
return error(_that.data,_that.message);case _LoadingMore():
return loadingMore(_that.data);case _ConnectionError():
return connectionError(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CartableStateData data)?  idle,TResult? Function( CartableStateData data)?  loading,TResult? Function( CartableStateData data)?  loaded,TResult? Function( CartableStateData data,  BottomSheetMessageModel message)?  error,TResult? Function( CartableStateData data)?  loadingMore,TResult? Function( CartableStateData data)?  connectionError,}) {final _that = this;
switch (_that) {
case _Initial() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.data);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CartableState {
  const _Initial({this.data = const CartableStateData()});
  

@override@JsonKey() final  CartableStateData data;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Initial(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loading implements CartableState {
  const _Loading({required this.data});
  

@override final  CartableStateData data;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loaded implements CartableState {
  const _Loaded({required this.data});
  

@override final  CartableStateData data;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Error implements CartableState {
  const _Error({required this.data, required this.message});
  

@override final  CartableStateData data;
 final  BottomSheetMessageModel message;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
  return 'CartableState.error(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data, BottomSheetMessageModel message
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_Error(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _LoadingMore implements CartableState {
  const _LoadingMore({required this.data});
  

@override final  CartableStateData data;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingMoreCopyWith<_LoadingMore> get copyWith => __$LoadingMoreCopyWithImpl<_LoadingMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState.loadingMore(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingMoreCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(_LoadingMore value, $Res Function(_LoadingMore) _then) = __$LoadingMoreCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(this._self, this._then);

  final _LoadingMore _self;
  final $Res Function(_LoadingMore) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_LoadingMore(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ConnectionError implements CartableState {
  const _ConnectionError({required this.data});
  

@override final  CartableStateData data;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CartableState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $CartableStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 CartableStateData data
});


@override $CartableStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CartableStateData,
  ));
}

/// Create a copy of CartableState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartableStateDataCopyWith<$Res> get data {
  
  return $CartableStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
