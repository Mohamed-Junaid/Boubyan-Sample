class RegisterModel {
  RegisterModel({
      this.statusCode, 
      this.timestamp, 
      this.message, 
      this.data,});

  RegisterModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? statusCode;
  String? timestamp;
  String? message;
  Data? data;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['timestamp'] = timestamp;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.message, 
      this.token,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}