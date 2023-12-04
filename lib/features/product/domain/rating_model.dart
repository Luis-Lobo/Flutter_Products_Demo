import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel extends Equatable {
  @JsonKey(name: 'rate')
  final double rate;

  @JsonKey(name: 'count')
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(
          {required Map<String, dynamic> json}) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  @override
  List<Object> get props => [rate, count];
}
