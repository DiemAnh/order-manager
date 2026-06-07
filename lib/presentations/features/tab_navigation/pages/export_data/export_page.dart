import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';
import 'dart:io';
import 'dart:collection';
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
          // Track unique order IDs and their statuses
          final Map<String?, bool> tableStatuses = {}; // orderId -> has non-paid item
          int totalPaid = 0;
          int totalCancelled = 0;

          for (var item in items) {
            tableStatuses.putIfAbsent(item.orderId, () => false);
            
            if (item.status != KitchenStatus.paid) {
              tableStatuses[item.orderId] = true;
            }
            if (item.status == KitchenStatus.paid) {
              totalPaid++;
            }
            if (item.status == KitchenStatus.cancelled) {
              totalCancelled++;
            }
          }

          final totalTables = tableStatuses.length;
          final totalServing = tableStatuses.values.where((v) => v).length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 20),

              _buildStatCard(
                "Tổng đơn hàng",
                "$totalTables",
                Icons.description,
                Colors.black,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                "Đang phục vụ",
                "$totalServing",
                Icons.access_time,
                Colors.blue,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                KitchenStatus.paid.text,
                "$totalPaid",
                Icons.check_circle,
                Colors.green,
              ),

              const SizedBox(height: 16),

              _buildStatCard(
                "Đã hủy",
                "$totalCancelled",
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

  Widget _buildRecentOrders(LinkedList<KitchenItem> items) {
    final Map<String?, KitchenStatus> orderStatuses = {};
    
    // Collect unique orders and determine their status
    for (var item in items) {
      if (!orderStatuses.containsKey(item.orderId)) {
        orderStatuses[item.orderId] = item.status;
      }
      
      // Determine the overall order status based on items
      if (item.status == KitchenStatus.cancelled && orderStatuses[item.orderId] != KitchenStatus.cancelled) {
        orderStatuses[item.orderId] = KitchenStatus.cancelled;
      } else if (item.status == KitchenStatus.paid && orderStatuses[item.orderId] != KitchenStatus.cancelled) {
        orderStatuses[item.orderId] = KitchenStatus.paid;
      } else if (item.status == KitchenStatus.served && 
                 orderStatuses[item.orderId] != KitchenStatus.cancelled && 
                 orderStatuses[item.orderId] != KitchenStatus.paid) {
        orderStatuses[item.orderId] = KitchenStatus.served;
      }
    }

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
          ...orderStatuses.entries.map((entry) {
            final orderId = entry.key;
            final status = entry.value;
            
            // Get items for this order
            List<KitchenItem> tableItems = [];
            for (var item in items) {
              if (item.orderId == orderId) {
                tableItems.add(item);
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOrderItem(
                "ORD-${orderId.hashCode}",
                "Bàn $orderId",
                "${tableItems.length} món",
                status.text,
                tableItems.isNotEmpty ? tableItems.first.createdAt.toString() : "",
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
    LinkedList<KitchenItem> items,
  ) async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Không có dữ liệu để xuất")));
      return;
    }

    final buffer = StringBuffer();
    final LinkedHashMap<String, int> menuPrice = LinkedHashMap<String, int>();
    menuPrice["Phở bò"] = 50000;
    menuPrice["Bún chả"] = 45000;
    menuPrice["Cơm tấm"] = 40000;
    menuPrice["Bánh mì"] = 25000;
    menuPrice["Nem rán"] = 30000;
    menuPrice["Gỏi cuốn"] = 35000;
    menuPrice["Nước ngọt"] = 15000;
    menuPrice["Nước chanh"] = 20000;
    menuPrice["Trà đá"] = 5000;

    buffer.writeln("===== BÁO CÁO ĐƠN HÀNG =====");
    buffer.writeln("Thời gian: ${DateTime.now()}");
    buffer.writeln("");

    // Collect unique order IDs from the linked list
    final Set<String?> orders = {};
    for (var it in items) {
      orders.add(it.orderId);
    }

    for (var orderId in orders) {
      // Collect items for this orderId by iterating the linked list
      final List<KitchenItem> orderItems = [];
      for (var it in items) {
        if (it.orderId == orderId) orderItems.add(it);
      }

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
