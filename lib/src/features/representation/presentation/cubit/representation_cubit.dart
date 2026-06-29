import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'representation_state.dart';
part 'representation_cubit.freezed.dart';

@injectable
class RepresentationCubit extends Cubit<RepresentationState> {
  RepresentationCubit() : super(const RepresentationState.initial());

  void init(){}
}
