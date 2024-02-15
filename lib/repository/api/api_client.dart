import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'api_exception.dart';

class ApiClient {


  ApiClient();

  Future<Response> invokeAPI(String path, String method, Object? body) async {
    Map<String, String> headerParams = {};
    Response response;

    String url = path;
    print(url);

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;
    print(body);

    switch (method) {
      case "POST":
      case "PUT":
      case "DELETE":
      case "POST_":
      case "GET_":
      case "GET":
      case "PATCH":
      case "PATCH1":
      // Add API key and API secret to the headers
        headerParams.addAll({
          'content-Type': 'application/json',

        });
        break;
      default:
      // For other methods, include API key and API secret in the headers
        headerParams.addAll({
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
    }

    try {
      switch (method) {
        case "POST":
          response = await post(Uri.parse(url),
              headers: headerParams, body: body);
          break;
        case "PUT":
          response = await put(Uri.parse(url),
              headers: headerParams, body: body);
          break;
        case "DELETE":
          response = await delete(Uri.parse(url), headers: headerParams, body: body);
          break;
        case "POST_":
          response = await post(
            Uri.parse(url),
            headers: headerParams,
            body: body,
          );
          break;
        case "GET_":
          response = await post(
            Uri.parse(url),
            headers: headerParams,
            body: body,
          );
          break;
        case "GET":
          response = await get(
            Uri.parse(url),
            headers: headerParams,
          );
          break;
        case "PATCH":
          response = await patch(
            Uri.parse(url),
            headers: headerParams,
            body: body,
          );
          break;
        case "PATCH1":
          response = await patch(
            Uri.parse(url),
            headers: headerParams,
            body: body,
          );
          break;
        default:
          response = await get(Uri.parse(url), headers: headerParams);
      }

      print('status of $path =>' + (response.statusCode).toString());
      print(response.body);
      if (response.statusCode >= 400) {
        log(path +
            ' : ' +
            response.statusCode.toString() +
            ' : ' +
            response.body);

        throw ApiException(_decodeBodyBytes(response), response.statusCode);
      }
      return response;
    } catch (e) {
      // Handle exceptions or rethrow them as needed
      print('Error: $e');
      rethrow;
    }
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
