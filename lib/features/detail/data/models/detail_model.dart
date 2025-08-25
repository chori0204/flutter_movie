import '../../domain/entities/detail.dart';

class DetailModel extends Detail {
  DetailModel({required int id, required String name}) : super(id: id, name: name);

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
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
