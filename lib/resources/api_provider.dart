import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/models/contact.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://6567fefe9927836bd973fa50.mockapi.io/kontak';

  Future<List<Contact>> fetchList(String gender, String nameFilter) async {
    try {

      //Cannot filter gender and name
      //ex: https://6567fefe9927836bd973fa50.mockapi.io/kontak?name=Ana&gender=xx

      Map<String, dynamic> param = {
        "limit" : 20,
        "page" : 1,
        "gender": gender,
        "name": nameFilter
      };

      if (gender == "") {
        param = {
          "limit" : 20,
          "page" : 1,
          "name": nameFilter
        };
      }

      Response response = await _dio.get(_url, queryParameters: param);

      List<Contact> list = [];
      for (var element in ((response.data) as List<dynamic>)) {
        list.add( Contact.fromJson(element) );
      }
      return list;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return []; // Contact.withError("Data not found / Connection issue");
    }
  }

}