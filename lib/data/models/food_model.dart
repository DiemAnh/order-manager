class FoodItem {
  String id;
  String name;
  int ordered;
  int paid;
  String status;

  DateTime createdAt;
  DateTime updatedAt;

  FoodItem({
    required this.id,
    required this.name,
    required this.ordered,
    this.paid = 0,
    this.status = "Mới tạo",
    required this.createdAt,
    required this.updatedAt,
  });
}