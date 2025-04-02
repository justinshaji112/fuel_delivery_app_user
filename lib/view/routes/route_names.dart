import 'package:fuel_delivery_app_user/view/routes/route_model.dart';

class RouteNames {
  static RoutModel home = RoutModel(name: "home", path: "/");
  static RoutModel signIn = RoutModel(name: "signin", path: "/auth/signin");
  static RoutModel singUp =RoutModel(name: "singUp", path:  "/auth/singUp");
  static RoutModel checkLogedIn =RoutModel(name: "CheckSingin", path:  "/auth/CheckSingin");
  static RoutModel onBoarding =RoutModel(name: "OnBoarding", path:  "/Onboarding");

 
  static RoutModel OrderHistory =RoutModel(name: "order-history", path:  "/order-history");
  //verify  email
  static RoutModel verifyEmail =RoutModel(name: "verify-email", path:  "/verify-email");


  //forgot password
  static RoutModel forgotPassword =RoutModel(name: "forgot-password", path:  "/forgot-password");
  static RoutModel selectAddress = RoutModel(name: "select-address", path: "/address");
  static RoutModel selectVehicle = RoutModel(name: "select-vehicle", path: "/vehicles");
    static RoutModel addAddress = RoutModel(name: "add-address", path: "/address/add-address");
  static RoutModel addVehicle = RoutModel(name: "add-vehicle", path: "/vehicles/add-vehicle");
  
}
