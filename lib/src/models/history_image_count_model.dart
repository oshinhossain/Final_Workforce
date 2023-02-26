import 'dart:io';

class HistoryImageModel {
  String progressId;
  String imageCount;
  String status;
  HistoryImageModel(
      {required this.progressId,
      required this.imageCount,
      required this.status});
}

class TestImageModel {
  String criteriaId;

  List<File> images;
  TestImageModel({
    required this.criteriaId,
    required this.images,
  });
}

class AllImagesModel {
  String progressId;
  String status;
  List<String> images;
  AllImagesModel(
      {required this.progressId, required this.images, required this.status});
}

class VechicleImageModel {
  String regNo;
  String imageCount;

  VechicleImageModel({
    required this.regNo,
    required this.imageCount,
  });
}
