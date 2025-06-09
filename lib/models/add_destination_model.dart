
import 'package:dio/dio.dart';

class AddDestinationModel {
  String name;
  String description;
  String location;
  String category;
  int availableNumber;
  DateTime startDate;
  DateTime endDate;
  double discount;
  double cost;
  List<MultipartFile> imageData;

  AddDestinationModel({
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.availableNumber,
    required this.startDate,
    required this.endDate,
    required this.discount,
    required this.cost,
    required this.imageData,
  });

  Map<String, String> toJsonFields() => {
    'Name': name,
    'Description': description,
    'Location': location,
    'Category': category,
    'AvilableNumber': availableNumber.toString(),
    'StartDate': startDate.toIso8601String(),
    'EndtDate': endDate.toIso8601String(),
    'Discount': discount.toString(),
    'Cost': cost.toString(),
    'ImageData': imageData.toString(),
  };
  FormData formData() => FormData.fromMap({
    'Name': name,
    'Description': description,
    'Location': location,
    'Category': category,
    'AvilableNumber': availableNumber,
    'StartDate': startDate.toIso8601String(),
    'EndtDate': endDate.toIso8601String(),
    'Discount': discount,
    'Cost': cost,
    'ImageData': imageData, // array of multipart files
  });
}
