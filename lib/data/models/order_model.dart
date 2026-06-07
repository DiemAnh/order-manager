import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/food_model.dart';
import 'dart:collection';

class Order {
  String? id;
  int? table;
  int totalItems;
  int? totalPaid;
  KitchenStatus status;
  DateTime createdAt;
  String? staffName;
  String? staffId;
  LinkedList<FoodItem> foods;

  Order({
    required this.id,
    required this.table,
    this.totalItems = 0,
    this.totalPaid = 0,
    this.status = KitchenStatus.pending,
    required this.createdAt,
    this.staffName,
    this.staffId,
    LinkedList<FoodItem>? foods
  }) : foods = foods ?? LinkedList<FoodItem>();
}