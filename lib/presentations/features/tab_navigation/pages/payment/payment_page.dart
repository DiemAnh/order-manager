import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final Map<String, int> menuPrice = {
    "Phở bò": 50000,
    "Bún chả": 45000,
    "Cơm tấm": 40000,
    "Bánh mì": 25000,
    "Nem rán": 30000,
    "Gỏi cuốn": 35000,
    "Nước ngọt": 15000,
    "Nước chanh": 20000,
    "Trà đá": 5000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: const [
            Icon(Icons.restaurant_menu, color: Colors.black),
            SizedBox(width: 16),
            Text(
              "Thanh toán",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: KitchenStore.items,
        builder: (context, items, _) {
          final tables = items
              .where((e) => e.status != KitchenStatus.paid)
              .map((e) => e.table)
              .toSet()
              .toList();
          int totalRevenue = 0;
          int totalReturned = 0;

          for (var item in items) {
            if (item.status == KitchenStatus.served) {
              final price = menuPrice[item.foodName ?? ""] ?? 0;
              final qty = item.quantity ?? 0;
              totalReturned += qty;
              totalRevenue += price * qty;
            }
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...tables.map((table) {
                final tableItems = items
                    .where((e) => e.table == table)
                    .toList();

                int tableReturned = 0;
                int tableTotal = 0;

                for (var item in tableItems) {
                  if (item.status == KitchenStatus.served) {
                    final price = menuPrice[item.foodName ?? ""] ?? 0;
                    final qty = item.quantity ?? 0;
                    tableReturned += qty;
                    tableTotal += price * qty;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TableCard(
                    tableName: "Bàn $table",
                    returned: tableReturned,
                    total: tableTotal,
                  ),
                );
              }),
              const SizedBox(height: 4),
              OverviewCard(
                tables: tables.length,
                orders: tables.length,
                returned: totalReturned,
                revenue: totalRevenue,
              ),
            ],
          );
        },
      ),
    );
  }
}

class TableCard extends StatelessWidget {
  final String tableName;
  final int returned;
  final int total;

  const TableCard({
    super.key,
    required this.tableName,
    required this.returned,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.table_bar),
              const SizedBox(width: 10),
              Text(
                tableName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text("Tổng đĩa đã trả:"), Text("$returned")],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng tiền:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${total}đ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  final int tables;
  final int orders;
  final int returned;
  final int revenue;

  const OverviewCard({
    super.key,
    required this.tables,
    required this.orders,
    required this.returned,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tổng quan",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          OverviewItem(number: "$tables", label: "Bàn đang phục vụ"),
          const SizedBox(height: 16),
          OverviewItem(number: "$orders", label: "Đơn hàng"),
          const SizedBox(height: 16),
          OverviewItem(number: "$returned", label: "Đĩa đã trả"),
          const SizedBox(height: 16),
          OverviewItem(
            number: "${revenue}đ",
            label: "Tổng doanh thu chờ",
            isMoney: true,
          ),
        ],
      ),
    );
  }
}

class OverviewItem extends StatelessWidget {
  final String number;
  final String label;
  final bool isMoney;

  const OverviewItem({
    super.key,
    required this.number,
    required this.label,
    this.isMoney = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          number,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isMoney ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
