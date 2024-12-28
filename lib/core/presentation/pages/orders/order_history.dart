import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_all_orders.dart';
// import 'package:smaple/order_status.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final a = GetOrders.getOrders();
  }

  // final List<Map<String, String>> orders = [
  //   {'id': '1234', 'status': 'In Progress', 'date': '2024-08-01'},
  //   {'id': '5678', 'status': 'Completed', 'date': '2024-07-28'},
  //   {'id': '9012', 'status': 'Scheduled', 'date': '2024-08-05'},
  //   // Add more orders as needed
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('My Orders'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: GetOrders.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orders History',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final order = snapshot.data![index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                child: Icon(Icons.receipt_long,
                                    color: Colors.blue[700]),
                              ),
                              title:
                                  Text('Order #${order['serviceProviderId']}'),
                              subtitle: Text(
                                  'Delivery date - ${order['deliveryDate']}'),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                // Add order details navigation logic here
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => OrderStatusScreen(
                                //       orderId: '12345',
                                //       orderDate: DateTime.now(),
                                //       items: [
                                //         {
                                //           'name': 'T-Shirt',
                                //           'price': 2.50,
                                //           'quantity': 2
                                //         },
                                //         {'name': 'Pants', 'price': 3.00, 'quantity': 1},
                                //       ],
                                //       total: 8.00,
                                //       status: 'In Progress',
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket,
                      size: 100,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No Orders Available',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your order history will appear here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Add navigation to shopping or home page
                      },
                      child: Text('Start Shopping'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
