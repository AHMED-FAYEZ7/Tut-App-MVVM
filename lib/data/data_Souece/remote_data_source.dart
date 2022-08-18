import 'package:advance_course_flutter/app/constant.dart';
import 'package:advance_course_flutter/data/network/app_api.dart';
import 'package:advance_course_flutter/data/request/request.dart';
import 'package:advance_course_flutter/data/responses/responses.dart';

abstract class RemoteDataSource{
  AuthenticationResponse? authenticationResponse;

  Future<AuthenticationResponse>? login(LoginRequest loginRequest){
    AppServicesClient.postData(
        url: Constant.LOGIN,
        data: {
          'email':loginRequest.email,
          'password':loginRequest.password,
          'imei':loginRequest.email,
          'device_type':loginRequest.deviceType,
        },
    ).then((value) {
      authenticationResponse = AuthenticationResponse.fromJson(value.data);
    }).catchError((error){
      print(error.toString());
    });
    return null;
  }
}

// class RemoteDataSourceImplementer implements RemoteDataSource{
//
//   @override
//   Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
//     return await AppServicesClient.postData(
//         url: Constant.LOGIN,
//         data: data,
//     );
//
//   }
//
//   AuthenticationResponse? authenticationResponse;
//
//   void userLogin({
//     required String email,
//     required String password,
//   })
//   {
//     AppServicesClient.postData(
//       url: Constant.LOGIN,
//       data: {
//         'email': email,
//         'password':password,
//       },
//     ).then((value) {
//       authenticationResponse = AuthenticationResponse.fromJson(value.data);
//     }).catchError((error) {
//       print(error.toString());
//     });
//   }
//
//
// }