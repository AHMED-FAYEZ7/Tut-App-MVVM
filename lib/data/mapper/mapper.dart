// to convert the response into non nullable object (model)

import 'package:advance_course_flutter/app/extensions.dart';
import 'package:advance_course_flutter/data/responses/responses.dart';
import 'package:advance_course_flutter/domain/model/model.dart';

extension UserResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse?{
  Contacts toDomain(){
    return Contacts(
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}