import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';
import 'dart:collection';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final LinkedHashMap<String, int> menuPrice = _initializeMenuPrice();

  static LinkedHashMap<String, int> _initializeMenuPrice() {
    final LinkedHashMap<String, int> prices = LinkedHashMap<String, int>();
    prices["Phở bò"] = 50000;
    prices["Bún chả"] = 45000;
    prices["Cơm tấm"] = 40000;
    prices["Bánh mì"] = 25000;
    prices["Nem rán"] = 30000;
    prices["Gỏi cuốn"] = 35000;
    prices["Nước ngọt"] = 15000;
    prices["Nước chanh"] = 20000;
    prices["Trà đá"] = 5000;
    return prices;
  }

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
          // Build table data structure directly from LinkedList
          final Map<int?, (int returned, int total)> tableData = {};
          int totalRevenue = 0;
          int totalReturned = 0;

          for (var item in items) {
            if (item.status == KitchenStatus.served) {
              final price = menuPrice[item.foodName ?? ""] ?? 0;
              final qty = item.quantity ?? 0;
              totalReturned += qty;
              totalRevenue += price * qty;
              
              tableData.update(
                item.table,
                (current) => (current.$1 + qty, current.$2 + (price * qty)),
                ifAbsent: () => (qty, price * qty),
              );
            } else if (item.status != KitchenStatus.paid) {
              tableData.putIfAbsent(item.table, () => (0, 0));
            }
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...tableData.entries.map((entry) {
                final table = entry.key;
                final (returned, total) = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TableCard(
                    tableName: "Bàn $table",
                    returned: returned,
                    total: total,
                  ),
                );
              }),
              const SizedBox(height: 4),
              OverviewCard(
                tables: tableData.length,
                orders: tableData.length,
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
