import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/ProductOverviewScreen.dart';
import './screens/UserProductScreen.dart';
import './Providers/auth.dart';
import './Providers/orders.dart';
import './Providers/cart.dart';
import './Providers/products_provider.dart';
import './screens/CartScreen.dart';
import './screens/ProductDetails.dart';
import './screens/OrdersScreen.dart';
import './screens/EditProductScreen.dart';
import './screens/AuthScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(auth.token,
                previousOrders == null ? [] : previousOrders.orders),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen()
            },
          ),
        ));
  }
}
