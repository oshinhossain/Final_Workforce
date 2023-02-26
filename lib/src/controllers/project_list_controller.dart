import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/models/project_model.dart';

import 'agencyController.dart';
import 'user_controller.dart';

class ProjectListController extends GetxController with ApiService {
  final projectList = RxList<ProjectModel>();

  final selectedProject = Rx<ProjectModel?>(null);

  Future<void> getProjectList() async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final res = await postDynamic(
      path:
          '${dotenv.env['BASE_URL_WFC']}/v1/project/get?agencyIds=${selectedAgency!.agencyId}=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&username=$username',
    );

    if (convertStatusCode(res.data['responseCode']) == 200) {
      final data = res.data['data'].map(
              (json) => ProjectModel.fromJson(json as Map<String, dynamic>))
          as List<ProjectModel>;

      if (data.isNotEmpty) {
        projectList.addAll(data);
      }
    }
  }
}
