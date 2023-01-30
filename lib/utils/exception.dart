import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String title;
  final String message;
  final int? code;

  AppException(
      {required this.title, required this.message, required this.code});
}

class NoInternetException extends AppException {
  NoInternetException({
    String message: "Please check your internet connection. Then try again.",
    String title: "No Internet Connection",
  }) : super(message: message, title: title, code: 1);
}

class NotFoundException extends AppException {
  NotFoundException({
    String message: "We cannot found any result.",
    String title: "Not Found",
  }) : super(message: message, title: title, code: 404);
}

class OtherExceptions extends AppException {
  OtherExceptions({
    String message: "Error has occurred.",
    String title: "Error",
  }) : super(message: message, title: title, code: 2);
}

class SocketException extends AppException {
  SocketException({
    String message: "Please check your internet connection!",
    String title: "No Internet Access",
  }) : super(message: message, title: title, code: 7);
}

class PermissionDeniedForeverException extends AppException {
  PermissionDeniedForeverException(
      {String message: "Press confirm, to grant permission.",
      String title: "Permission not granted"})
      : super(message: message, title: title, code: 1000);
}

class WrongAuthException extends AppException {
  WrongAuthException(
      {String message: "Invalid OTP, please try again!",
      String title: "Invalid OTP"})
      : super(message: message, title: title, code: 2);
}

class CodeSentFail extends AppException {
  CodeSentFail(
      {String message:
          "Can't send code, please check your internet connection!",
      String title: "Unable to send code"})
      : super(message: message, title: title, code: 7);
}

class ConnectionTimeOut extends AppException {
  ConnectionTimeOut(
      {String message: "Could not reach the server, please try again!",
      String title: "Connection Time out"})
      : super(message: message, title: title, code: 408);
}

class SessionExpiredException extends AppException {
  SessionExpiredException(
      {String message: "Session expired, please resend the code again!",
      String title: "Session Expired"})
      : super(message: message, title: title, code: 440);
}

AppException throwApiException(DioError e) {
  if (e.type == DioErrorType.connectTimeout) {
    return ConnectionTimeOut();
  }
  if (e.type == DioErrorType.response) {
    return NotFoundException();
  }

  if (e.type == DioErrorType.other) {
    return SocketException();
  }

  return OtherExceptions();
}

// AppException throwAuthException(FirebaseAuthException e) {
  // String noInternet = "network-request-failed";
  // String sessionExpired = "session-expired";
  // String wrongCode = "invalid-verification-code";
// 
  // if (e.code == wrongCode) {
    // return WrongAuthException();
  // }
  // if (e.code == sessionExpired) {
    // return SessionExpiredException();
  // }
  // if (e.code == noInternet) {
    // return SocketException();
  // }
  // return OtherExceptions();
// }
