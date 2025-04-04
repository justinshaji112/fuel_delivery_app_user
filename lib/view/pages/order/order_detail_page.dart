import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/order_cubit/order_cubit.dart';
import 'package:fuel_delivery_app_user/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format currency
    final currencyFormatter = NumberFormat.currency(symbol: '₹');

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.orderId?.substring(0, 8) ?? "N/A"}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    order.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (order.deliveryAgentId != null &&
                      order.status != "Cancelled")
                    _buildContactOptions(context),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Service & Vehicle Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            order.vehicle.isElectric
                                ? Icons.electric_car
                                : Icons.directions_car,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Service Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Service Type', order.service.name),
                      _buildInfoRow(
                          'Service Description', order.service.discription),
                      _buildInfoRow('Duration', order.service.duration),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.time_to_leave, size: 18),
                          const SizedBox(width: 8),
                          const Text(
                            'Vehicle Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow('Make & Model',
                          '${order.vehicle.make} ${order.vehicle.model}'),
                      _buildInfoRow('Year', order.vehicle.year),
                      _buildInfoRow('Type', order.vehicle.type),
                      _buildInfoRow('Electric Vehicle',
                          order.vehicle.isElectric ? 'Yes' : 'No'),
                      if (order.vehicle.isElectric &&
                          order.vehicle.batteryCapacity != null)
                        _buildInfoRow(
                            'Battery Capacity', order.vehicle.batteryCapacity!),
                      if (order.vehicle.isElectric &&
                          order.vehicle.chargerType != null)
                        _buildInfoRow(
                            'Charger Type', order.vehicle.chargerType!),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Delivery Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Delivery Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Date', order.deliveryDate),
                      _buildInfoRow('Time Slot', order.deliveryTime),
                      if (order.deliveryAgentId != null)
                        _buildInfoRow(
                            'Delivery Agent ID', order.deliveryAgentId!),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Address Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Address Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Full Name', order.address.fullName),
                      _buildInfoRow('Type', order.address.addressType),
                      _buildInfoRow('Phone', order.address.phoneNumber),
                      _buildInfoRow('Street', order.address.streetAddress),
                      _buildInfoRow(
                          'Apartment/Unit', order.address.apartmentUnit),
                      _buildInfoRow('City', order.address.city),
                      _buildInfoRow('State', order.address.state),
                      _buildInfoRow('Postal Code', order.address.postalCode),
                      _buildInfoRow('Country', order.address.country),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Payment Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Service Price',
                          currencyFormatter.format(order.service.price)),
                      if (order.discountCode != null)
                        _buildInfoRow('Discount Code', order.discountCode!),
                      if (order.discountAmount > 0)
                        _buildInfoRow('Discount',
                            '- ${currencyFormatter.format(order.discountAmount)}'),
                      _buildInfoRow('Total Amount',
                          currencyFormatter.format(order.totalAmount),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      _buildInfoRow('Payment Method', order.paymentMethod),
                      _buildInfoRow('Payment Status',
                          order.paymentDone ? 'Paid' : 'Pending'),
                      if (order.payOnDelivery)
                        _buildInfoRow('Pay on Delivery', 'Yes'),
                      if (order.paymentId != null)
                        _buildInfoRow('Payment ID', order.paymentId!),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Order Notes
            if (order.notes != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.note,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(order.notes!),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // If order is cancelled, show cancellation details
            if (order.status == "Cancelled" && order.orderCancelDetails != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  color: Colors.red.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Cancellation Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        _buildInfoRow(
                            'Cancelled By',
                            order.orderCancelDetails!.cancelUser
                                ? 'Customer'
                                : order.orderCancelDetails!.cancelByAdmin
                                    ? 'Admin'
                                    : 'Unknown'),
                        if (order.orderCancelDetails!.reasonForCancellation !=
                            null)
                          _buildInfoRow('Reason',
                              order.orderCancelDetails!.reasonForCancellation!),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Cancel Button (only show if not already cancelled)
            if (order.status != "Cancelled" && order.status != "Delivered")
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _showCancellationDialog(context),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: style ?? const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Call Button
        ElevatedButton.icon(
          onPressed: () => _callDeliveryAgent(order.address.phoneNumber),
          icon: const Icon(Icons.call, size: 16),
          label: const Text('Call'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        const SizedBox(width: 10),
        // Chat Button
        ElevatedButton.icon(
          onPressed: () => _openChat(context),
          icon: const Icon(Icons.chat, size: 16),
          label: const Text('Chat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Confirmed':
        return Colors.blue;
      case 'In Progress':
        return Colors.indigo;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _callDeliveryAgent(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void _openChat(BuildContext context) {
    // Navigate to chat screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //   ChatScreen(deliveryAgentId: order.deliveryAgentId!, orderId: order.orderId!)));

    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Chat functionality will be implemented here')),
    );
  }

  void _showCancellationDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Are you sure you want to cancel this order?'),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for cancellation',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No, Keep Order'),
            ),
            ElevatedButton(
              onPressed: () async {
                OrderModel newOrder = order.copyWith(
                    status: "Cancelled",
                    notes: reasonController.text,
                    orderCancelDetails: OrderCancelationDetails(
                        cancelUser: true,
                        cancelByAdmin: false,
                        reasonForCancellation: reasonController.text));
                context.read<OrderCubit>().updateOrder(newOrder);
                Navigator.of(context).pop();
                _showCancellationConfirmation(context, reasonController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, Cancel Order'),
            ),
          ],
        );
      },
    );
  }

  void _showCancellationConfirmation(BuildContext context, String reason) {
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order cancellation request submitted'),
        backgroundColor: Colors.red,
      ),
    );

    // In a real app, you would call your API to cancel the order here
    debugPrint('Order cancelled with reason: $reason');
  }
}
