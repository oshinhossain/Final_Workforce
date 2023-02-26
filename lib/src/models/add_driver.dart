import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddDriver {
  String? name;
  String? city;
  String? time;
  String? rides;
  String? dType;
  String? vType;
  String? ratting;
  String? imgPath;
  bool value;

  AddDriver({
    this.name,
    this.city,
    this.time,
    this.rides,
    this.dType,
    this.vType,
    this.ratting,
    this.imgPath,
    this.value = false,
  });

  static List<AddDriver> fetchAll() {
    return [
      AddDriver(
          name: 'Shakhowat Mia',
          city: 'Dhaka',
          time: '6:00am-6:00pm',
          rides: '3455km',
          dType: 'Professional',
          vType: 'Truck,Pickup',
          ratting: '4.9',
          imgPath: 'assets/img/driver.png',
          value: true),
      AddDriver(
          name: 'Arifur Rahman',
          city: 'Dhaka',
          time: '6:00am-6:00pm',
          rides: '3455km',
          dType: 'Unprofessional',
          vType: 'Truck',
          ratting: '5',
          imgPath: 'assets/img/driver_1.png',
          value: false),
      AddDriver(
          name: 'Rakib Hasan',
          city: 'Dhaka',
          time: '6:00am-6:00pm',
          rides: '3455km',
          dType: 'Professional',
          vType: 'Truck,Bus',
          ratting: '3.5',
          imgPath: 'assets/img/driver_2.png',
          value: false),
      AddDriver(
          name: 'Joynal Abedin',
          city: 'Dhaka',
          time: '6:00am-6:00pm',
          rides: '3455km',
          dType: 'Unprofessional',
          vType: 'Car',
          ratting: '4.2',
          imgPath: 'assets/img/driver_3.png',
          value: false),
    ];
  }
}
