import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/OrderItem.dart';
import '../Providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   // Future.delayed(Duration.zero).then((_) async {
  //   // _isLoading = true;
  //   // Provider.of<Orders>(context, listen: false).getOrders().then((_) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).getOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer(
                builder: (ctx, orderData, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(
                          orderData.orders[i],
                        ),
                    itemCount: orderData.orders.length),
              );
            }
          }
        },
      ),
    );
  }
}
