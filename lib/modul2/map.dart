void main() {
// Membuat Map dengan data awal
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012',
  };
  print('Data: $data');

// Menambahkan data ke Map
  data['Rio'] = '084567890123';
  print('Data setelah ditambahkan: $data');

// Mengakses data berdasarkan key
  print('Nomor Anang: ${data['Anang']}');

// // UBAH DATA
// stdout.write('\nMasukkan data yang ingin diubah berdasarkan key nama: ');
// String ubah = stdin.readLineSync() ?? '';

// if (data.containsKey(ubah)) {
//   stdout.write('Masukkan nomor baru: ');
//   String nomorBaru = stdin.readLineSync() ?? '';
//   data[ubah] = nomorBaru;
//   print('Data berhasil diubah!');
// } else {
//   print('Nama tidak ditemukan');
// }

// // HAPUS DATA
// stdout.write('\nMasukkan data yang ingin dihapus berdasarkan key nama: ');
// String hapus = stdin.readLineSync() ?? '';

// if (data.remove(hapus) != null) {
//   print('Data berhasil dihapus!');
// } else {
//   print('Nama tidak ditemukan');
// }

// // CEK DATA
// stdout.write('\nMasukkan data yang ingin dicek berdasarkan key nama: ');
// String cek = stdin.readLineSync() ?? '';

// if (data.containsKey(cek)) {
//   print('Data ada -> Nomor: ${data[cek]}');
// } else {
//   print('Data tidak ada');
// }

// // HITUNG JUMLAH
// print('\nJumlah data: ${data.length}');

// // TAMPIL SEMUA KEY
// print('\nSemua Nama:');
// for (var key in data.keys) {
//   print(key);
// }

// // TAMPIL SEMUA VALUE
// print('\nSemua Nomor:');
// for (var value in data.values) {
//   print(value);
//   }
}
