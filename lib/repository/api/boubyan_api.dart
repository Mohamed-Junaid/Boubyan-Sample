import 'dart:convert';


import 'package:http/http.dart';


import '../modelclass/registerModel.dart';
import 'api_client.dart';


class BoubyanApi{
  ApiClient apiClient = ApiClient();


  Future<RegisterModel> getRegister(String name,String dob,String mobile,String gender,
      String isSelectedClient,String isSelectedNotClient) async {
    String trendingpath = 'http://alphalonge.boubyansteps.co/api/v1/user/register';
    var body = {
      "name": name,
      "dob": dob,
      "client": isSelectedClient,
      "phone": mobile,
      "isClient": isSelectedNotClient,
      "deviceType": 1.toString(),
      "model": "model",
      "osVersion": "osVersion",
      "appVersion": "appVersion",
      "gender": gender,
    };
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return RegisterModel.fromJson(jsonDecode(response.body));
  }
}