part of '../eb_sources.dart';

sealed class Result {}

final class Success<S> extends Result {
  final S success;

  Success({required this.success});
}

final class Failure<F> extends Result {
  final F failure;

  Failure({required this.failure});
}
