import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:advance_course_flutter/domain/repository/repository.dart';
import 'package:advance_course_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase extends BaseUseCase<void,StoreDetails>{
  final Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _repository.getStoreDetails();
  }
}