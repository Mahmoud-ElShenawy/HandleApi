import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utils_test/service/interceptors/dio_connectivity_request_retrier.dart';
import 'package:utils_test/service/interceptors//retry_interceptors.dart';
import 'package:utils_test/service/network/network_exceptions.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class ApiProvider {
  static ApiProvider _instance = new ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() => _instance;

  Dio _dio = Dio();

  static const Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
  };

  ///POST Method
  Future<Response> post({@required String apiRoute, @required var data}) async {
    var response;
    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
            responseBody: true,
            error: true,
            requestHeader: false,
            responseHeader: false,
            request: false,
            requestBody: false));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = apiHeaders;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.post(apiRoute, data: data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } catch (e) {
      NetworkExceptions.getErrorException(e);
      throw e;
    }
    return handleResponse(response);
  }

  ///GET Method
  Future<Response> get({@required String apiRoute}) async {
    var response;
    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
            responseBody: true,
            error: true,
            requestHeader: false,
            responseHeader: false,
            request: false,
            requestBody: false));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = apiHeaders;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.get(apiRoute);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } catch (e) {
      NetworkExceptions.getErrorException(e);
      throw e;
    }
    return handleResponse(response);
  }
}

Response handleResponse(Response response) {
  final int statusCode = response.statusCode;
  print('Status Code: $statusCode');
  if (statusCode == 200) {
    return response;
  } else {
    throw Exception('Error');
  }
}
