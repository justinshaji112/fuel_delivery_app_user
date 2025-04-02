import 'dart:convert';



// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarouselModel {
  String? id;
  String title;
  String subTitle;
  String image;
  int weight;
  CarouselModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.weight,
  });
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'title': title,
      'subTitle': subTitle,
      'image': image,
      'weight': weight,
    };
  }

  factory CarouselModel.fromMap(Map<String, dynamic> map) {
    return CarouselModel(
      id:map["id"],
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      image: map['image'] as String,
      weight: map['weight'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarouselModel.fromJson(String source) => CarouselModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
