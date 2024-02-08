import 'package:equatable/equatable.dart';

class ReviewProductParameters extends Equatable {
  final String? name;
  final String? email;
  final int? rating;
  final String? review;
  final String? age;
  final String? adress;

  const ReviewProductParameters({
    this.name,
    this.email,
    this.rating,
    this.review,
    this.age,
    this.adress,
  });

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['rate'] = rating;
    data['age'] = age;
    data['review'] = review;
    data['adress'] = adress;
    return data;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
    email,
    rating,
    review,
    age,
    adress,
  ];

}
