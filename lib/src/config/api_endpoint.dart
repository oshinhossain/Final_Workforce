// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static String SHOUT_API_KEY = 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5';
  static String KYC_API_KEY = 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5';
  static String WFC_API_KEY = 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5';
  static String CTS_API_KEY = 'ZWR1Y2l0aW9uQ1RTMTIzNDU2Nzg5';
  static String NRBG_API_KEY = 'ZWR1Y2l0aW9uTlJCRzEyMzQ1Njc4OQ==';

  static String WFC_APP_CODE = 'WFC';
  static String SHOUT_APP_CODE = 'SHOUT';
  static String SURVEY_APP_CODE = 'SURVEY';

  // ----------For Dev---------------------------------------
  // static String _BASE_URL_LOG = CtsSharedPreferences.getString('BASE_URL_LOG') ?? 'http://cloud.ctrends-software.com:9006';
  // static String _BASE_URL_KYC = CtsSharedPreferences.getString('BASE_URL_KYC') ?? 'http://cloud.ctrends-software.com:9001';
  // static String _BASE_URL_SURVEY = CtsSharedPreferences.getString('BASE_URL_SURVEY') ?? 'http://cloud.ctrends-software.com:9003';
  // static String _BASE_URL_GIS = CtsSharedPreferences.getString('BASE_URL_GIS') ?? 'http://cloud.ctrends-software.com:9013';
  // static String _BASE_URL_SHOUT = CtsSharedPreferences.getString('BASE_URL_SHOUT') ?? 'http://cloud.ctrends-software.com:9014';
  // static String _BASE_URL_WFC = CtsSharedPreferences.getString('BASE_URL_WFC') ?? 'http://cloud.ctrends-software.com:9020';

  // ---------For production/live/release--------------------
  /* static String _BASE_URL_LOG = CtsSharedPreferences.getString('BASE_URL_LOG') ?? 'http://cloud.ctrends-software.com:9106';
  static String _BASE_URL_KYC = CtsSharedPreferences.getString('BASE_URL_KYC') ?? 'http://cloud.ctrends-software.com:9101';
  static String _BASE_URL_SURVEY = CtsSharedPreferences.getString('BASE_URL_SURVEY') ?? 'http://cloud.ctrends-software.com:9103';
  static String _BASE_URL_GIS = CtsSharedPreferences.getString('BASE_URL_GIS') ?? 'http://cloud.ctrends-software.com:9113';
  static String _BASE_URL_SHOUT = CtsSharedPreferences.getString('BASE_URL_SHOUT') ?? 'http://cloud.ctrends-software.com:9114';
  */
  // -------------------For Local-----------------------------
  // static String _BASE_URL_LOG = CtsSharedPreferences.getString('BASE_URL_LOG') ?? 'http://192.168.100.121:9006';
  // static String _BASE_URL_KYC = CtsSharedPreferences.getString('BASE_URL_KYC') ?? 'http://192.168.100.121:9001';
  // static String _BASE_URL_SURVEY = CtsSharedPreferences.getString('BASE_URL_SURVEY') ?? 'http://192.168.100.121:9003';
  // static String _BASE_URL_GIS = CtsSharedPreferences.getString('BASE_URL_GIS') ?? 'http://192.168.100.121:9013';
  // static String _BASE_URL_SHOUT = CtsSharedPreferences.getString('BASE_URL_SHOUT') ?? 'http://192.168.100.121:9014';

  static String getTransportOrderUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/transport-order';
  }

