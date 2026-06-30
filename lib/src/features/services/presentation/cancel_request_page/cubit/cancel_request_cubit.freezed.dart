// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancel_request_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CancelRequestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelRequestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState()';
}


}

/// @nodoc
class $CancelRequestStateCopyWith<$Res>  {
$CancelRequestStateCopyWith(CancelRequestState _, $Res Function(CancelRequestState) __);
}


/// Adds pattern-matching-related methods to [CancelRequestState].
extension CancelRequestStatePatterns on CancelRequestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _SubmitLoading value)?  submitLoading,TResult Function( _SubmitSuccess value)?  submitSuccess,TResult Function( _ShowPreInvoice value)?  showPreInvoice,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _ShowPreInvoice() when showPreInvoice != null:
return showPreInvoice(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _SubmitLoading value)  submitLoading,required TResult Function( _SubmitSuccess value)  submitSuccess,required TResult Function( _ShowPreInvoice value)  showPreInvoice,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _ConnectionError():
return connectionError(_that);case _SubmitLoading():
return submitLoading(_that);case _SubmitSuccess():
return submitSuccess(_that);case _ShowPreInvoice():
return showPreInvoice(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _SubmitLoading value)?  submitLoading,TResult? Function( _SubmitSuccess value)?  submitSuccess,TResult? Function( _ShowPreInvoice value)?  showPreInvoice,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _ShowPreInvoice() when showPreInvoice != null:
return showPreInvoice(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( bool showSecondDropDown,  bool showDateTimeSection)?  loaded,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  connectionError,TResult Function()?  submitLoading,TResult Function()?  submitSuccess,TResult Function( InvoiceEntity invoice)?  showPreInvoice,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.showSecondDropDown,_that.showDateTimeSection);case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess();case _ShowPreInvoice() when showPreInvoice != null:
return showPreInvoice(_that.invoice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( bool showSecondDropDown,  bool showDateTimeSection)  loaded,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  connectionError,required TResult Function()  submitLoading,required TResult Function()  submitSuccess,required TResult Function( InvoiceEntity invoice)  showPreInvoice,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded(_that.showSecondDropDown,_that.showDateTimeSection);case _Error():
return error(_that.message);case _ConnectionError():
return connectionError();case _SubmitLoading():
return submitLoading();case _SubmitSuccess():
return submitSuccess();case _ShowPreInvoice():
return showPreInvoice(_that.invoice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( bool showSecondDropDown,  bool showDateTimeSection)?  loaded,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  connectionError,TResult? Function()?  submitLoading,TResult? Function()?  submitSuccess,TResult? Function( InvoiceEntity invoice)?  showPreInvoice,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.showSecondDropDown,_that.showDateTimeSection);case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess();case _ShowPreInvoice() when showPreInvoice != null:
return showPreInvoice(_that.invoice);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements CancelRequestState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState.idle()';
}


}




/// @nodoc


class _Loading implements CancelRequestState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState.loading()';
}


}




/// @nodoc


class _Loaded implements CancelRequestState {
  const _Loaded({this.showSecondDropDown = false, this.showDateTimeSection = false});
  

@JsonKey() final  bool showSecondDropDown;
@JsonKey() final  bool showDateTimeSection;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.showSecondDropDown, showSecondDropDown) || other.showSecondDropDown == showSecondDropDown)&&(identical(other.showDateTimeSection, showDateTimeSection) || other.showDateTimeSection == showDateTimeSection));
}


@override
int get hashCode => Object.hash(runtimeType,showSecondDropDown,showDateTimeSection);

@override
String toString() {
  return 'CancelRequestState.loaded(showSecondDropDown: $showSecondDropDown, showDateTimeSection: $showDateTimeSection)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CancelRequestStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 bool showSecondDropDown, bool showDateTimeSection
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? showSecondDropDown = null,Object? showDateTimeSection = null,}) {
  return _then(_Loaded(
showSecondDropDown: null == showSecondDropDown ? _self.showSecondDropDown : showSecondDropDown // ignore: cast_nullable_to_non_nullable
as bool,showDateTimeSection: null == showDateTimeSection ? _self.showDateTimeSection : showDateTimeSection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Error implements CancelRequestState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CancelRequestState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CancelRequestStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _ConnectionError implements CancelRequestState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState.connectionError()';
}


}




/// @nodoc


class _SubmitLoading implements CancelRequestState {
  const _SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState.submitLoading()';
}


}




/// @nodoc


class _SubmitSuccess implements CancelRequestState {
  const _SubmitSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelRequestState.submitSuccess()';
}


}




/// @nodoc


class _ShowPreInvoice implements CancelRequestState {
  const _ShowPreInvoice({required this.invoice});
  

 final  InvoiceEntity invoice;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShowPreInvoiceCopyWith<_ShowPreInvoice> get copyWith => __$ShowPreInvoiceCopyWithImpl<_ShowPreInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowPreInvoice&&(identical(other.invoice, invoice) || other.invoice == invoice));
}


@override
int get hashCode => Object.hash(runtimeType,invoice);

@override
String toString() {
  return 'CancelRequestState.showPreInvoice(invoice: $invoice)';
}


}

/// @nodoc
abstract mixin class _$ShowPreInvoiceCopyWith<$Res> implements $CancelRequestStateCopyWith<$Res> {
  factory _$ShowPreInvoiceCopyWith(_ShowPreInvoice value, $Res Function(_ShowPreInvoice) _then) = __$ShowPreInvoiceCopyWithImpl;
@useResult
$Res call({
 InvoiceEntity invoice
});




}
/// @nodoc
class __$ShowPreInvoiceCopyWithImpl<$Res>
    implements _$ShowPreInvoiceCopyWith<$Res> {
  __$ShowPreInvoiceCopyWithImpl(this._self, this._then);

  final _ShowPreInvoice _self;
  final $Res Function(_ShowPreInvoice) _then;

/// Create a copy of CancelRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invoice = null,}) {
  return _then(_ShowPreInvoice(
invoice: null == invoice ? _self.invoice : invoice // ignore: cast_nullable_to_non_nullable
as InvoiceEntity,
  ));
}


}

// dart format on
