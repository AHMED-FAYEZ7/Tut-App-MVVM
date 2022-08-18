import 'package:advance_course_flutter/app/constant.dart';
import 'package:advance_course_flutter/data/responses/responses.dart';
import 'package:dio/dio.dart';

abstract class AppServicesClient{
  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: Constant.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String , dynamic> data,
    Map<String ,dynamic>? query,
  }) async
    {
      // dio.options.headers = {
      //   'Authorization': imei,
      //   "Content-Type":"application/json",
      // };

      return await dio.post(
        url,
        queryParameters: query,
        data: data,
      );
    }
}
/////////////////
