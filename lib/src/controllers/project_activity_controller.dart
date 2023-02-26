import 'package:get/get.dart';

import '../background/services/api_service.dart';

class ProjectActivityGroupBoardController extends GetxController
    with ApiService {
  final isLoading = RxBool(false);

  // void getActivity() async {
  //   print('bucket id');
  //   // print(bucketId.value);
  //   // print(projectId.value);
  //   try {
  //     final selectedAgency = Get.put(AgencyController()).selectedAgency;
  //     final username = Get.put(UserController()).username;
  //    // kLog(selectedAgency!.agencyId);
  //     isLoading.value = true;
  //     final params = {
  //       // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,
  //       'agencyIds':selectedAgency!.agencyId,
  //       'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //       'appCode': 'WFC',
  //       'username': username,
  //       'projectId': projectPlanningBoard.isNotEmpty
  //           ? projectPlanningBoard[changeIndex.value]!.id!
  //           : '',
  //     };

  //     final res = await getDynamic(
  //       path: ApiEndpoint.getActivity(),
  //       queryParameters: params,
  //     );
  //    // kLog(res);

  //     if (res.data['status'] != null) {
  //       final data = res.data['data']
  //           .map((json) => Activities.fromJson(json as Map<String, dynamic>))
  //           .toList()
  //           .cast<Activities>() as List<Activities>;

  //      // kLog(data.length);

  //       if (data.isNotEmpty) {
  //         isLoading.value = false;
  //         activityList.clear();
  //         activityList.addAll(data);
  //       }
  //     } else {
  //       activityList.clear();
  //     }
  //     isLoading.value = false;
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  // }

}
