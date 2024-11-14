import 'package:flutter/foundation.dart';

@immutable
abstract class Either<L, R> {
  const Either();

  T fold<T>(final T Function(L exception) left, final T Function(R result) right);

  R? get right;

  L? get left;
}

@immutable
class Left<L, R> extends Either<L, R> {
  final L _left;

  const Left(this._left);

  @override
  T fold<T>(final T Function(L exception) left, final T Function(R result) right) =>
      left(_left);

  @override
  L get left => _left;

  @override
  R? get right => null;

  @override
  bool operator ==(final dynamic other) =>
      other is Left && other._left == _left;

  @override
  int get hashCode => _left.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R _right;

  const Right(this._right);

  @override
  T fold<T>(final T Function(L exception) left, final T Function(R result) right) =>
      right(_right);

  @override
  L? get left => null;

  @override
  R get right => _right;

  @override
  bool operator ==(final dynamic other) =>
      other is Right && other._right == _right;

  @override
  int get hashCode => _right.hashCode;
}
