import 'package:equatable/equatable.dart';

class PaginationModel extends Equatable {
  final int? currentPage;
  final int? lastPage;
  final int? total;

  const PaginationModel({
    this.currentPage,
    this.lastPage,
    this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    currentPage,
    lastPage,
    total,
  ];
}
