import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/service_detail_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/order_page/order_summary_page.dart';

class ServiceDetailCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: service.imageUrl.map((url) {
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.nameOfService,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  service.discription,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${service.finalPrice.toString()}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₹${service.discountPrice.toString()}',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "1 hour",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>FuelDeliveryPage(serviceModel: service,)
                        //:
                        
                        // OrderSummaryPage(price: [service.price],services: [service.nameOfService],)
                        
                        ));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => FuelDeliveryPage()));
                  },
                  child: Text('Buy Now',
                      style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
