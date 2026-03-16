import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/order_model.dart';

class KitchenStore {
  static ValueNotifier<List<KitchenItem>> items =
      ValueNotifier<List<KitchenItem>>([]);
}

class KitchenItem {
  String? foodName;
  int? table;
  String? staffId;
  int? quantity;
  DateTime createdAt;
  KitchenStatus status;
  String? orderId;

  KitchenItem({
    this.foodName,
    this.table,
    this.staffId,
    this.quantity,
    required this.createdAt,
    required this.status,
    this.orderId,
  });
}
