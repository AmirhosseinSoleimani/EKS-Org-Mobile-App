import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_state.dart';
part 'cartable_cubit.freezed.dart';

@injectable
class CartableCubit extends Cubit<CartableState> {
  CartableCubit() : super(const CartableState.initial());

  Future<void> init() async{}
}
