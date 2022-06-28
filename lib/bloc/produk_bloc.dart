import 'dart:convert';

import 'package:tokowiza/helpers/api.dart';
import 'package:tokowiza/helpers/api_url.dart';
import 'package:tokowiza/model/produk.dart';

import 'package:http/http.dart' as http;

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(Uri.parse(apiUrl));
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk // menghapus toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    print(jsonObj['data']);
    return jsonObj['status'];
  }

  // static Future<bool> updateProduk({required Produk produk}) async {
  //   String apiUrl = ApiUrl.updateProduk(produk.id!);

  //   var body = {
  //     "id": produk.id!,
  //     "kode_produk": produk.kodeProduk,
  //     "nama_produk": produk.namaProduk,
  //     "harga": produk.hargaProduk // menghapus toString()
  //   };
  //   print("Body : $body");
  //   var response = await Api().put(apiUrl, body);
  //   var jsonObj = json.decode(response.body);
  //   print(jsonObj['data']);
  //   return jsonObj['data'];
  // }

  static Future<Produk> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": produk.id!,
        "kode_produk": produk.kodeProduk!,
        "nama_produk": produk.namaProduk!,
        "harga": produk.hargaProduk!
      }),
    );

    return Produk.fromJson(jsonDecode(response.body));
  }

  static Future<bool> deleteProduk({String? id}) async {
    // Ubah type variable dari int jadi String
    String apiUrl = ApiUrl.deleteProduk(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
