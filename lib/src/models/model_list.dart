import 'package:json_annotation/json_annotation.dart';
part 'model_list.g.dart';

@JsonSerializable()
class ModelList {
  String? id;
  String? remarks;
  String? verifyResult;

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
  String? equipmentHeightFt;
  String? equipmentAzimuthDeg;
  String? equipmentTiltDeg;
  String? coverageRadiusMtr;
  String? frequencyGhz;
  String? frequencyGhz2;
  String? connectionCapacity;
  String? capacityDescr;
  String? technologyStandard;
  String? sfpPorts;
  String? ethPorts;
  String? poePorts;
  String? casingSpec;
  String? casingCount;
  String? cableUnpackerSpec;
  String? cableUnpackerCount;
  String? mcSpec;
  String? mcCount;
  String? ethPatchCordSpec;
  String? ethPatchCordCount;
  String? fiberPatchSpec;
  String? fiberPatchCount;
  String? fiberJpSpec;
  String? fiberJpCount;
  String? pigtailSpec;
  String? pigtailCount;
  String? clampSpec;
  String? clampCount;

  String? supplierAgencyId;
  String? supplierAgencyCode;
  String? supplierAgencyName;
  String? installedOn;
  String? onairDate;
  String? deviceCondition;
  String? areaType;
  String? areaLevel;
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
  String? latitude;
  String? longitude;
  String? altitudeMtr;
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
  String? upstreamLinkMbps;
  String? upstreamLinkType;
  String? upstreamLinkProvider;
  String? integrationMethod;
  String? externalSystem;
  String? externalSystemId;
  String? externalSystemCode;
  String? externalSystemName;
  String? externalSystemIp;
  String? externalSystemType;
  String? externalSystemOs;
  String? apiEnabled;
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
  String? snmpUdpPort;
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
  String? processorClockGhz;
  String? processors;
  String? processorCores;
  String? processorCacheGb;
  String? oidProcessorName;
  String? oidProcessorClockGhz;
  String? oidProcessors;
  String? oidProcessorCores;
  String? oidProcessorCacheGb;
  String? inputPowerRating;
  String? inputPowerVoltage;
  String? inputPowerCurrent;
  String? inputPowerFreq;
  String? oidInputPowerRating;
  String? oidInputPowerVoltage;
  String? oidInputPowerCurrent;
  String? oidInputPowerFreq;
  String? memoryRamType;
  String? memoryRamSizeGb;
  String? memoryHddType;
  String? memoryHddSizeTb;
  String? oidMemoryRamType;
  String? oidMemoryRamSize;
  String? oidMemoryHddType;
  String? oidMemoryHddSize;
  String? powerOutputRating;
  String? oidPowerOutputRating;
  String? poleType;
  String? placeType;
  String? powerSource;
  String? custodianUsername;
  String? custodianFullname;
  String? custodianMobile;
  String? custodianEmail;
  String? custodianNid;
  String? custodianMonthlyRent;
  String? custodianAddress;

  ModelList(
      {this.id,
      this.remarks,
      this.verifyResult,
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
      this.externalSystem,
      this.externalSystemId,
      this.externalSystemCode,
      this.externalSystemName,
      this.externalSystemIp,
      this.externalSystemType,
      this.externalSystemOs,
      this.apiEnabled,
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
      this.custodianUsername,
      this.custodianFullname,
      this.custodianMobile,
      this.custodianEmail,
      this.custodianNid,
      this.custodianMonthlyRent,
      this.custodianAddress});

  factory ModelList.fromJson(Map<String, dynamic> json) => _$ModelListFromJson(json);
  Map<String, dynamic> toJson() => _$ModelListToJson(this);
}
