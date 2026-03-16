import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/presentations/features/tab_navigation/bloc/tab_navigation_bloc.dart';
import 'package:order_manager/presentations/features/tab_navigation/pages/export_data/export_page.dart';
import 'package:order_manager/presentations/features/tab_navigation/pages/kitchen/kitchen_page.dart';
import 'package:order_manager/presentations/features/tab_navigation/pages/order/order_page.dart';
import 'package:order_manager/presentations/features/tab_navigation/pages/payment/payment_page.dart';

class TabNavigatorScreen extends StatelessWidget {
  const TabNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const OrderPage(),
      const KitchenPage(),
      PaymentPage(),
      const ExportPage(),
    ];

    return BlocBuilder<TabNavigationBloc, TabNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: pages,
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<TabNavigationBloc>().add(
                    TabNavigationEvent.changeTab(index),
                  );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.kitchen),
                label: "Kitchen",
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "Payment",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_download),
                label: "Export",
              ),
            ],
          ),
        );
      },
    );
  }
}