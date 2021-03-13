import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_test/toast.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getErrorException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.CANCEL:
              networkExceptions = NetworkExceptions.requestCancelled();
              toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              networkExceptions = NetworkExceptions.requestTimeout();
              toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              break;
            case DioErrorType.DEFAULT:
              networkExceptions = NetworkExceptions.noInternetConnection();
              toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              networkExceptions = NetworkExceptions.sendTimeout();
              toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              break;
            case DioErrorType.RESPONSE:
              switch (error.response.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound("Not found");
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
                  break;
                default:
                  var responseCode = error.response.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
                  toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              }
              break;
            case DioErrorType.SEND_TIMEOUT:
              networkExceptions = NetworkExceptions.sendTimeout();
              toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
          toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
          toast(message: NetworkExceptions.getErrorMessage(networkExceptions));
        }
        return networkExceptions;
      } on FormatException catch (e) {
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled";
    }, internalServerError: () {
      errorMessage = "Internal Server Error";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Service unavailable";
    }, methodNotAllowed: () {
      errorMessage = "Method Allowed";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "Unauthorised request";
    }, unexpectedError: () {
      errorMessage = "Unexpected error occurred";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout";
    }, noInternetConnection: () {
      errorMessage = "No internet connection";
    }, conflict: () {
      errorMessage = "Error due to a conflict";
    }, sendTimeout: () {
      errorMessage = "Send timeout in connection with API server";
    }, unableToProcess: () {
      errorMessage = "Unable to process the data";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Unexpected error occurred";
    }, notAcceptable: () {
      errorMessage = "Not acceptable";
    });
    return errorMessage;
  }
}