//nahid

  static String getReceiptLoadMaterials() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/load-materials';
  }
  /*devloped by:Sumaiya
  date:41022
  */

  static String getVehiclesUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/vehicles-by-agency/search';
  }

  static String getDriverUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/drivers-by-agency/search';
  }

  static String getItemlistTransportOrderNo() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/transport-order';
  }

  static String getTransportOrderNo() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/transport-order';
  }

  static String getUnloadMaterial() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/load-materials/get';
  }

  static String confirmUnloadMaterial() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/confirm-unload-materials';
  }

  static String evedenseSave() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add';
  }

  static String assignVehicleDriverAdd() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/assign-vehicles-and-drivers/add';
  }

  static String getProjectItemUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/list';
  }

  static String gettaskDetailUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/get';
  }

  static String saveTaskUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/progress/post';
  }

  static String getTaskHistoryUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/progress/list';
  }

  static String getFileCount() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/file-count/get';
  }

  static String getTaskHistoryImagesFilesCountUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get';
  }

  static String getProjectNameUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/get';
  }

  static String materialRequisitionAddUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/material-requisition/add';
  }

  static String addGeographiesUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/area/search';
  }

  static String addGeographiesUrlV2() {
    return '${dotenv.env['BASE_URL_WFC']}/v2/project/area/search';
  }

  static String geographiesSearchUrl() {
    return '${dotenv.env['BASE_URL_GIS']}/search_area';
  }

  static String materialRequisitionProductSrcUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/material-requisition/product/search';
  }

  static String productSrcUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/products-by-agency/search';
  }

  static String srcUserLocationUrl() {
    return '${dotenv.env['BASE_URL_GIS']}/search_user_defined_location';
  }

  static String srcUserUrl() {
    return '${dotenv.env['BASE_URL_KYC']}/search_user';
  }

  static String getSiteLocUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/site/location/search';
  }

  static String getBucketName() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/bucket/get';
  }

  static String getActivityGroup() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/activity/group/get';
  }

  static String getProjectCount() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/count';
  }

  static String getActivity() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/planning-board/activity/get';
  }

  static String activityAdd() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/activity/add';
  }

  static String creatTaskSupportAdd() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/add';
  }

  static String getMyProjectDashboard() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project/support/dashboard/get';
  }

  static String getAllTranspotationHistoryUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/transport/history/get';
  }

  static String getAgencyUrl() {
    return '${dotenv.env['BASE_URL_KYC']}/search_agency';
  }

  static String getWarehouseUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/warehouses-by-agency/search';
  }

  static String getmaterialProjectBudgetUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/material-requisition/geo-budget/project/get';
  }

  static String getmaterialDeliveryLocUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/material-requisition/delivery-location/get';
  }

  static String getDeliveryGeographyLocUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/material-requisition/delivery-geo/get';
  }

  static String poligonUrl() {
    return '${dotenv.env['BASE_URL_GIS']}/get_area_by_ids';
  }

  static String getMaterialWorkbechGeographyUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/budget/material-workbench/geographies/get';
  }

  static String getMaterialWorkbechGeographyDetailsUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/budget/material-workbench/geographies/product-details/get';
  }

  //  static String vehicleImageSave() {
  //   return '${dotenv.env['BASE_URL_FSR']}/v1/vehicle-driver/attachment/add';
  // }

  static String getAreaByIdsUrl() {
    return '${dotenv.env['BASE_URL_GIS']}/get_area_by_ids';
  }

  static String getSiteLocV2Url() {
    return '${dotenv.env['BASE_URL_WFC']}/v2/site/location/search';
  }

  static String getNmsNetworkLinkPointsUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/nms-network-link-points/get';
  }

  static String siteRelocateUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project-site/relocate';
  }

  static String siteCompletionUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project-site/complete';
  }

  static String siteEvedenseSave() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add';
  }

  static String sitePostPogressUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/project-site/post-pogress';
  }

  static String getSiteUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/site-list/get';
  }

  static String getProjectTaskApi() {
    return '${dotenv.env['BASE_URL_WFC']}/v2/project/support/get';
  }

  static String linkUpdateUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/nms-network-link/update';
  }

  static String loanGetUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/pr-loan/get';
  }

  static String loanAddUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/pr-loan/add';
  }

  static String trSearchUrl() {
    return '${dotenv.env['BASE_URL_WFC']}/v1/Trv-TravelRequests/search';
  }
}
