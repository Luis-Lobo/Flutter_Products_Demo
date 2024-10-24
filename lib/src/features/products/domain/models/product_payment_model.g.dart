// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPaymentModel _$ProductPaymentModelFromJson(Map<String, dynamic> json) =>
    ProductPaymentModel(
      cardNumber: json['cardNumber'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expirationDate: json['expirationDate'] as String,
      securityCode: json['securityCode'] as String,
    );

Map<String, dynamic> _$ProductPaymentModelToJson(
        ProductPaymentModel instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'expirationDate': instance.expirationDate,
      'securityCode': instance.securityCode,
    };
