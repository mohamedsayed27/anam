import 'package:equatable/equatable.dart';

class StatusModel extends Equatable {
  final int? id;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const StatusModel({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, status, createdAt, updatedAt];

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
