import 'dart:async';
import 'dart:io';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get.dart';
import '../../shared/services/storage_service.dart';

FutureOr<Request> authInterceptor(Request request) async {

  // create a list of the endpoints where you don't need to pass a token.
  final listOfPaths = <String>[
    // '/send-otp',
    // '/validate-otp',
  ];

  // Mandatory header
  request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  request.headers[HttpHeaders.acceptHeader] = 'application/json';
  // request.headers['X-Requested-With'] = 'XMLHttpRequest';

  // Check if the requested endpoint match in the auth exception list
  if (!listOfPaths.contains(request.url.path)) {
    StorageService storageService = Get.find<StorageService>();
    final token = storageService.accessToken;

    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  return request;
}
