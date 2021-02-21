import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/OrderItem.dart';
import '../Providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(
                orderData.orders[i],
              ),
          itemCount: orderData.orders.length),
    );
  }
}