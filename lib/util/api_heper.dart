import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as h;

class HttpController {
  HttpController._();
  static final HttpController _httpController = HttpController._();
  factory HttpController() => _httpController; //singleton pattern

  static final _http = h.Client();
  final Utf8Decoder _utf8decoder = const Utf8Decoder();
  final String _baseUrl = 'https://flutter-hh-test-task.iwow.com.kz/api';
  final StringBuffer _sb = StringBuffer("?");
  // final SecureStorage _storage = SecureStorage();

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? params,
    Map<String, String>? headers,
    Function? callback,
    Function? errorCallback,
  }) async {
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        _sb.write("$key=$value&");
      });
      String paramStr = _sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      return _http
          .get(Uri.parse('$_baseUrl$url'), headers: headers)
          .then((response) {
        return _returnResponse(response, () {
          // get(url, headers: headers, params: params);
        });
      });
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    Response response;
    try {
      response = await _http.post(Uri.parse('$_baseUrl$url'),
          body: json.encode(body), headers: headers);

      if (response.statusCode == 200) {
        return json.decode(_utf8decoder.convert(response.bodyBytes));
      } else if (response.statusCode == 204) {
        return {};
      } else if (response.statusCode == 201) {
        return {};
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> uploadImageHTTP(file, url) async {
    try {
      var request = h.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await h.MultipartFile.fromPath('file', file.path));
      var streamedResponse = await request.send();
      var response = await h.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return json.decode(_utf8decoder.convert(response.bodyBytes));
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void close() {
    //In order to better prevent memory leaks
    _sb.clear();
    _http.close();
  }

  Map<String, dynamic> _returnResponse(
      h.Response response, VoidCallback noauth) {
    switch (response.statusCode) {
      case 200:
        return json.decode(_utf8decoder.convert(response.bodyBytes));
      case 201:
        throw UnauthorisedException(response.body.toString());

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 402:
        throw PaymentRequiredException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());

      case 500:
        throw UnauthorisedException(response.body.toString());

      case 503:
        throw ServiceUnavailableException(response.body.toString());

      case 511:
        throw NetworkAuthenticationRequiredException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final message;
  final prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "NotFound: ");
}

class PaymentRequiredException extends AppException {
  PaymentRequiredException([message]) : super(message, "Unauthorised: ");
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([message])
      : super(message, "Service Unavailable: ");
}

class NetworkAuthenticationRequiredException extends AppException {
  NetworkAuthenticationRequiredException([message])
      : super(message, "Network Authentication Required: ");
}

class CreatedException extends AppException {
  CreatedException([message]) : super(message, "Created: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
