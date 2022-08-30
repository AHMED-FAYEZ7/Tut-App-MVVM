import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/data/request/request.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgotPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure,HomeObject>> getHome();
  Future<Either<Failure,StoreDetails>> getStoreDetails();
}