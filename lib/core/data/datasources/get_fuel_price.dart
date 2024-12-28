import "package:fuel_delivery_app_user/config/errors/faliure.dart";
import "package:html/dom.dart" as dom;
import "package:http/http.dart" as http;

class  GetFuelPrice{
 static Future<String> getFuelPrice(String fuelType, String state) async {
  var url = Uri.parse(
      "https://www.livemint.com/fuel-prices/${fuelType.toLowerCase()}-state-${state.toLowerCase()}");
try{  var response = await http.get(url);
  dom.Document document = dom.Document.html(response.body);
    return await extractFuelPrice(document, fuelType, state);
  
  }catch (e){

   throw Exception("some error occurd");
  }
}

static String extractFuelPrice(dom.Document document, String fuelType, String state) {
try{  final fuelPriceElement =
      document.querySelector('#${fuelType}_1 .fuelPrice .down');
  print("fuelPriceElement: ${fuelPriceElement?.attributes}");
  if (fuelPriceElement != null) {
    String fullText = fuelPriceElement.text ?? '';
    print("fullText: $fullText");
    String priceText = fullText.split('<span')[0].trim();
    print("priceText: $priceText");

    priceText = priceText.replaceAll('₹', '');
    priceText = priceText.split("-")[0];
    priceText = priceText.split("+")[0];
    print(priceText);
    return priceText;
  } else {
    print('Fuel price element not found');
    return throw ServerFailure("Some error o");
  }}catch (e){
    throw ServerFailure("some error occured");

  }
}
}
