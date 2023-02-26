import 'dart:async';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:workforce/src/controllers/user_controller.dart';

import '../controllers/location_controller.dart';

class ApiService {
  final _dio = Dio();
  // final _userC = Get.put(UserController());
  final locationC = Get.put(LocationController());

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool authentication = false,
  }) async {
    try {
      // final latLng = await locationC.getCurrentLocation();
      final response = await _dio.get(
        '${dotenv.env['BASE_URL_KYC']}$path',
        queryParameters: queryParameters,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': authentication
                ? 'Bearer ${Get.put(UserController()).getToken()}'
                : null
          },
        ),
      );
      return response;
    } catch (e) {
      print(e);
      throw ('Something went wrong');
    }
  }

  Future<Response> post({
    required String path,
    dynamic body,
    bool authentication = false,
  }) async {
    locationC.getCurrentLocation();
    try {
      final response = await _dio.post(
        '${dotenv.env['BASE_URL_KYC']}$path',
        data: body,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            // 'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'Authorization': authentication
                ? 'Bearer ${Get.put(UserController()).getToken()}'
                : null
          },
        ),
      );

      return response;
    } catch (e) {
      print(e);
      throw ('Something went wrong');
    }
  }

  Future<Response> postDynamic({
    required String path,
    dynamic body,
    bool authentication = false,
  }) async {
    locationC.getCurrentLocation();
    try {
      final response = await _dio.post(
        path,
        data: body,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            // 'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'Authorization': authentication
                ? 'Bearer ${Get.put(UserController()).getToken()}'
                : null
          },
        ),
      );

      return response;
    } catch (e) {
      print(e);
      throw ('Something went wrong');
    }
  }

  Future<Response> getDynamic({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool authentication = false,
  }) async {
    locationC.getCurrentLocation();
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            // 'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'Authorization': authentication
                ? 'Bearer ${Get.put(UserController()).getToken()}'
                : null
          },
        ),
      );
      return response;
    } catch (e) {
      print(e);
      throw ('Something went wrong');
    }
  }

  Future<Response> getTest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    await locationC.getCurrentLocation();
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            // 'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}'
          },
        ),
      );
      return response;
    } catch (e) {
      print(e);
      throw ('Something went wrong');
    }
  }
}
