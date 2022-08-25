import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/data/request/request.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:advance_course_flutter/domain/repository/repository.dart';
import 'package:advance_course_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryMobileCode,
        input.userName,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePic,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePic;

  RegisterUseCaseInput(
      this.countryMobileCode,
      this.userName,
      this.email,
      this.password,
      this.mobileNumber,
      this.profilePic,
      );
}