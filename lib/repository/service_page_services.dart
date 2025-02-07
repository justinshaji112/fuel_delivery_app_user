import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/services_model.dart';

class ServiceMangementService {
  Stream<List<Service>> getServices() {
    var a = FireSetup.service.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Service.fromJson(data);
      }).toList();
    });
    return a;
  }

  // getServiceNormaly() async {
  //   var a = await FireSetup.service.get();

  //   a.docs.forEach((element) {
  //     var hi = element.data();
  //     try {
  //       Service.fromJson(hi);
  //     } catch (e) {
  //       print(e);
  //     }
  //   });
  // }
}
