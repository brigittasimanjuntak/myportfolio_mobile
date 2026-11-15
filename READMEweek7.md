### Tugas 7

1. Jelaskan apa yg dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah struktur hierarki (kayak pohon) yg merepresentasikan bagaimana elemen antarmuka (UI) disusun dalam aplikasi Flutter. Di Flutter, segala hal yg tampil di layar adalah widget. 

Hubungan induk-anak (parent-child) bekerja dengan cara induk bertanggung jawab mengatur tata letak (layout) dan memberikan konfigurasi kepada anak-anaknya. Anak-anak nga bisa merender dirinya sendiri tanpa wadah dari induk. Contohnya dalam proyek ini: `Scaffold` adalah induk, yg memiliki anak seperti `AppBar` dan `Padding`. Di dalam `Padding` ada `Column`, dan di dalam `Column` ada `Row` dan `GridView`. Jika induk dihapus, anak-anaknya juga akan hilang dari layar.

2. Sebutkan semua widget yg kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

- `MaterialApp`: Root widget utk mengonfigurasi tema aplikasi, rute, dan judul global.
- `Scaffold`: Kerangka dasar halaman 
- `AppBar`: Bar di bagian atas layar utk menampilkan judul
- `Padding`: Memberikan jarak di sekeliling widget di dalamnya.
- `Column`: Menyusun widget anaknya secara vertikal
- `Row`: Menyusun widget anaknya secara horizontal
- `Center`: Menaruh widget anaknya di tengah
- `Text`: Menampilkan teks di layar.
- `Icon`: Menampilkan ikon dari library Material Design.
- `Card`: Membuat elemen berbentuk kotak dengan baygan, cocok utk kartu informasi.
- `Container`: Kotak serbaguna utk memberikan ukuran, warna, atau padding pada widget.
- `GridView.count`: Menampilkan elemen dalam bentuk grid dengan jumlah kolom tertentu.
- `Material` & `InkWell`: Memberikan efek sentuhan dan latar warna pada tombol menu.
- `SizedBox`: Memberikan jarak kosong dengan ukuran spesifik.
- `SnackBar`: Notifikasi pop-up singkat di bagian bawah layar.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

`MaterialApp` merupakan widget yg membungkus aplikasi kita dan menyediakan fungsionalitas dasar sesuai pedoman material design dari Google. 
Fungsinya:
- Menentukan tema global (warna, font) agar konsisten di seluruh aplikasi.
- Menangani navigasi (routing) antar halaman.
- Menyediakan fitur lokalisasi (bahasa) dan aksesibilitas.
- Memberikan overlay utk menampilkan elemen melayg seperti `SnackBar` atau dialog.

Widget ini digunakan sebagai root (akar) karena tanpa `MaterialApp` (atau `CupertinoApp`), widget di bawahnya nga akan memiliki konteks Material (tema, arah teks, dan sistem navigasi), sehingga banyak widget bawaan Flutter (seperti `Scaffold`, `Card`, `SnackBar`) yg akan error atau nga tampil semestinya.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya pilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

- `StatelessWidget`: Widget yg bersifat statis (nga berubah). Nilai propertinya bersifat *final* dan nga bisa diubah setelah di-render. Cocok digunakan utk UI yg hanya menampilkan data (misal: halaman profil, InfoCard, ItemCard).
- `StatefulWidget`: Widget dinamis yg memiliki objek `State` yg menyimpan data yg bisa berubah seiring waktu (misal: animasi, nilai counter, form input, atau data dari API yg di-fetch).

Kita pilih `StatelessWidget` jika tampilan hanya bergantung pada data yg dikirim saat inisialisasi dan nga perlu di-render ulang karena interaksi lokal. Kita pilih `StatefulWidget` jika ada interaksi pengguna yg mengubah data di layar (misal: tombol diklik dan angka bertambah) atau jika kita perlu mengambil data dari server secara *asynchronous*.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

`BuildContext` adalah sebuah "pegangan" (handle) atau referensi ke lokasi sebuah widget di dalam *widget tree*. Ini penting karena Flutter perlu tahu widget mana yg sedang dirender dan di mana posisinya relatif terhadap widget lain.

Di dalam metode `build`, kita menggunakan `BuildContext context` sebagai parameter. Contoh penggunaannya di proyek ini adalah saat memanggil `Theme.of(context)` utk mendapatkan tema warna aplikasi, atau saat memanggil `ScaffoldMessenger.of(context)` utk memunculkan `SnackBar`. Jika kita menggunakan context yg salah (misal context dari halaman yg sudah dihancurkan), maka aplikasi akan error (*crash*).

6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita nga bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

- Hot Reload: Menyuntikkan kode yg baru diubah ke dalam mesin *Dart Virtual Machine* (VM) yg sedang berjalan, tanpa kehilangan stateaplikasi. Sangat cepat (ms). Cocok utk mengubah UI, teks, atau styling.
- Hot Restart: Menghancurkan seluruh *state* aplikasi dan memulai ulang dari awal, tapi tetap menggunakan kode baru yg sudah dikompilasi. Dibutuhkan waktu sedikit lebih lama karena harus me-rebuild root widget, tapi tetap lebih cepat daripada menutup dan membuka aplikasi.

Kita nga bisa hanya mengandalkan Hot Reload ketika kita mengubah kode yg terkait dengan:
- Variabel statis global (nilai awalnya nga akan berubah di hot reload).
- Logika `initState()` pada `StatefulWidget`.
- Perubahan struktur dependensi library atau perubahan file native (Android/iOS).
- Mengubah tipe data atau *generic* pada *class*.
Di situasi tersebut, kita harus melakukan Hot Restart jika terjadi error kompilasi.