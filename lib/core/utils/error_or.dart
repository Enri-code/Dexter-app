import 'package:dartz/dartz.dart';
import 'package:dexter_test/core/utils/app_error.dart';

typedef AsyncErrorOr<T> = Future<Either<AppError, T>>;
// typedef StreamErrorOr<T> = Either<AppError, Stream<T>>;
