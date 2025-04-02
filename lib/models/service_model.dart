import 'dart:convert';



class ServiceModel {
  String? id;
  String name;
  String description;
  String imageUrl;
  List<SubServiceModel> subServices;
  ServiceModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.subServices,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'subServices': subServices.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      subServices: List<SubServiceModel>.from(
        (map['subServices'] as List<dynamic>).map<SubServiceModel>(
          (x) => SubServiceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SubServiceModel {
  String name;
  String discription;
  String duration;
  double price;
  SubServiceModel({
    required this.name,
    required this.discription,
    required this.duration,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'discription': discription,
      'duration': duration,
      'price': price,
    };
  }

  factory SubServiceModel.fromMap(Map<String, dynamic> map) {
    return SubServiceModel(
      name: map['name'] as String,
      discription: map['discription'] as String,
      duration: map['duration'] as String,
      price: map['price'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubServiceModel.fromJson(String source) =>
      SubServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



// key =
// "subServices"
// value =
// List (2 items)
// [0] =
// Map (4 items)
// 0 =
// "duration" -> "1-2 hours"
// 1 =
// "discription" -> "sadf"
// 2 =
// "price" -> 20
// 3 =
// "name" -> "Quicq repir"
// [1] =
// Map (4 items)