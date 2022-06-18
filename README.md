## Pertemuan 9

Pada pertemuan atau minggu ke 9 ini terjadi beberapa masalah yang sangat lumayan menyebalkan, seperti tidak sengaja mengetik _'spasi'_, baca-baca di stackoverflow, dan hal sepele seperti type variable

> _btw saya ubah nama dari 'tokokita' menjadi 'Toko Wiza'_ 😁.

## Changelog atau masalah-masalah untuk Pertemuan 9:

1. **Masalah Login ✔**

   Disebabkan pada file model [login.dart](lib/model/login.dart) `line 22` terdapat spasi didalam nama objectnya.

   - Sebelum: `userEmail: obj['data'][' user'][' email']`

   - Sesudah: `userEmail: obj['data']['user']['email']`

   > _Ternyata memang jari saya yang iseng mengetik spasi sendiri_ 😅, _dan untuk sesi token itu tidak jadi masalah._

2. **Masalah Uri untuk mendapatkan data dari API ✔**

   Pada file bloc [produk_bloc.dart](lib/bloc/produk_bloc.dart) `line 10`. `String` apiUrl harus di parse dengan Uri.

   - Sebelum: `var response = await Api().get(apiUrl);`

   - Sesudah: `var response = await Api().get(Uri.parse(apiUrl));`

3. **Masalah _Expected a value of type 'int?', but got one of type 'String'_ untuk menampilkan data dari API ke Aplikasi ✔**

   Disebabkan karena setelah saya coba memanggil **_produk_** dengan metode `GET` di postman, saya menyadari kalau **_id_** & **_harga_** yang di output itu adalah `String` bukan `int`. Jadi saya ubah semua type variablenya menjadi `String` untuk **_id_** & **_harga_** di beberapa file berikut:

   - [api_url.dart](lib/helpers/api_url.dart)

     Pada `line 9, 13, 17` mengubah parameter yang sebelumya adalah `(int id)` menjadi:

     - `updateProduk(String id)`
     - `showProduk(String id)`
     - `deleteProduk(String id)`

   - [produk_page.dart](lib/ui/produk_page.dart)

     Pada `line 105` mengubah isi dari subtitle:

     - Sebelum: `subtitle: Text(produk.hargaProduk.toString())`

     - Sesudah: `subtitle: Text(produk.hargaProduk!)`

     > _Sebenarnya tidak terlalu berpengaruh karena memang sudah `String` dari awal._

   - [produk.dart](lib/model/produk.dart)

     Pada `line 2, 5` mengubah type variable dari `int?` menjadi `String?`:

     - `String? id;`
     - `String? hargaProduk;`

   - [produk_bloc.dart](lib/bloc/produk_bloc.dart)

     Pada `line 26 & 40` menghapus `toString()` pada bagian harga menjadi:

     - `"harga": produk.hargaProduk`

     Sedangkan pada `line 48` mengubah type variable dari `int?` menjadi `String?`:

     - `deleteProduk({String? id}) async {`

   - [produk_form.dart](lib/ui/produk_form.dart)

     Pada `line 143 & 167` menghapus `int.parse` pada _hargaProduk_:

     - Sebelum:

       `createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);`

     - Sesudah:

       `createProduk.hargaProduk = _hargaProdukTextboxController.text;`

> Mungkin ada cara yang lebih mudah seperti parse atau _convert_ dari `String` ke `int`, tetapi saya sudah mencoba berbagai cara dan hanya cara ini yang berhasil untuk menampilkan **_List Produk_**
