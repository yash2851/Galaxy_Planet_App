import 'dart:convert';

List<PlanetModel> planetModelFromJson(String str) => List<PlanetModel>.from(
    json.decode(str).map((x) => PlanetModel.fromJson(x)));

String planetModelToJson(List<PlanetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanetModel {
  String no;
  String name;
  String diameter;
  String leanthOfYear;
  String leanthOfDay;
  String numberOfMoons;
  String temperature;
  String surfaceArea;
  String gravity;
  String velocity;
  String distance;
  String description;
  String image;
  String hero;
  List<String> images;

  PlanetModel({
    required this.no,
    required this.name,
    required this.diameter,
    required this.leanthOfYear,
    required this.leanthOfDay,
    required this.numberOfMoons,
    required this.temperature,
    required this.surfaceArea,
    required this.gravity,
    required this.velocity,
    required this.distance,
    required this.description,
    required this.image,
    required this.hero,
    required this.images,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
        no: json["no"],
        name: json["name"],
        diameter: json["diameter"],
        leanthOfYear: json["leanthOfYear"],
        leanthOfDay: json["leanthOfDay"],
        numberOfMoons: json["numberOfMoons"],
        temperature: json["temperature"],
        surfaceArea: json["surfaceArea"],
        gravity: json["gravity"],
        velocity: json["velocity"],
        distance: json["distance"],
        description: json["description"],
        image: json["image"],
        hero: json["hero"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "name": name,
        "diameter": diameter,
        "leanthOfYear": leanthOfYear,
        "leanthOfDay": leanthOfDay,
        "numberOfMoons": numberOfMoons,
        "temperature": temperature,
        "surfaceArea": surfaceArea,
        "gravity": gravity,
        "velocity": velocity,
        "distance": distance,
        "description": description,
        "image": image,
        "hero": hero,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
} /*
List<PlanetModel> planetModel=[
  PlanetModel(no: , name: , diameter: , leanthOfYear: , leanthOfDay: , numberOfMoons: , temperature: , surfaceArea: , gravity: , velocity: , distance: , description: , image: , hero: , images: )
];*/
