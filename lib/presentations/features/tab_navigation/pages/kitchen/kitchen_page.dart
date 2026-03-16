import 'package:flutter/material.dart';
import 'package:order_manager/data/enum/status_enum.dart';
import 'package:order_manager/data/models/kitchen_store.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Colors.black),
            const SizedBox(width: 16),
            const Text(
              "Quản lý đơn hàng",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: ValueListenableBuilder<List<KitchenItem>>(
        valueListenable: KitchenStore.items,
        builder: (context, items, _) {
          final visibleItems = items
              .where(
                (e) =>
                    e.status != KitchenStatus.served &&
                    e.status != KitchenStatus.paid &&
                    e.status != KitchenStatus.cancelled,
              )
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: visibleItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: KitchenItemCard(
                  item: visibleItems[index],
                  onUpdate: () {
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class KitchenItemCard extends StatefulWidget {
  final KitchenItem item;
  final VoidCallback? onUpdate;

  const KitchenItemCard({super.key, required this.item, this.onUpdate});

  @override
  State<KitchenItemCard> createState() => _KitchenItemCardState();
}

class _KitchenItemCardState extends State<KitchenItemCard> {
  void startCooking() {
    setState(() {
      widget.item.status = KitchenStatus.cooking;
    });

    KitchenStore.items.notifyListeners();
  }

  void finishCooking() {
    setState(() {
      widget.item.status = KitchenStatus.finished;
    });

    KitchenStore.items.notifyListeners();
  }

  void serveCustomer() {
    setState(() {
      widget.item.status = KitchenStatus.served;
    });

    KitchenStore.items.notifyListeners();
  }

  void cancelFood() {
    setState(() {
      widget.item.status = KitchenStatus.cancelled;
    });

    KitchenStore.items.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.foodName ?? '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  "Bàn ${widget.item.table}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.item.status.background,
                  border: Border.all(color: widget.item.status.color),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 18),
                    SizedBox(width: 6),
                    Text(
                      widget.item.status.text,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mã món:", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text(
                      widget.item.foodName ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Nhân viên:", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text(
                      widget.item.staffId ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Số lượng:",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${widget.item.quantity ?? 0} đĩa",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text("Thời gian nhận:", style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 4),

          Text(
            widget.item.createdAt.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 16),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: widget.item.status == KitchenStatus.pending
                  ? startCooking
                  : widget.item.status == KitchenStatus.cooking
                  ? finishCooking
                  : widget.item.status == KitchenStatus.finished
                  ? serveCustomer
                  : null,
              icon: const Icon(Icons.timer, color: Colors.white),
              label: Text(
                widget.item.status == KitchenStatus.pending
                    ? "Bắt đầu làm"
                    : widget.item.status == KitchenStatus.cooking
                    ? "Hoàn thành"
                    : widget.item.status == KitchenStatus.finished
                    ? "Trả cho khách"
                    : "",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: cancelFood,
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: const Text(
                "Hủy món",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
