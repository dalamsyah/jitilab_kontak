import 'package:kontak_jitilab_dimasalamsyah_test/models/contact.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/resources/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<Contact>> fetchList(String gender, String nameFilter) {
    return _provider.fetchList(gender, nameFilter);
  }
}

class NetworkError extends Error {}