import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String? id;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  const NotificationModel({
    this.id,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [id, message, createdAt, updatedAt];
}
