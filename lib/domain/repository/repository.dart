import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/data/request/request.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}