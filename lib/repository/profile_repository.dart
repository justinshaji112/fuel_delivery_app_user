// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';

class ProfileModel {
  Map<String, dynamic> profileData;
  List<AddressModel> address;
  List<VehicleModel> vehicles;
  ProfileModel({
    required this.profileData,
    required this.address,
    required this.vehicles,
  });
}

class ProfileDateService {
  Stream<ProfileModel> getProfileStream() {
    return FireSetup.users
        .doc(FireSetup.auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return ProfileModel(
          profileData: {},
          address: [],
          vehicles: [],
        );
      }
      final data = snapshot.data() as Map<String, dynamic>;
      
      final addressList = data['address'] == null
          ? <AddressModel>[]
          : List<Map<String, dynamic>>.from(data['address'])
              .map((address) => AddressModel.fromMap(address))
              .toList();
              
      final vehiclesList = data['vehicles'] == null
          ? <VehicleModel>[]
          : List<Map<String, dynamic>>.from(data['vehicles'])
              .map((vehicle) => VehicleModel.fromMap(vehicle))
              .toList();
              
      return ProfileModel(
        profileData: data,
        address: addressList,
        vehicles: vehiclesList,
      );
    });
  }

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