import 'dart:ui';

import 'package:flutter/material.dart';

enum KitchenStatus {
  pending,
  cooking,
  finished,
  served,
  cancelled,
  paid
}

extension KitchenStatusText on KitchenStatus {
  String get text {
    switch (this) {
      case KitchenStatus.pending:
        return "Mới tạo";
      case KitchenStatus.cooking:
        return "Đang làm";
      case KitchenStatus.finished:
        return "Đã làm xong";
      case KitchenStatus.served:
        return "Đã trả";
      case KitchenStatus.cancelled:
        return "Bị hủy";
      case KitchenStatus.paid:
        return "Đã thanh toán";
    }
  }

  Color get color {
    switch (this) {
      case KitchenStatus.pending:
        return Colors.orange;
      case KitchenStatus.cooking:
        return Colors.blue;
      case KitchenStatus.finished:
        return Colors.green;
      case KitchenStatus.served:
        return Colors.purple;
      case KitchenStatus.cancelled:
        return Colors.red;
      case KitchenStatus.paid:
        return Colors.cyan;
    }
  }

  Color get background {
    return color.withOpacity(0.15);
  }
}