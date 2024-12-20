import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/booking_service_bloc/booking_services_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/current_location/current_lcoation_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/payment_handile_methods.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/razor_pay.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/service_detail_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/order_page/order_sucess_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<String> services;
  final List<double> price;
  final ServiceModel serviceModel;
  LatLng latLng = LatLng(11.1518, 75.8935);

  OrderSummaryPage(
      {Key? key,
      required this.services,
      required this.price,
      required this.serviceModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is OrderCompletedState) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderSucessPage(),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Booking Details',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCartSummary(context),
              SizedBox(height: 20),
              _buildBillSummary(),
              SizedBox(height: 20),
              _buildDateSelection(),
              SizedBox(height: 20),
              _buildTimeSelection(),
              SizedBox(height: 20),
              _buildPaymentMethodSelection(),
              SizedBox(height: 20),
              _buildPayButton(context, latLng),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cart Summary',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Mode: ',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text('Pickup', style: GoogleFonts.poppins(color: Colors.green)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Expanded(child:
                    BlocBuilder<CurrentLcoationBloc, CurrentLcoationState>(
                  builder: (context, state) {
                    if (state is LocationGotState) {
                      latLng = LatLng(state.lat, state.log);
                      return Text(state.address,
                          style: GoogleFonts.poppins(fontSize: 14));
                    }
                    return Text("Seelect address");
                  },
                )),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FuelDeliveryPage(
                            serviceModel: serviceModel,
                          ),
                        )),
                    child: Icon(Icons.edit, size: 16, color: Colors.blue)),
              ],
            ),
            Divider(),
            for (int i = 0; i < services.length; i++)
              _buildItemRow(services[i], price[i].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String item, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item, style: GoogleFonts.poppins()),
          Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildBillSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bill Summary',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildItemRow('Item Total (Incl. of taxes)',
                price.fold(0.0, (a, b) => a + b).toString()),
            // _buildItemRow('Safety & Warranty Fees', '₹99'),
            Divider(),
            _buildItemRow(
                'Grand Total', price.fold(0.0, (a, b) => a + b).toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final isSelected = date.day == state.selectedDate.day &&
                      date.month == state.selectedDate.month;
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: _buildDateButton(context, date, isSelected),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateButton(
      BuildContext context, DateTime date, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat('EEE').format(date),
              style: GoogleFonts.poppins(fontSize: 14)),
          Text(date.day.toString(),
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      onPressed: () => context.read<BookingBloc>().add(DateSelected(date)),
    );
  }

  Widget _buildTimeSelection() {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Time',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int hour = 9; hour <= 17; hour++)
                  _buildTimeButton(
                    context,
                    TimeOfDay(hour: hour, minute: 0),
                    state.selectedTime.hour == hour,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeButton(
      BuildContext context, TimeOfDay time, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text('${time.format(context)}', style: GoogleFonts.poppins()),
      onPressed: () => context.read<BookingBloc>().add(TimeSelected(time)),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Payment Method',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                RadioListTile<String>(
                  title: Text('Pay in Cash', style: GoogleFonts.poppins()),
                  value: 'cash',
                  groupValue: state.paymentMethod,
                  onChanged: (value) => context
                      .read<BookingBloc>()
                      .add(PaymentMethodSelected(value!)),
                ),
                RadioListTile<String>(
                  title: Text('Online Payment', style: GoogleFonts.poppins()),
                  value: 'online',
                  groupValue: state.paymentMethod,
                  onChanged: (value) => context
                      .read<BookingBloc>()
                      .add(PaymentMethodSelected(value!)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPayButton(BuildContext context, LatLng latLng) {
    String address = '';
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is OrderCompletedState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OrderSucessPage()));
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Buy Now',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
            onPressed: () {
              if (state.paymentMethod == "online") {
                double sum = 0;
                price.forEach(
                  (element) => sum + element,
                );
                OnlinePayment.showRazorPaySheet(sum, "Total amount");
              } else {
                var h = context.read<CurrentLcoationBloc>();
                var locationState = h.state;
                if (locationState is LocationGotState) {
                
                  BlocProvider.of<BookingBloc>(context).add(
                      SubmitOrderWithCashOnDeliveryEvent(
                          method: "cash",
                          serviceType: serviceModel.typeOfService,
                          serviceProviderId: serviceModel.ProviderId,
                          deliveryDate: state.selectedDate.toString(),
                          orderCompleteDate: DateTime.now().toString(),
                          deliveryTime: state.selectedTime.toString(),
                          address:   locationState.address,
                          longitude: locationState.lat.toString(),
                          latitude: locationState.log.toString(),));
                }

                // Implement payment logic here
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Processing payment...')));
            },
          ),
        );
      },
    );
  }
}
