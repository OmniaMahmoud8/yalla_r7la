import 'image.dart';

class GetDestination {
  String? destinationId;
  String? name;
  String? description;
  String? location;
  String? category;
  String? startDate;
  String? endtDate;
  double? discount;
  dynamic averageRating;
  double? cost;
  int? avilableNumber;
  List<Image>? images;

  GetDestination({
    this.destinationId,
    this.name,
    this.description,
    this.location,
    this.category,
    this.startDate,
    this.endtDate,
    this.discount,
    this.averageRating,
    this.cost,
    this.avilableNumber,
    this.images,
  });

  factory GetDestination.fromJson(Map<String, dynamic> json) {
    return GetDestination(
      destinationId: json['destinationId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      category: json['category'] as String?,
      startDate: json['startDate'] as String?,
      endtDate: json['endtDate'] as String?,
      discount: json['discount'] as double?,
      averageRating: json['averageRating'] as dynamic,
      cost: (json['cost'] as num?)?.toDouble(),
      avilableNumber: json['avilableNumber'] as int?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'destinationId': destinationId,
    'name': name,
    'description': description,
    'location': location,
    'category': category,
    'startDate': startDate,
    'endtDate': endtDate,
    'discount': discount,
    'averageRating': averageRating,
    'cost': cost,
    'avilableNumber': avilableNumber,
    'images': images?.map((e) => e.toJson()).toList(),
  };
}
