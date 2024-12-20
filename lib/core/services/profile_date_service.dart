import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/core/presentation/models/address_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/models/vehicle_model.dart';

class ProfileDateService {
  // List<AddressModel> address = [];
  // List<VehicleModel> vehicle = [];

  Stream<Map<String, dynamic>> getProfileData() {
    return FireSetup.users
        .doc(FireSetup.auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return {};
      return snapshot.data() as Map<String, dynamic>;
    });
  }

  Stream<List<AddressModel>> getAddressStream() {
    return FireSetup.users
        .doc(FireSetup.auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data() as Map<String, dynamic>;
      if (data['address'] == null) return [];
      final addressList = List<Map<String, dynamic>>.from(data['address']);
      return addressList
          .map((address) => AddressModel.fromMap(address))
          .toList();
    });
  }

  Stream<List<VehicleModel>> getVehiclesStream() {
    return FireSetup.users
        .doc(FireSetup.auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data() as Map<String, dynamic>;
      if (data['vehicles'] == null) return [];
      final vehiclesList = List<Map<String, dynamic>>.from(data['vehicles']);
      return vehiclesList
          .map((vehicle) => VehicleModel.fromMap(vehicle))
          .toList();
    });
  }

  gatProfileDataNormaly() async {
    var a = await FireSetup.users.doc(FireSetup.auth.currentUser!.uid).get();
    var adata = a.data() as Map<String, dynamic>;
    print(adata);
  }
}
