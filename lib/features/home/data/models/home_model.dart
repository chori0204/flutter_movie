import '../../domain/entities/home.dart';

class HomeModel extends Home {
  HomeModel({required int id, required String name}) : super(id: id, name: name);

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
