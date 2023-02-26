import 'package:json_annotation/json_annotation.dart';

part 'appliances.g.dart';

@JsonSerializable()
class Appliances {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? deviceCode;
  String? deviceName;
  String? deviceIp;
  String? deviceMac;
  String? deviceSerial;
  String? deviceTypeCode;
  String? deviceTypeName;
  String? deviceModel;
  String? operatingSystem;
  num? equipmentHeightFt;
  num? equipmentAzimuthDeg;
  num? equipmentTiltDeg;
  num? coverageRadiusMtr;
  num? frequencyGhz;
  num? frequencyGhz2;
  num? connectionCapacity;
  String? capacityDescr;
  String? technologyStandard;
  num? sfpPorts;
  num? ethPorts;
  num? poePorts;
  String? casingSpec;
  num? casingCount;
  String? cableUnpackerSpec;
  num? cableUnpackerCount;
  String? mcSpec;
  num? mcCount;
  String? ethPatchCordSpec;
  num? ethPatchCordCount;
  String? fiberPatchSpec;
  num? fiberPatchCount;
  String? fiberJpSpec;
  num? fiberJpCount;
  String? pigtailSpec;
  num? pigtailCount;
  String? clampSpec;
  num? clampCount;
  String? remarks;
  String? supplierAgencyId;
  String? supplierAgencyCode;
  String? supplierAgencyName;
  String? installedOn;
  String? onairDate;
  String? deviceCondition;
  String? areaType;
  num? areaLevel;
  String? countryCode;
  String? countryName;
  String? geoLevel1Id;
  String? geoLevel1Code;
  String? geoLevel1Name;
  String? geoLevel2Id;
  String? geoLevel2Code;
  String? geoLevel2Name;
  String? geoLevel3Id;
  String? geoLevel3Code;
  String? geoLevel3Name;
  String? geoLevel4Id;
  String? geoLevel4Code;
  String? geoLevel4Name;
  String? geoLevel5Id;
  String? geoLevel5Code;
  String? geoLevel5Name;
  String? levelType;
  String? levelFullcode;
  String? siteType;
  String? siteCode;
  String? siteName;
  String? siteAddress;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? linkId;
  String? linkCode;
  String? linkName;
  String? linkType;
  String? connectedLinkPoint;
  String? connectedLinkPointName;
  String? upstreamDeviceId;
  String? upstreamDeviceCode;
  String? upstreamDeviceIp;
  String? upstreamDeviceType;
  num? upstreamLinkMbps;
  String? upstreamLinkType;
  String? upstreamLinkProvider;
  String? integrationMethod;
  String? externalSystemId;
  String? externalSystemCode;
  String? externalSystemName;
  String? externalSystemIp;
  String? externalSystemType;
  String? externalSystemOs;
  String? extSysIntegrationMethod;
  String? extSysWebApiCreateUserString;
  String? extSysWebApiRemoveUserString;
  String? extSysWebApiCreatePermissionString;
  String? extSysWebApiRemovePermissionString;
  String? extSysSshServerUser;
  String? extSysSshServerPwd;
  String? extSysSshCommandCreateUser;
  String? extSysSshCommandRemoveUser;
  String? extSysSshCommandGrantPermission;
  String? extSysSshCommandRemovePermission;
  String? extSysWebApiCreateUserSuccessStrVariable;
  String? extSysWebApiCreateUserSuccessStrValue;
  String? extSysWebApiRemoveUserSuccessStrVariable;
  String? extSysWebApiRemoveUserSuccessStrValue;
  String? extSysWebApiGrantUserPermissionSuccessStrVariable;
  String? extSysWebApiGrantUserPermissionSuccessStrValue;
  String? extSysWebApiRemoveUserPermissionSuccessStrVariable;
  String? extSysWebApiRemoveUserPermissionSuccessStrValue;
  String? snmpVersion;
  num? snmpUdpPort;
  String? snmpCommunityStringAdmin;
  String? snmpCommunityStringReadonly;
  String? snmpSecurityLevel;
  String? snmpAuth;
  String? snmpEncryption;
  String? snmpUsername;
  String? snmpGroup;
  String? snmpPassword;
  String? snmpConnectStyle;
  String? oidBatteryCapacityPct;
  String? oidBatteryTemperature;
  String? oidBatteryRemainingMin;
  String? oidBatterySupplyType;
  String? batteryOnlineStatusValue;
  String? batteryOfflineStatusValue;
  String? oidBatteryReplacementNeeded;
  String? batteryReplacementValue;
  String? oidOutputPower;
  String? oidOutputVoltage;
  String? oidOutputCurrent;
  String? oidOutputFreq;
  String? oidOutputLoad;
  String? oidInputPower;
  String? oidInputVoltage;
  String? oidInputCurrent;
  String? oidInputFreq;
  String? processorName;
  num? processorClockGhz;
  num? processors;
  num? processorCores;
  num? processorCacheGb;
  String? oidProcessorName;
  String? oidProcessorClockGhz;
  String? oidProcessors;
  String? oidProcessorCores;
  String? oidProcessorCacheGb;
  num? inputPowerRating;
  num? inputPowerVoltage;
  num? inputPowerCurrent;
  num? inputPowerFreq;
  String? oidInputPowerRating;
  String? oidInputPowerVoltage;
  String? oidInputPowerCurrent;
  String? oidInputPowerFreq;
  String? memoryRamType;
  num? memoryRamSizeGb;
  String? memoryHddType;
  num? memoryHddSizeTb;
  String? oidMemoryRamType;
  String? oidMemoryRamSize;
  String? oidMemoryHddType;
  String? oidMemoryHddSize;
  num? powerOutputRating;
  String? oidPowerOutputRating;
  String? poleType;
  String? placeType;
  String? powerSource;
  String? digest;
  @JsonKey(name: 'custodian_username')
  String? custodianUsername;
  @JsonKey(name: 'custodian_fullname')
  String? custodianFullname;
  @JsonKey(name: 'custodian_mobile')
  String? custodianMobile;
  @JsonKey(name: 'custodian_email')
  String? custodianEmail;
  @JsonKey(name: 'custodian_nid')
  String? custodianNid;
  @JsonKey(name: 'custodian_monthly_rent')
  num? custodianMonthlyRent;
  @JsonKey(name: 'custodian_address')
  String? custodianAddress;
  String? masterViewModel;
  bool? externalSystem;
  bool? apiEnabled;

