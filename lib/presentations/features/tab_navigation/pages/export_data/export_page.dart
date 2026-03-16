import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';
import 'package:order_manager/data/models/order_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

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
              "Quản lý đơn hàng",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: KitchenStore.items,
        builder: (context, items, _) {
          final tables = items.map((e) => e.orderId).toSet();

          final serving = items
              .where((e) => e.status != KitchenStatus.paid)
              .map((e) => e.orderId)
              .toSet();

          final paid = items
              .where((e) => e.status == KitchenStatus.paid)
              .map((e) => e.orderId)
              .toSet();

          final cancelled = items
              .where((e) => e.status == KitchenStatus.cancelled)
              .map((e) => e.orderId)
              .toSet();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 20),

              _buildStatCard(
                "Tổng đơn hàng",
                "${tables.length}",
                Icons.description,
                Colors.black,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                "Đang phục vụ",
                "${serving.length}",
                Icons.access_time,
                Colors.blue,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                KitchenStatus.paid.text,
                "${paid.length}",
                Icons.check_circle,
                Colors.green,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                "Đã hủy",
                "${cancelled.length}",
                Icons.cancel,
                Colors.red,
              ),

              const SizedBox(height: 24),

              _buildExportCard(context),

              const SizedBox(height: 24),

              _buildRecentOrders(items),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: const [
        Icon(Icons.description, size: 30),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Xuất báo cáo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("Xuất dữ liệu đơn hàng ra file text"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Xuất dữ liệu",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Xuất toàn bộ dữ liệu đơn hàng ra file text để lưu trữ và tra cứu",
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                exportReport(context, KitchenStore.items.value);
              },
              icon: const Icon(Icons.download),
              label: const Text("Xuất file báo cáo (.txt)"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrders(List items) {
    final tables = items.map((e) => e.orderId).toSet().toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Đơn hàng gần đây",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...tables.map((table) {
            final tableItems = items.where((e) => e.orderId == table).toList();

            KitchenStatus status;

            if (tableItems.any((e) => e.status == KitchenStatus.cancelled)) {
              status = KitchenStatus.cancelled;
            } else if (tableItems.any((e) => e.status == KitchenStatus.paid)) {
              status = KitchenStatus.paid;
            } else if (tableItems.any(
              (e) => e.status == KitchenStatus.served,
            )) {
              status = KitchenStatus.served;
            } else {
              status = KitchenStatus.pending;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOrderItem(
                "ORD-${table.hashCode}",
                "Bàn $table",
                "${tableItems.length} món",
                status.text,
                tableItems.first.createdAt.toString(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOrderItem(
    String id,
    String table,
    String items,
    String status,
    String time,
  ) {
    Color statusColor;

    if (status == KitchenStatus.paid.text) {
      statusColor = Colors.green;
    } else if (status == KitchenStatus.cancelled.text) {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.blue;
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(table),
                Text(items),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(time, textAlign: TextAlign.right),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> exportReport(
    BuildContext context,
    List<KitchenItem> items,
  ) async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Không có dữ liệu để xuất")));
      return;
    }

    final buffer = StringBuffer();
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

    buffer.writeln("===== BÁO CÁO ĐƠN HÀNG =====");
    buffer.writeln("Thời gian: ${DateTime.now()}");
    buffer.writeln("");

    final orders = items.map((e) => e.orderId).toSet();

    for (var orderId in orders) {
      final orderItems = items.where((e) => e.orderId == orderId).toList();

      if (orderItems.isEmpty) continue;

      buffer.writeln("Đơn: $orderId");
      buffer.writeln("Bàn: ${orderItems.first.table}");

      for (var item in orderItems) {
        final price = menuPrice[item.foodName ?? ""] ?? 0;
        final qty = item.quantity ?? 0;
        final total = price * qty;

        buffer.writeln(
          "- ${item.foodName} | SL: $qty | Trạng thái: ${item.status.text} | Tiền: $total VNĐ",
        );
      }

      buffer.writeln("");
    }

    final directory = await getTemporaryDirectory();

    final file = File("${directory.path}/order_report.txt");

    await file.writeAsString(buffer.toString());

    final box = context.findRenderObject() as RenderBox;

    await Share.shareXFiles(
      [XFile(file.path)],
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
