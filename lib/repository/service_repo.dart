import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/service_model.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/app_exeption_handler.dart';

class ServicesRepo{
 Future<List<ServiceModel>> getServices()async{
 try{ 
  final response=await FireSetup.service.get();
 List<ServiceModel>services= response.docs.map((e) {
  final data=e.data();
  ServiceModel model=ServiceModel.fromMap(data);
  
  return model;
 }).toList();
 return services;
 }catch(e){
String error=  AppExceptionHandler.handleException(e);
  throw Exception(error);
 }

 }
  

}