// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workbench_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkbenchModel _$WorkbenchModelFromJson(Map<String, dynamic> json) =>
    WorkbenchModel(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      workbebchLodingDTO: (json['workbebchLodingDTO'] as List<dynamic>?)
          ?.map((e) => WorkbebchLodingDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryName: json['countryName'] as String?,
      transportationMode: json['transportationMode'],
      expended: json['expended'] as bool? ?? false,
      transportType: json['transportType'],
      ticketNo: json['ticketNo'],
      orderingAgencyId: json['orderingAgencyId'] as String?,
      orderingAgencyCode: json['orderingAgencyCode'] as String?,
      orderingAgencyName: json['orderingAgencyName'] as String?,
      transporterPartyType: json['transporterPartyType'] as String?,
      transporterAgencyId: json['transporterAgencyId'] as String?,
      transporterAgencyCode: json['transporterAgencyCode'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      transporterFullname: json['transporterFullname'] as String?,
      transporterUsername: json['transporterUsername'],
      transporterEmail: json['transporterEmail'] as String?,
      transporterMobile: json['transporterMobile'] as String?,
      receiverPartyType: json['receiverPartyType'],
      receiverAgencyId: json['receiverAgencyId'] as String?,
      receiverAgencyCode: json['receiverAgencyCode'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      receiverFullname: json['receiverFullname'] as String?,
      receiverUsername: json['receiverUsername'] as String?,
      receiverEmail: json['receiverEmail'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      receivedOn: json['receivedOn'],
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      baseAmount: json['baseAmount'],
      vatAmount: json['vatAmount'],
      grossAmount: (json['grossAmount'] as num?)?.toDouble(),
      cu: json['cu'] as String?,
      totalQuantity: json['totalQuantity'] as num?,
      bizOrderId: json['bizOrderId'],
      bizOrderRefno: json['bizOrderRefno'],
      bizOrderDate: json['bizOrderDate'],
      driverNames: json['driverNames'],
      driverUsernames: json['driverUsernames'],
      driverMobiles: json['driverMobiles'],
      inspectorAtLoadingPointFullname:
          json['inspectorAtLoadingPointFullname'] as String?,
      inspectorAtLoadingPointUsername:
          json['inspectorAtLoadingPointUsername'] as String?,
      inspectorAtLoadingPointEmail:
          json['inspectorAtLoadingPointEmail'] as String?,
      inspectorAtLoadingPointMobile:
          json['inspectorAtLoadingPointMobile'] as String?,
      inspectorRemarkAtLoadingPoint: json['inspectorRemarkAtLoadingPoint'],
      inspectorAtDropLocationFullname:
          json['inspectorAtDropLocationFullname'] as String?,
      inspectorAtDropLocationUsername:
          json['inspectorAtDropLocationUsername'] as String?,
      inspectorAtDropLocationEmail:
          json['inspectorAtDropLocationEmail'] as String?,
      inspectorAtDropLocationMobile:
          json['inspectorAtDropLocationMobile'] as String?,
      inspectorRemarkAtDropLocation: json['inspectorRemarkAtDropLocation'],
      sourceLocType: json['sourceLocType'] as String?,
      sourceLocId: json['sourceLocId'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      sourceLatitude: (json['sourceLatitude'] as num?)?.toDouble(),
      sourceLongitude: (json['sourceLongitude'] as num?)?.toDouble(),
      sourceWhId: json['sourceWhId'] as String?,
      sourceWhCode: json['sourceWhCode'] as String?,
      sourceWhName: json['sourceWhName'] as String?,
      sourceWhAddress: json['sourceWhAddress'] as String?,
      sourceWhManagerFullname: json['sourceWhManagerFullname'] as String?,
      sourceWhManagerUsername: json['sourceWhManagerUsername'] as String?,
      sourceWhManagerEmail: json['sourceWhManagerEmail'] as String?,
      sourceWhManagerMobile: json['sourceWhManagerMobile'] as String?,
      destinationLocId: json['destinationLocId'] as String?,
      destinationLocName: json['destinationLocName'] as String?,
      destinationLatitude: (json['destinationLatitude'] as num?)?.toDouble(),
      destinationLongitude: (json['destinationLongitude'] as num?)?.toDouble(),
      dropLocType: json['dropLocType'] as String?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      dropDistanceKm: (json['dropDistanceKm'] as num?)?.toDouble(),
      dropWhId: json['dropWhId'] as String?,
      dropWhCode: json['dropWhCode'] as String?,
      dropWhName: json['dropWhName'] as String?,
      dropWhAddress: json['dropWhAddress'] as String?,
      dropWhManagerFullname: json['dropWhManagerFullname'] as String?,
      dropWhManagerUsername: json['dropWhManagerUsername'] as String?,
      dropWhManagerEmail: json['dropWhManagerEmail'] as String?,
      dropWhManagerMobile: json['dropWhManagerMobile'] as String?,
      latestEtd: json['latestEtd'] as String?,
      esDate: json['esDate'],
      lsDate: json['lsDate'],
      travelPathId: json['travelPathId'] as String?,
      travelPathCode: json['travelPathCode'] as String?,
      travelPathName: json['travelPathName'] as String?,
      creatorFullname: json['creatorFullname'] as String?,
      creatorUsername: json['creatorUsername'] as String?,
      creatorEmail: json['creatorEmail'] as String?,
      creatorMobile: json['creatorMobile'] as String?,
      createdAt: json['createdAt'] as String?,
      editorFullname: json['editorFullname'],
      editorUsername: json['editorUsername'],
      editorEmail: json['editorEmail'],
      editorMobile: json['editorMobile'],
      lastEditedAt: json['lastEditedAt'],
      orderApproverCount: json['orderApproverCount'] as num?,
      approvedby1Fullname: json['approvedby1Fullname'],
      approvedby1Username: json['approvedby1Username'],
      approvedby1Email: json['approvedby1Email'],
      approvedby1Mobile: json['approvedby1Mobile'],
      approved1On: json['approved1On'],
      approvedby2Fullname: json['approvedby2Fullname'],
      approvedby2Username: json['approvedby2Username'],
      approvedby2Email: json['approvedby2Email'],
      approvedby2Mobile: json['approvedby2Mobile'],
      approved2On: json['approved2On'],
      approvedby3Fullname: json['approvedby3Fullname'],
      approvedby3Username: json['approvedby3Username'],
      approvedby3Email: json['approvedby3Email'],
      approvedby3Mobile: json['approvedby3Mobile'],
      approved3On: json['approved3On'],
      transporterAcceptorFullname: json['transporterAcceptorFullname'],
      transporterAcceptorUsername: json['transporterAcceptorUsername'],
      transporterAcceptorEmail: json['transporterAcceptorEmail'],
      transporterAcceptorMobile: json['transporterAcceptorMobile'],
      transporterAcceptorType: json['transporterAcceptorType'],
      transporterAcceptedOn: json['transporterAcceptedOn'],
      receivingPartyAcceptorFullname: json['receivingPartyAcceptorFullname'],
      receivingPartyAcceptorUsername: json['receivingPartyAcceptorUsername'],
      receivingPartyAcceptorEmail: json['receivingPartyAcceptorEmail'],
      receivingPartyAcceptorMobile: json['receivingPartyAcceptorMobile'],
      receivingPartyAcceptorType: json['receivingPartyAcceptorType'],
      receivingPartyAcceptedOn: json['receivingPartyAcceptedOn'],
      statusCode: json['statusCode'] as String?,
      status: json['status'] as String?,
      digest: json['digest'],
      remarks: json['remarks'],
      isInspectorAtSourceEnforced: json['isInspectorAtSourceEnforced'] as bool?,
      isVehicleReadinessEnforced: json['isVehicleReadinessEnforced'] as bool?,
      isRecipientReadinessEnforced:
          json['isRecipientReadinessEnforced'] as bool?,
      isInspectorAtDestinationEnforced:
          json['isInspectorAtDestinationEnforced'] as bool?,
      isReceivedByReceiverEnforced:
          json['isReceivedByReceiverEnforced'] as bool?,
      isTransportOrderOpen: json['isTransportOrderOpen'] as bool?,
      masterViewModel: json['masterViewModel'],
      singleDropLoc: json['singleDropLoc'] as bool?,
      singleDestinationLoc: json['singleDestinationLoc'] as bool?,
      approver2Passed: json['approver2Passed'] as bool?,
      approver3Passed: json['approver3Passed'] as bool?,
      approver1Passed: json['approver1Passed'] as bool?,
      acceptedByTransporter: json['acceptedByTransporter'] as bool?,
      acceptedByReceivingParty: json['acceptedByReceivingParty'] as bool?,
      singleReceiver: json['singleReceiver'] as bool?,
      acceptedByReceiver: json['acceptedByReceiver'] as bool?,
      transportingSingleBizOrder: json['transportingSingleBizOrder'] as bool?,
      singleInspectorAtDropLocation:
          json['singleInspectorAtDropLocation'] as bool?,
      baseAmtount: json['baseAmtount'] as num?,
      vaAmount: json['vaAmount'] as num?,
      registrationNo: json['registrationNo'] as String?,
      projectName: json['projectName'] as String?,
    );

Map<String, dynamic> _$WorkbenchModelToJson(WorkbenchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expended': instance.expended,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'transportationMode': instance.transportationMode,
      'transportType': instance.transportType,
      'ticketNo': instance.ticketNo,
      'orderingAgencyId': instance.orderingAgencyId,
      'orderingAgencyCode': instance.orderingAgencyCode,
      'orderingAgencyName': instance.orderingAgencyName,
      'transporterPartyType': instance.transporterPartyType,
      'transporterAgencyId': instance.transporterAgencyId,
      'transporterAgencyCode': instance.transporterAgencyCode,
      'transporterAgencyName': instance.transporterAgencyName,
      'transporterFullname': instance.transporterFullname,
      'transporterUsername': instance.transporterUsername,
      'transporterEmail': instance.transporterEmail,
      'transporterMobile': instance.transporterMobile,
      'receiverPartyType': instance.receiverPartyType,
      'receiverAgencyId': instance.receiverAgencyId,
      'receiverAgencyCode': instance.receiverAgencyCode,
      'receiverAgencyName': instance.receiverAgencyName,
      'receiverFullname': instance.receiverFullname,
      'receiverUsername': instance.receiverUsername,
      'receiverEmail': instance.receiverEmail,
      'receiverMobile': instance.receiverMobile,
      'receivedOn': instance.receivedOn,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'baseAmtount': instance.baseAmtount,
      'vaAmount': instance.vaAmount,
      'grossAmount': instance.grossAmount,
      'cu': instance.cu,
      'totalQuantity': instance.totalQuantity,
      'bizOrderId': instance.bizOrderId,
      'bizOrderRefno': instance.bizOrderRefno,
      'bizOrderDate': instance.bizOrderDate,
      'driverNames': instance.driverNames,
      'driverUsernames': instance.driverUsernames,
      'driverMobiles': instance.driverMobiles,
      'inspectorAtLoadingPointFullname':
          instance.inspectorAtLoadingPointFullname,
      'inspectorAtLoadingPointUsername':
          instance.inspectorAtLoadingPointUsername,
      'inspectorAtLoadingPointEmail': instance.inspectorAtLoadingPointEmail,
      'inspectorAtLoadingPointMobile': instance.inspectorAtLoadingPointMobile,
      'inspectorRemarkAtLoadingPoint': instance.inspectorRemarkAtLoadingPoint,
      'inspectorAtDropLocationFullname':
          instance.inspectorAtDropLocationFullname,
      'inspectorAtDropLocationUsername':
          instance.inspectorAtDropLocationUsername,
      'inspectorAtDropLocationEmail': instance.inspectorAtDropLocationEmail,
      'inspectorAtDropLocationMobile': instance.inspectorAtDropLocationMobile,
      'inspectorRemarkAtDropLocation': instance.inspectorRemarkAtDropLocation,
      'sourceLocType': instance.sourceLocType,
      'sourceLocId': instance.sourceLocId,
      'sourceLocName': instance.sourceLocName,
      'sourceLatitude': instance.sourceLatitude,
      'sourceLongitude': instance.sourceLongitude,
      'sourceWhId': instance.sourceWhId,
      'sourceWhCode': instance.sourceWhCode,
      'sourceWhName': instance.sourceWhName,
      'sourceWhAddress': instance.sourceWhAddress,
      'sourceWhManagerFullname': instance.sourceWhManagerFullname,
      'sourceWhManagerUsername': instance.sourceWhManagerUsername,
      'sourceWhManagerEmail': instance.sourceWhManagerEmail,
      'sourceWhManagerMobile': instance.sourceWhManagerMobile,
      'destinationLocId': instance.destinationLocId,
      'destinationLocName': instance.destinationLocName,
      'destinationLatitude': instance.destinationLatitude,
      'destinationLongitude': instance.destinationLongitude,
      'dropLocType': instance.dropLocType,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'dropDistanceKm': instance.dropDistanceKm,
      'dropWhId': instance.dropWhId,
      'dropWhCode': instance.dropWhCode,
      'dropWhName': instance.dropWhName,
      'dropWhAddress': instance.dropWhAddress,
      'dropWhManagerFullname': instance.dropWhManagerFullname,
      'dropWhManagerUsername': instance.dropWhManagerUsername,
      'dropWhManagerEmail': instance.dropWhManagerEmail,
      'dropWhManagerMobile': instance.dropWhManagerMobile,
      'latestEtd': instance.latestEtd,
      'esDate': instance.esDate,
      'lsDate': instance.lsDate,
      'travelPathId': instance.travelPathId,
      'travelPathCode': instance.travelPathCode,
      'travelPathName': instance.travelPathName,
      'creatorFullname': instance.creatorFullname,
      'creatorUsername': instance.creatorUsername,
      'creatorEmail': instance.creatorEmail,
      'creatorMobile': instance.creatorMobile,
      'createdAt': instance.createdAt,
      'editorFullname': instance.editorFullname,
      'editorUsername': instance.editorUsername,
      'editorEmail': instance.editorEmail,
      'editorMobile': instance.editorMobile,
      'lastEditedAt': instance.lastEditedAt,
      'orderApproverCount': instance.orderApproverCount,
      'approvedby1Fullname': instance.approvedby1Fullname,
      'approvedby1Username': instance.approvedby1Username,
      'approvedby1Email': instance.approvedby1Email,
      'approvedby1Mobile': instance.approvedby1Mobile,
      'approved1On': instance.approved1On,
      'approvedby2Fullname': instance.approvedby2Fullname,
      'approvedby2Username': instance.approvedby2Username,
      'approvedby2Email': instance.approvedby2Email,
      'approvedby2Mobile': instance.approvedby2Mobile,
      'approved2On': instance.approved2On,
      'approvedby3Fullname': instance.approvedby3Fullname,
      'approvedby3Username': instance.approvedby3Username,
      'approvedby3Email': instance.approvedby3Email,
      'approvedby3Mobile': instance.approvedby3Mobile,
      'approved3On': instance.approved3On,
      'transporterAcceptorFullname': instance.transporterAcceptorFullname,
      'transporterAcceptorUsername': instance.transporterAcceptorUsername,
      'transporterAcceptorEmail': instance.transporterAcceptorEmail,
      'transporterAcceptorMobile': instance.transporterAcceptorMobile,
      'transporterAcceptorType': instance.transporterAcceptorType,
      'transporterAcceptedOn': instance.transporterAcceptedOn,
      'receivingPartyAcceptorFullname': instance.receivingPartyAcceptorFullname,
      'receivingPartyAcceptorUsername': instance.receivingPartyAcceptorUsername,
      'receivingPartyAcceptorEmail': instance.receivingPartyAcceptorEmail,
      'receivingPartyAcceptorMobile': instance.receivingPartyAcceptorMobile,
      'receivingPartyAcceptorType': instance.receivingPartyAcceptorType,
      'receivingPartyAcceptedOn': instance.receivingPartyAcceptedOn,
      'statusCode': instance.statusCode,
      'status': instance.status,
      'digest': instance.digest,
      'remarks': instance.remarks,
      'baseAmount': instance.baseAmount,
      'vatAmount': instance.vatAmount,
      'isInspectorAtSourceEnforced': instance.isInspectorAtSourceEnforced,
      'isVehicleReadinessEnforced': instance.isVehicleReadinessEnforced,
      'isRecipientReadinessEnforced': instance.isRecipientReadinessEnforced,
      'isInspectorAtDestinationEnforced':
          instance.isInspectorAtDestinationEnforced,
      'isReceivedByReceiverEnforced': instance.isReceivedByReceiverEnforced,
      'isTransportOrderOpen': instance.isTransportOrderOpen,
      'masterViewModel': instance.masterViewModel,
      'singleDropLoc': instance.singleDropLoc,
      'singleDestinationLoc': instance.singleDestinationLoc,
      'approver2Passed': instance.approver2Passed,
      'approver3Passed': instance.approver3Passed,
      'approver1Passed': instance.approver1Passed,
      'acceptedByTransporter': instance.acceptedByTransporter,
      'acceptedByReceivingParty': instance.acceptedByReceivingParty,
      'singleReceiver': instance.singleReceiver,
      'acceptedByReceiver': instance.acceptedByReceiver,
      'transportingSingleBizOrder': instance.transportingSingleBizOrder,
      'singleInspectorAtDropLocation': instance.singleInspectorAtDropLocation,
      'registrationNo': instance.registrationNo,
      'projectName': instance.projectName,
      'workbebchLodingDTO': instance.workbebchLodingDTO,
    };

WorkbebchLodingDTO _$WorkbebchLodingDTOFromJson(Map<String, dynamic> json) =>
    WorkbebchLodingDTO(
      id: json['id'] as String?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      receiverFullname: json['receiverFullname'] as String?,
      receiverUsername: json['receiverUsername'] as String?,
      receiverEmail: json['receiverEmail'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      vehicleId: json['vehicleId'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'],
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      startSerialNo: json['startSerialNo'],
      finishSerialNo: json['finishSerialNo'],
      lineNo: json['lineNo'] as int?,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      productDescription: json['productDescription'] as String?,
      productBrand: json['productBrand'] as String?,
      baseUom: json['baseUom'] as String?,
      baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
      productColor: json['productColor'] as String?,
      productSize: json['productSize'] as String?,
      productSerial: json['productSerial'],
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      loadedAt: json['loadedAt'] as String?,
      loadedQuantity: (json['loadedQuantity'] as num?)?.toDouble(),
      droppedAt: json['droppedAt'],
      droppedQuantity: (json['droppedQuantity'] as num?)?.toDouble(),
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      receiverReadyAt: json['receiverReadyAt'] as String?,
      receiverRemarkWhileReady: json['receiverRemarkWhileReady'] as String?,
      receivedAt: json['receivedAt'],
      receivedQuantity: (json['receivedQuantity'] as num?)?.toDouble(),
      receiverRemarkWhileReceived: json['receiverRemarkWhileReceived'],
      inspectorFoundQuantityAtDroppingPoint:
          (json['inspectorFoundQuantityAtDroppingPoint'] as num?)?.toDouble(),
      inspectorRemarkAtDroppingPoint: json['inspectorRemarkAtDroppingPoint'],
      inspectorFullnameAtDroppingPoint:
          json['inspectorFullnameAtDroppingPoint'] as String?,
      inspectorUsernameAtDroppingPoint:
          json['inspectorUsernameAtDroppingPoint'] as String?,
      inspectorEmailAtDroppingPoint:
          json['inspectorEmailAtDroppingPoint'] as String?,
      inspectorMobileAtDroppingPoint:
          json['inspectorMobileAtDroppingPoint'] as String?,
      digest: json['digest'],
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      weightCapacityUnit: json['weightCapacityUnit'],
      dropped: json['dropped'] as bool?,
      foundItOkayAtDroppingPoint: json['foundItOkayAtDroppingPoint'] as bool?,
      vehicleReady: json['vehicleReady'] as bool?,
      receiverReady: json['receiverReady'] as bool?,
      vehicleStarted: json['vehicleStarted'] as bool?,
      received: json['received'] as bool?,
      loaded: json['loaded'] as bool?,
    );

Map<String, dynamic> _$WorkbebchLodingDTOToJson(WorkbebchLodingDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'receiverFullname': instance.receiverFullname,
      'receiverUsername': instance.receiverUsername,
      'receiverEmail': instance.receiverEmail,
      'receiverMobile': instance.receiverMobile,
      'vehicleId': instance.vehicleId,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'brand': instance.brand,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'startSerialNo': instance.startSerialNo,
      'finishSerialNo': instance.finishSerialNo,
      'lineNo': instance.lineNo,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'productBrand': instance.productBrand,
      'baseUom': instance.baseUom,
      'baseUomQuantity': instance.baseUomQuantity,
      'productColor': instance.productColor,
      'productSize': instance.productSize,
      'productSerial': instance.productSerial,
      'weightKg': instance.weightKg,
      'loadedAt': instance.loadedAt,
      'loadedQuantity': instance.loadedQuantity,
      'droppedAt': instance.droppedAt,
      'droppedQuantity': instance.droppedQuantity,
      'distanceKm': instance.distanceKm,
      'receiverReadyAt': instance.receiverReadyAt,
      'receiverRemarkWhileReady': instance.receiverRemarkWhileReady,
      'receivedAt': instance.receivedAt,
      'receivedQuantity': instance.receivedQuantity,
      'receiverRemarkWhileReceived': instance.receiverRemarkWhileReceived,
      'inspectorFoundQuantityAtDroppingPoint':
          instance.inspectorFoundQuantityAtDroppingPoint,
      'inspectorRemarkAtDroppingPoint': instance.inspectorRemarkAtDroppingPoint,
      'inspectorFullnameAtDroppingPoint':
          instance.inspectorFullnameAtDroppingPoint,
      'inspectorUsernameAtDroppingPoint':
          instance.inspectorUsernameAtDroppingPoint,
      'inspectorEmailAtDroppingPoint': instance.inspectorEmailAtDroppingPoint,
      'inspectorMobileAtDroppingPoint': instance.inspectorMobileAtDroppingPoint,
      'digest': instance.digest,
      'weightCapacity': instance.weightCapacity,
      'weightCapacityUnit': instance.weightCapacityUnit,
      'dropped': instance.dropped,
      'foundItOkayAtDroppingPoint': instance.foundItOkayAtDroppingPoint,
      'vehicleReady': instance.vehicleReady,
      'receiverReady': instance.receiverReady,
      'vehicleStarted': instance.vehicleStarted,
      'received': instance.received,
      'loaded': instance.loaded,
    };
