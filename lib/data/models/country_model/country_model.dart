

import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final String? createdAt;
  final String? updatedAt;

  const CountryModel({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, code, createdAt, updatedAt,];

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}