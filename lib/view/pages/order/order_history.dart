import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/order_cubit/order_cubit.dart';
import 'package:fuel_delivery_app_user/models/order_model.dart';
import 'package:fuel_delivery_app_user/models/service_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:fuel_delivery_app_user/view/pages/order/order_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Pending',
    'Confirmed',
    'In Progress',
    'Delivered',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF0D1333), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Orders',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0D1333),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0D1333)),
            onPressed: () {
              // Implement search functionality
              showSearch(
                context: context,
                delegate: OrderSearchDelegate(
                    BlocProvider.of<OrderCubit>(context).getOrders()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == _filterOptions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: FilterChip(
                    label: Text(
                      _filterOptions[index],
                      style: GoogleFonts.poppins(
                        color:
                            isSelected ? Colors.white : const Color(0xFF0D1333),
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = _filterOptions[index];
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Theme.of(context).primaryColor,
                    checkmarkColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    elevation: isSelected ? 2 : 0,
                    shadowColor: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                );
              },
            ),
          ),

          // Orders List
          Expanded(
            child: BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is OrderLoading) {
                  return _buildLoadingShimmer();
                } else if (state is OrdersFetchingSuccess) {
                  List<OrderModel> filteredOrders = _filterOrders(state.orders);

                  if (filteredOrders.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<OrderCubit>(context).getOrders();
                    },
                    color: Theme.of(context).primaryColor,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return _buildOrderCard(filteredOrders[index]);
                      },
                    ),
                  );
                } else if (state is OrderError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Something went wrong',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<OrderCubit>(context).getOrders();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }

                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }

  List<OrderModel> _filterOrders(List<OrderModel> orders) {
    if (_selectedFilter == 'All') {
      return orders;
    } else {
      return orders.where((order) => order.status == _selectedFilter).toList();
    }
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   'assets/images/empty_orders.png',
          //   height: 180,
          //   fit: BoxFit.contain,
          // ),
          const SizedBox(height: 24),
          Text(
            _selectedFilter == 'All'
                ? 'No Orders Yet'
                : 'No $_selectedFilter Orders',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D1333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == 'All'
                ? 'You haven\'t placed any orders yet.'
                : 'You don\'t have any $_selectedFilter orders.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (_selectedFilter == 'All')
            ElevatedButton(
              onPressed: () {
                // Navigate to services or home
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Browse Services',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    // Parse dates
    DateTime orderDate;
    try {
      orderDate = DateTime.parse(order.deliveryDate);
    } catch (e) {
      // Fallback if date parsing fails
      orderDate = DateTime.now();
    }

    SubServiceModel selectedService = order.service;
    VehicleModel selectedVehicle = order.vehicle;

    // Format price
    final priceFormatter = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
    );

    // Generate a short order ID
    String shortOrderId = order.orderId != null && order.orderId!.length >= 8
        ? order.orderId!.substring(0, 8)
        : (order.orderId ?? 'N/A');

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(order: order),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Header with Order ID and Status
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.receipt_outlined,
                          size: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Order #$shortOrderId',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color(0xFF0D1333),
                          ),
                        ),
                      ],
                    ),
                    _buildStatusChip(order.status),
                  ],
                ),
              ),

              // Order Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Service Type
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            selectedService.name
                                    .toLowerCase()
                                    .contains('charging')
                                ? Icons.electric_car
                                : Icons.local_gas_station,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedService.name,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color(0xFF0D1333),
                                ),
                              ),
                              Text(
                                'Duration: ${selectedService.duration}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Vehicle Details
                    _buildDetailRow(
                        Icons.directions_car_outlined,
                        '${selectedVehicle.make} ${selectedVehicle.model} (${selectedVehicle.year})',
                        'Vehicle'),

                    const SizedBox(height: 12),

                    // Time and Date
                    _buildDetailRow(
                        Icons.calendar_today_outlined,
                        '${DateFormat('MMM dd, yyyy').format(orderDate).toString()} • ${order.deliveryTime}',
                        'Scheduled for'),

                    const Divider(height: 32, thickness: 1),

                    // Footer Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildServiceDetail(
                            priceFormatter.format(order.totalAmount),
                            'Total Amount',
                            Icons.payments_outlined,
                          ),
                        ),
                        Container(
                          height: 36,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: _buildServiceDetail(
                            order.paymentDone ? 'Paid' : 'Pending',
                            'Payment Status',
                            order.paymentDone
                                ? Icons.check_circle_outline
                                : Icons.pending_outlined,
                            iconColor: order.paymentDone
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Button Row
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(order: order),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'View Details',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    if (!order.status.contains('Cancelled') &&
                        !order.status.contains('Delivered'))
                      const SizedBox(width: 12),
                    if (!order.status.contains('Cancelled') &&
                        !order.status.contains('Delivered'))
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Show cancellation dialog
                            _showCancellationDialog(context, order);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Cancel Order',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancellationDialog(BuildContext context, OrderModel order) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancel Order',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to cancel this order?',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason for cancellation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No, Keep Order',
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement cancellation logic here
                // context.read<OrderCubit>().cancelOrder(order.orderId!, reasonController.text);
                Navigator.of(context).pop();

                // Show feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order cancellation requested'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Yes, Cancel Order',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    IconData iconData;

    switch (status) {
      case 'Pending':
        chipColor = Colors.orange;
        iconData = Icons.hourglass_empty;
        break;
      case 'Confirmed':
        chipColor = Colors.blue;
        iconData = Icons.check_circle_outline;
        break;
      case 'In Progress':
        chipColor = Colors.indigo;
        iconData = Icons.directions_car;
        break;
      case 'Delivered':
        chipColor = Colors.green;
        iconData = Icons.task_alt;
        break;
      case 'Cancelled':
        chipColor = Colors.red;
        iconData = Icons.cancel_outlined;
        break;
      default:
        chipColor = Colors.grey;
        iconData = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 14,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: GoogleFonts.poppins(
              color: chipColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: Colors.grey[700]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0D1333),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDetail(String value, String label, IconData icon,
      {Color? iconColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D1333),
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Search Delegate for Orders
class OrderSearchDelegate extends SearchDelegate<String> {
  final List<OrderModel> orders;

  OrderSearchDelegate(this.orders);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = orders.where((order) {
      final orderId = order.orderId?.toLowerCase() ?? '';
      final vehicle =
          '${order.vehicle.make} ${order.vehicle.model}'.toLowerCase();
      final service = order.service.name.toLowerCase();

      return orderId.contains(query.toLowerCase()) ||
          vehicle.contains(query.toLowerCase()) ||
          service.contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Search by Order ID, Vehicle, or Service',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    final results = orders.where((order) {
      final orderId = order.orderId?.toLowerCase() ?? '';
      final vehicle =
          '${order.vehicle.make} ${order.vehicle.model}'.toLowerCase();
      final service = order.service.name.toLowerCase();

      return orderId.contains(query.toLowerCase()) ||
          vehicle.contains(query.toLowerCase()) ||
          service.contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(results);
  }

  Widget _buildResultsList(List<OrderModel> results) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No matching orders found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final order = results[index];

        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: order.vehicle.isElectric
                  ? Colors.green.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              order.vehicle.isElectric
                  ? Icons.electric_car
                  : Icons.local_gas_station,
              color: order.vehicle.isElectric ? Colors.green : Colors.blue,
            ),
          ),
          title: Text(
            'Order #${order.orderId?.substring(0, 8) ?? "N/A"}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${order.vehicle.make} ${order.vehicle.model} • ${order.service.name}',
            style: GoogleFonts.poppins(
              fontSize: 13,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              order.status,
              style: GoogleFonts.poppins(
                color: _getStatusColor(order.status),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsPage(
                  order: order,
                ),
              ),
            );
          },
        );
      },
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
}
