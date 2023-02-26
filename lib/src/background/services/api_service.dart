import 'dart:async';

import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';

class ApiService {
  final _dio = Dio();
  final locationC = Get.put(LocationController());

  // Future<Response?> get({
  //   required String path,
  //   Map<String, dynamic>? queryParameters,
  //   bool authentication = true,
  // }) async {
  //   try {
  //     final response = await _dio.get(
  //       '${dotenv.env['BASE_URL_KYC']}$path',
  //       queryParameters: queryParameters,
  //       options: Options(
  //         followRedirects: false,
  //         // will not throw errors
  //         validateStatus: (status) => true,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           // 'Authorization':
  //           //     authentication ? 'Bearer ${_userC.getToken()}' : null
  //         },
  //       ),
  //     );
  //     return response;
  //   } catch (e) {
  //     print(e);
  //     throw ('Something went wrong');
  //   }
  // }

  // Future<Response> post({
  //   required String path,
  //   dynamic body,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       '${dotenv.env['BASE_URL_KYC']}$path',
  //       data: body,
  //       options: Options(
  //         followRedirects: false,
  //         // will not throw errors
  //         validateStatus: (status) => true,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
  //           // 'Authorization':
  //           //     authentication ? 'Bearer ${_userC.getToken()}' : null
  //         },
  //       ),
  //     );

  //     return response;
  //   } catch (e) {
  //     print(e);
  //     throw ('Something went wrong');
  //   }
  // }

  // Future<Response> postDynamic({
  //   required String path,
  //   dynamic body,
  //   Map<String, dynamic>? header,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       path,
  //       data: body,
  //       options: Options(
  //         followRedirects: false,
  //         // will not throw errors
  //         validateStatus: (status) => true,
  //         headers: header != null
  //             ? header
  //             : {
  //                 'Content-Type': 'application/json',
  //                 'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
  //                 // 'Authorization':
  //                 //     authentication ? 'Bearer ${_userC.getToken()}' : null
  //               },
  //       ),
  //     );

  //     return response;
  //   } catch (e) {
  //     print(e);
  //     throw ('Something went wrong');
  //   }
  // }

  // Future<Response> getDynamic({
  //   required String path,
  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   try {
  //     final response = await _dio.get(
  //       path,
  //       queryParameters: queryParameters,
  //       options: Options(
  //         followRedirects: false,
  //         // will not throw errors
  //         validateStatus: (status) => true,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
  //         },
  //       ),
  //     );

  //     return response;
  //   } catch (e) {
  //    // kLog(e);
  //     throw ('Something went wrong');
  //   }
  // }

  Future<Uint8List?> getImage({required String username}) async {
    // kLog(username);
    final res = await _dio.get<Uint8List>(
      '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$username&appCode=KYC&fileCategory=photo&countryCode=BD',
      options: Options(
        followRedirects: false,
        responseType: ResponseType.bytes,
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'latLng':
              '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
        },
      ),
    );

    // kLog(res.data);
    return res.data;
  }
}