  Appliances(
      {this.id,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.deviceCode,
      this.deviceName,
      this.deviceIp,
      this.deviceMac,
      this.deviceSerial,
      this.deviceTypeCode,
      this.deviceTypeName,
      this.deviceModel,
      this.operatingSystem,
      this.equipmentHeightFt,
      this.equipmentAzimuthDeg,
      this.equipmentTiltDeg,
      this.coverageRadiusMtr,
      this.frequencyGhz,
      this.frequencyGhz2,
      this.connectionCapacity,
      this.capacityDescr,
      this.technologyStandard,
      this.sfpPorts,
      this.ethPorts,
      this.poePorts,
      this.casingSpec,
      this.casingCount,
      this.cableUnpackerSpec,
      this.cableUnpackerCount,
      this.mcSpec,
      this.mcCount,
      this.ethPatchCordSpec,
      this.ethPatchCordCount,
      this.fiberPatchSpec,
      this.fiberPatchCount,
      this.fiberJpSpec,
      this.fiberJpCount,
      this.pigtailSpec,
      this.pigtailCount,
      this.clampSpec,
      this.clampCount,
      this.remarks,
      this.supplierAgencyId,
      this.supplierAgencyCode,
      this.supplierAgencyName,
      this.installedOn,
      this.onairDate,
      this.deviceCondition,
      this.areaType,
      this.areaLevel,
      this.countryCode,
      this.countryName,
      this.geoLevel1Id,
      this.geoLevel1Code,
      this.geoLevel1Name,
      this.geoLevel2Id,
      this.geoLevel2Code,
      this.geoLevel2Name,
      this.geoLevel3Id,
      this.geoLevel3Code,
      this.geoLevel3Name,
      this.geoLevel4Id,
      this.geoLevel4Code,
      this.geoLevel4Name,
      this.geoLevel5Id,
      this.geoLevel5Code,
      this.geoLevel5Name,
      this.levelType,
      this.levelFullcode,
      this.siteType,
      this.siteCode,
      this.siteName,
      this.siteAddress,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.linkId,
      this.linkCode,
      this.linkName,
      this.linkType,
      this.connectedLinkPoint,
      this.connectedLinkPointName,
      this.upstreamDeviceId,
      this.upstreamDeviceCode,
      this.upstreamDeviceIp,
      this.upstreamDeviceType,
      this.upstreamLinkMbps,
      this.upstreamLinkType,
      this.upstreamLinkProvider,
      this.integrationMethod,
      this.externalSystemId,
      this.externalSystemCode,
      this.externalSystemName,
      this.externalSystemIp,
      this.externalSystemType,
      this.externalSystemOs,
      this.extSysIntegrationMethod,
      this.extSysWebApiCreateUserString,
      this.extSysWebApiRemoveUserString,
      this.extSysWebApiCreatePermissionString,
      this.extSysWebApiRemovePermissionString,
      this.extSysSshServerUser,
      this.extSysSshServerPwd,
      this.extSysSshCommandCreateUser,
      this.extSysSshCommandRemoveUser,
      this.extSysSshCommandGrantPermission,
      this.extSysSshCommandRemovePermission,
      this.extSysWebApiCreateUserSuccessStrVariable,
      this.extSysWebApiCreateUserSuccessStrValue,
      this.extSysWebApiRemoveUserSuccessStrVariable,
      this.extSysWebApiRemoveUserSuccessStrValue,
      this.extSysWebApiGrantUserPermissionSuccessStrVariable,
      this.extSysWebApiGrantUserPermissionSuccessStrValue,
      this.extSysWebApiRemoveUserPermissionSuccessStrVariable,
      this.extSysWebApiRemoveUserPermissionSuccessStrValue,
      this.snmpVersion,
      this.snmpUdpPort,
      this.snmpCommunityStringAdmin,
      this.snmpCommunityStringReadonly,
      this.snmpSecurityLevel,
      this.snmpAuth,
      this.snmpEncryption,
      this.snmpUsername,
      this.snmpGroup,
      this.snmpPassword,
      this.snmpConnectStyle,
      this.oidBatteryCapacityPct,
      this.oidBatteryTemperature,
      this.oidBatteryRemainingMin,
      this.oidBatterySupplyType,
      this.batteryOnlineStatusValue,
      this.batteryOfflineStatusValue,
      this.oidBatteryReplacementNeeded,
      this.batteryReplacementValue,
      this.oidOutputPower,
      this.oidOutputVoltage,
      this.oidOutputCurrent,
      this.oidOutputFreq,
      this.oidOutputLoad,
      this.oidInputPower,
      this.oidInputVoltage,
      this.oidInputCurrent,
      this.oidInputFreq,
      this.processorName,
      this.processorClockGhz,
      this.processors,
      this.processorCores,
      this.processorCacheGb,
      this.oidProcessorName,
      this.oidProcessorClockGhz,
      this.oidProcessors,
      this.oidProcessorCores,
      this.oidProcessorCacheGb,
      this.inputPowerRating,
      this.inputPowerVoltage,
      this.inputPowerCurrent,
      this.inputPowerFreq,
      this.oidInputPowerRating,
      this.oidInputPowerVoltage,
      this.oidInputPowerCurrent,
      this.oidInputPowerFreq,
      this.memoryRamType,
      this.memoryRamSizeGb,
      this.memoryHddType,
      this.memoryHddSizeTb,
      this.oidMemoryRamType,
      this.oidMemoryRamSize,
      this.oidMemoryHddType,
      this.oidMemoryHddSize,
      this.powerOutputRating,
      this.oidPowerOutputRating,
      this.poleType,
      this.placeType,
      this.powerSource,
      this.digest,
      this.custodianUsername,
      this.custodianFullname,
      this.custodianMobile,
      this.custodianEmail,
      this.custodianNid,
      this.custodianMonthlyRent,
      this.custodianAddress,
      this.masterViewModel,
      this.externalSystem,
      this.apiEnabled});

  factory Appliances.fromJson(Map<String, dynamic> json) => _$AppliancesFromJson(json);
  Map<String, dynamic> toJson() => _$AppliancesToJson(this);
}
