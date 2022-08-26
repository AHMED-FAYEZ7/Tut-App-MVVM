import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:advance_course_flutter/domain/repository/repository.dart';
import 'package:advance_course_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase extends BaseUseCase<void,HomeObject>{
  Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}