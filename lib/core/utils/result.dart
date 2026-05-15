import '../errors/failures.dart';

sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) =>
      success(data);
}

final class Failure<T> extends Result<T> {
  final AppFailure failure;
  const Failure(this.failure);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) =>
      failure(this.failure);
}
