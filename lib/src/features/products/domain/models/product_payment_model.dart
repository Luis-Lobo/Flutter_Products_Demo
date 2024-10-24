import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_payment_model.g.dart';

@JsonSerializable()
class ProductPaymentModel extends Equatable {
  @JsonKey(name: 'cardNumber')
  final String cardNumber;

  @JsonKey(name: 'cardHolderName')
  final String cardHolderName;

  @JsonKey(name: 'expirationDate')
  final String expirationDate;

  @JsonKey(name: 'securityCode')
  final String securityCode;

  const ProductPaymentModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirationDate,
    required this.securityCode,
  });

  factory ProductPaymentModel.fromJson(Map<String, dynamic> json) => _$ProductPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPaymentModelToJson(this);

  @override
  List<Object> get props => [cardNumber, cardHolderName, expirationDate, securityCode,];
}
