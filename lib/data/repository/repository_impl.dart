import 'package:advance_course_flutter/data/data_Souece/remote_data_source.dart';
import 'package:advance_course_flutter/data/mapper/mapper.dart';
import 'package:advance_course_flutter/data/network/error_handler.dart';
import 'package:advance_course_flutter/data/network/failure.dart';
import 'package:advance_course_flutter/data/network/network_info.dart';
import 'package:advance_course_flutter/data/request/request.dart';
import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:advance_course_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){

      try{
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if(response!.status == ApiInternalStaus.SUCCESS)
        {
          // return data
          // return right of Either
          return Right(response.toDomain());

        }else{
          // return biz logic error
          return Left(Failure(
              response.status ?? ApiInternalStaus.FAILURE,
              response.message?? ResponseMessage.DEFAULT,
            )
          );
        }
      }catch(error){
        return (Left(ErrorHandler.handle(error).failure));
      }

    }else{
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}