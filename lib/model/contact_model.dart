import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ContactModel {
  RxString id;
  RxString name;
  RxString number;

  ContactModel({
    required this.id,
    required this.name,
    required this.number,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"].toString().obs,
        name: json["name"].toString().obs,
        number: json["number"].toString().obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id.value,
        "name": name.value,
        "number": number.value,
      };
}
