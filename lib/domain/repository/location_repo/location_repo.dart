import 'dart:convert';

import 'package:http/http.dart'as http;
class LocationRepo{


    Future<List<dynamic>?> getsuggestion(String input) async {
      String _sessionToken = '';
    String kPLACES_API_KEY = 'AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    try {
      var response = await http.get(Uri.parse(request));
      print(response.body);
      if (response.statusCode == 200) {
        
         return  jsonDecode(response.body)['predictions'];
      } else {
        print('Failed to load suggestions: ${response.statusCode}');
        return [];
    
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
    return null;
  }

  
}