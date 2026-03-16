import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';
import 'package:order_manager/data/models/order_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OrderPage> {
  List<Order> orders = [];
  final List<Map<String, dynamic>> menu = [
    {"name": "Phở bò", "price": 50000},
    {"name": "Bún chả", "price": 45000},
    {"name": "Cơm tấm", "price": 40000},
    {"name": "Bánh mì", "price": 25000},
    {"name": "Nem rán", "price": 30000},
    {"name": "Gỏi cuốn", "price": 35000},
    {"name": "Nước ngọt", "price": 15000},
    {"name": "Nước chanh", "price": 20000},
    {"name": "Trà đá", "price": 5000},
  ];

  void _addFood(Order order) {
    _showAddFoodDialog(order);
  }

  void _showAddFoodDialog(Order order) {
    String? selectedFood;
    int quantity = 1;
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("Thêm món vào đơn"),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Món ăn"),

                    const SizedBox(height: 6),

                    DropdownButtonFormField<String>(
                      hint: const Text("Chọn món ăn"),
                      value: selectedFood,
                      items: menu.map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          value: item["name"],
                          child: Text("${item["name"]} - ${item["price"]}đ"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedFood = value;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    const Text("Số lượng"),

                    const SizedBox(height: 6),

                    TextFormField(
                      initialValue: "1",
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        quantity = int.tryParse(value) ?? 1;
                      },
                    ),

                    const SizedBox(height: 12),

                    const Text("Ghi chú"),

                    const SizedBox(height: 6),

                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        hintText: "Ghi chú (tùy chọn)",
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Hủy"),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (selectedFood == null) return;

                    setState(() {
                      order.totalItems += quantity;
                    });

                    KitchenStore.items.value.add(
                      KitchenItem(
                        foodName: selectedFood,
                        table: order.table,
                        staffId: order.staffId,
                        quantity: quantity,
                        createdAt: DateTime.now(),
                        status: KitchenStatus.pending,
                        orderId: order.id,
                      ),
                    );

                    KitchenStore.items.notifyListeners();

                    Navigator.pop(context);
                  },
                  child: const Text("Thêm món"),
                ),
              ],
            );
          },
        );
      },
    );
    KitchenStore.items.notifyListeners();
  }

  void _payOrder(Order order) {
    final tableItems = KitchenStore.items.value
        .where((item) => item.orderId == order.id)
        .toList();

    if (tableItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Đơn chưa có món nên không thể thanh toán"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    for (var item in tableItems) {
      item.status = KitchenStatus.paid;
    }

    KitchenStore.items.notifyListeners();

    setState(() {
      orders.remove(order);
    });
  }

  void _cancelOrder(Order order) {
    final hasReturnedFood = KitchenStore.items.value.any(
      (item) =>
          item.orderId == order.id && item.status == KitchenStatus.served,
    );

    if (hasReturnedFood) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Không thể hủy đơn vì đã có món được trả cho khách"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      orders.remove(order);

    for (var item in KitchenStore.items.value) {
  if (item.orderId == order.id) {
    item.status = KitchenStatus.cancelled;
  }
}

      KitchenStore.items.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            spacing: 16,
            children: [
              Icon(Icons.restaurant_menu, color: Colors.black),
              Text(
                "Quản lý đơn hàng",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quản lý đơn hàng',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Theo dõi và quản lý các đơn hàng theo bàn, trạng thái và thời gian.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.extended(
                    onPressed: _showCreateOrderDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Tạo đơn mới'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(orders[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bàn ${order.table} - ${order.id}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Nhân viên: ${order.staffName} (${order.staffId})",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tạo lúc: ${order.createdAt}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _addFood(order),
                    icon: const Icon(Icons.add),
                    label: const Text("Thêm món"),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () => _payOrder(order),
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    label: const Text(
                      "Thanh toán",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _cancelOrder(order),
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    label: const Text(
                      "Hủy đơn",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<List<KitchenItem>>(
            valueListenable: KitchenStore.items,
            builder: (context, items, _) {
              final tableItems = items
                  .where(
                    (item) =>
                        item.orderId == order.id &&
                        item.status != KitchenStatus.paid,
                  )
                  .toList();

              return Column(
                children: tableItems.map((item) {
                  int returned = item.status == KitchenStatus.served
                      ? item.quantity ?? 0
                      : 0;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.foodName ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: item.status.background,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item.status.text,
                                    style: TextStyle(
                                      color: item.status.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Đặt: ${item.quantity} đĩa | Trả: $returned đĩa",
                            ),

                            const SizedBox(height: 4),

                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16),
                                const SizedBox(width: 4),
                                Text(item.createdAt.toString()),
                              ],
                            ),
                          ],
                        ),

                        if (item.status != KitchenStatus.served &&
                            item.status != KitchenStatus.finished)
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                KitchenStore.items.value = List.from(
                                  KitchenStore.items.value,
                                )..remove(item);

                                order.totalItems -= 1;
                              });
                            },
                          ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<List<KitchenItem>>(
                valueListenable: KitchenStore.items,
                builder: (context, items, _) {
                  final totalReturned = items
                      .where(
                        (item) =>
                            item.orderId == order.id &&
                            item.status == KitchenStatus.served,
                      )
                      .fold<int>(0, (sum, item) => sum + (item.quantity ?? 0));

                  final totalOrdered = items
                      .where((item) => item.orderId == order.id)
                      .fold<int>(0, (sum, item) => sum + (item.quantity ?? 0));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tổng món: $totalOrdered"),
                      Text("Tổng đã đặt: $totalOrdered"),
                      Text("Tổng đã trả: $totalReturned"),
                      const SizedBox(height: 4),
                      Text(
                        "Cập nhật: ${DateTime.now()}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateOrderDialog() {
    final tableController = TextEditingController();
    final staffIdController = TextEditingController();
    final staffNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Tạo đơn hàng mới"),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tableController,
                  decoration: const InputDecoration(
                    labelText: "Số bàn",
                    hintText: "Nhập số bàn",
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: staffIdController,
                  decoration: const InputDecoration(
                    labelText: "Mã nhân viên",
                    hintText: "Nhập mã nhân viên",
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: staffNameController,
                  decoration: const InputDecoration(
                    labelText: "Tên nhân viên",
                    hintText: "Nhập tên nhân viên",
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Hủy"),
            ),

            ElevatedButton(
              onPressed: () {
                final table = int.tryParse(tableController.text) ?? 0;

                setState(() {
                  orders.add(
                    Order(
                      id: "ORD-${DateTime.now().millisecondsSinceEpoch}",
                      table: table,
                      staffId: staffIdController.text,
                      staffName: staffNameController.text,
                      createdAt: DateTime.now(),
                    ),
                  );
                });

                Navigator.pop(context);
              },
              child: const Text("Tạo đơn"),
            ),
          ],
        );
      },
    );
  }
}
