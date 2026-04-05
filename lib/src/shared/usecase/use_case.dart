abstract class BaseUseCaseOfStream<R, P> {
  Future<Stream<R>> call(P arg);
}

abstract class BaseUseCase<R, P> {
  Future<R> call(P arg);
}

abstract class ValidatorUseCase<R, P> {
  R call(P arg);
}

abstract class BaseUseCaseNoArgs<R> {
  Future<R> call();
}

abstract class BaseUseCaseOfStreamNoArgs<R> {
  Stream<R> call();
}
