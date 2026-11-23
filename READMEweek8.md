### Tugas 8

1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

- `Navigator.push()`: Menambahkan rute baru ke atas tumpukan (stack). Halaman sebelumnya tetap ada di memori, sehingga pengguna bisa kembali dengan tombol Back. Digunakan saat membuka formulir dari kartu aksi di halaman utama agar pengguna bisa kembali ke menu utama.
- `Navigator.pushReplacement()`: Mengganti rute yang sedang aktif di atas tumpukan dengan rute baru. Halaman lama dihancurkan, sehingga enga bisa diakses kembali dengan tombol Back.
- `Navigator.pop()`: Menghapus rute paling atas dari tumpukan (biasanya untuk menutup dialog atau kembali ke halaman sebelumnya).
- Formulir dari kartu aksi dibuka menggunakan `Navigator.push()`
- Opsi Home di drawer membawa pengguna kembali ke halaman utama menggunakan `Navigator.pushAndRemoveUntil()` (atau `pushReplacement`). Ini memastikan seluruh tumpukan rute sebelumnya (termasuk form) dihapus, sehingga pengguna kembali ke state Home yang bersih.

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

- `Scaffold` menyediakan kerangka dasar UI (body, drawer, appbar), memastikan konten selalu berada pada tempat yang benar. `AppBar` memberikan navigasi dan judul yang seragam di setiap halaman. `Drawer` memungkinkan menu navigasi yang sama diakses dari halaman mana pun.
- Dengan menyatukan ini di setiap halaman, transisi antar halaman terasa konsisten dan pengguna enga kebingungan.
- Contoh konsistensi tema: Warna gelap digunakan sebagai background `AppBar` dan `DrawerHeader` di halaman Menu maupun halaman ArtworkFormPage.

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

- Tata letak `Column` di dalam `SingleChildScrollView` dipilih agar field formulir tersusun rapi dari atas ke bawah dan enga error (overflow) saat keyboard muncul.
- `SingleChildScrollView` berperan penting sebagai penggulir: saat layar sempit atau keyboard aktif, pengguna tetap bisa *scroll* ke bawah untuk mencapai tombol Simpan.
- `Padding` dan `SizedBox` memberikan jarak antar elemen (seperti antar TextFormField) agar UI enga terlihat sesak dan mudah dibaca.

4. Apa peran `GlobalKey<FormState>`, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

- `GlobalKey<FormState>`: Memberikan akses unik ke *state* form dari luar widget tree.
- `validator`: Fungsi yang mengecek apakah isi field memenuhi syarat. Jika enga, ia mengembalikan *string* pesan error.
- `validate()`: Saat tombol Simpan ditekan, fungsi ini memicu semua validator di dalam form. Jika ada satu saja yang gagal, form enga akan dilanjutkan (dialog enga muncul).
- Memilih jenis input/papan ketik (misal `keyboardType: TextInputType.url`) saja enga cukup karena itu hanya mempermudah tampilan keyboard di perangkat mobile. Pengguna masih bisa melakukan copy-paste teks yang salah atau mem-bypass keyboard. Validasi logika di `validator` tetap wajib untuk memastikan integritas data sebelum diproses lebih lanjut.