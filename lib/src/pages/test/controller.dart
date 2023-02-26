// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:workforce/src/pages/test/model.dart';

// class Controller extends GetxController {
//   final modelCalss = RxList<ModelClass>();

//   final _dio = Dio();

//   void getData() async {
//     try {
//       final response = await _dio.get(
//         'https://retoolapi.dev/Rzl99e/farmers',
//       );

//       final data = response.data
//           .map((json) => ModelClass.fromJson(json as Map<String, dynamic>))
//           .toList()
//           .cast<ModelClass>() as List<ModelClass>;
//       if (data.isNotEmpty) {
//         modelCalss.clear();
//         modelCalss.addAll(data);
//       }
//     } on DioError catch (e) {
//       print(e.message);
//     }
//   }
// }
