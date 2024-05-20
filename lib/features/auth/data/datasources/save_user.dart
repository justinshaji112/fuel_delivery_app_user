import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';

class ScveUserDataSorece {
 static void saveUser(
      {required String name,
      required String email,
      required String phone,
      required String uid}) {
    try {
      FireSetup.users
          .doc(uid)
          .set({"email": email, "name": name, "phoneNuber": phone});
    } catch (e) {
      throw e;
    }
  }
}
