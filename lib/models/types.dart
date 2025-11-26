import 'package:dartz/dartz.dart';

typedef Result<T> = Either<String, T>;
typedef AsyncResult<T> = Future<Either<String, T>>;
