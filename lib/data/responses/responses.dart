class BaseResponse {
  int? status;
  String? message;

  BaseResponse({this.status, this.message});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class UserResponse {
  String? id;
  String? name;
  int? numOfNotification;

  UserResponse({this.id, this.name, this.numOfNotification});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numOfNotification = json['numOfNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['numOfNotification'] = numOfNotification;
    return data;
  }
}

class ContactsResponse {
  String? phone;
  String? link;
  String? email;

  ContactsResponse({this.phone, this.link, this.email});

  ContactsResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    link = json['link'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['link'] = link;
    data['email'] = email;
    return data;
  }
}

class AuthenticationResponse extends BaseResponse{
  UserResponse? user;
  ContactsResponse? contacts;

  AuthenticationResponse({
    this.user,
    this.contacts,
  });

  AuthenticationResponse.fromJson(Map<String,dynamic>? json){
    user = json!['user'] != null ? UserResponse.fromJson(json['user']): null;
    contacts = json['contacts'] != null ? ContactsResponse.fromJson(json['contacts']): null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['contacts'] = contacts;
    return data;
  }

}
