import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'dart:collection';

class KitchenStore {
  static ValueNotifier<LinkedList<KitchenItem>> items =
      ValueNotifier<LinkedList<KitchenItem>>(LinkedList<KitchenItem>());
}

final class KitchenItem extends LinkedListEntry<KitchenItem> {
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
