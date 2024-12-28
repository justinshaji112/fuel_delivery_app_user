// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubService {
  String name;
  String discription;
  String duration;
  double price;

  SubService({
    required this.name,
    required this.discription,
    required this.duration,
    required this.price,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      name: json['name'] as String,
      price: double.parse(json['price'].toString()),
      discription: json['discription'] as String,
      duration: json['duration'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'discription': discription,
      'duration': duration
    };
  }
}

class Service {
  String? id;
  String name;
  String description;
  String imageUrl;
  List<SubService> subServices;

  Service({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.subServices = const [],
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      subServices: (json['subServices'] as List<dynamic>?)
              ?.map((e) => SubService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'subServices': subServices.map((e) => e.toJson()).toList(),
    };
  }
}
