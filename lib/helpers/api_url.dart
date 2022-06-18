class ApiUrl {
  static const String baseUrl = 'http://192.168.43.71/MProg-TokoAPI/public';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listProduk = '$baseUrl/produk';
  static const String createProduk = '$baseUrl/produk';

  static String updateProduk(String id) {
    // Ubah dari int ke String
    return '$baseUrl/produk/$id';
  }

  static String showProduk(String id) {
    // Ubah dari int ke String
    return '$baseUrl/produk/$id';
  }

  static String deleteProduk(String id) {
    // Ubah dari int ke String
    return '$baseUrl/produk/$id';
  }
}
