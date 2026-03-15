import 'dart:io';

void main() {
  //   List<String> names = ['Alfa', 'beta', 'Charlie'];
  //   print('Names: $names');

  // // menembahkan data dalam list
  // names.add ( 'Delta' );
  // print ('Names setelah ditambahkan: $names');

  // // mengambil data index tertentu
  // print ('Elemen pertama: ${names [0] } ' ) ;
  // print ('Elemen kedua: ${names [1] } ' ) ;

  // // Mengubah data pada index tertentu
  // names [1] = 'Bravo';
  // print ('Names setelah diubah: $names');

  // // Menghapus data dari list
  // names. remove ( 'Charlie' ) ;
  // print ('Names setelah dihapus: $names');

  // // Menghitung jumlah data dalam list
  // print ('Jumlah data: ${names. length}');

  // // loping data list
  // print ('Menampilkan setiap elemen:');
  // for (String name in names) {
  // print (name);}

  // Membuat list kosong
  // List<String> dataList = [];
  // print('Data list kosong: $dataList');

  // // Mengambil jumlah data dari pengguna
  // int count = 0;
  // while (count <= 0) {
  //   stdout.write('Masukkan jumlah list: ');
  //   String? input = stdin.readLineSync();

  //   // Perbaikan: validasi input angka
  //   try {
  //     count = int.parse(input!);
  //     if (count <= 0) {
  //       print('Masukkan angka lebih dari 0!');
  //     }
  //   } catch (e) {
  //     print('Input tidak valid! Masukkan angka yang benar.');
  //     count = 0; // Reset agar loop berlanjut
  //   }
  // }

  // // Memasukkan data ke dalam list menggunakan for loop
  // for (int i = 0; i < count; i++) {
  //   stdout.write('data ke-${i + 1}: ');
  //   String x = stdin.readLineSync() ?? ''; // Penanganan null-safety
  //   dataList.add(x);
  // }

  // // Menampilkan data list
  // print('\nData list:');
  // print(dataList);
  // print ('\ndata pertama: ${dataList [0] } ' ) ;
  // dataList [1] = 'Yoloo';
  // print ('Data setelah diubah: $dataList');
  // dataList.remove ( 'Vano' ) ;
  // print ('Data setelah dihapus: $dataList');
  // print('--TAMPILAN HASIL AKHIR SEMUA--');

  // // hasil akhir
  // print ('Menampilkan setiap elemen:');
  // int i= 0;
  // for (String data in dataList) {
  // stdout.write('data ke-${i}: ');
  // print (data);}
  // i = i++;

  // membuat fungsi untuk print index tertentu, hapus index tertentu dan menambahakan data
  List<String> dataList = [];
  print('Data list kosong: $dataList');

  // ===============================
  // INPUT JUMLAH DATA
  // ===============================
  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();

    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka.');
      count = 0;
    }
  }

  // INPUT DATA
  for (int i = 0; i < count; i++) {
    stdout.write('data ke-${i + 1}: ');
    String x = stdin.readLineSync() ?? '';
    dataList.add(x);
  }

  // ===============================
  // MENU OPERASI
  // ===============================
  bool jalan = true;

  while (jalan) {
    print('\n===== MENU =====');
    print('1. Tampil berdasarkan index');
    print('2. Ubah berdasarkan index');
    print('3. Hapus berdasarkan index');
    print('4. Tampilkan hasil akhir & keluar');

    stdout.write('Pilih menu: ');
    int pilihan = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    switch (pilihan) {
      // =========================
      // TAMPIL
      // =========================
      case 1:
        stdout.write('Masukkan index: ');
        int idx = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

        if (idx >= 0 && idx < dataList.length) {
          print('Index $idx: ${dataList[idx]}');
        } else {
          print('Index tidak valid');
        }
        break;

      // =========================
      // UBAH
      // =========================
      case 2:
        stdout.write('Masukkan index yang diubah: ');
        int idx = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

        if (idx >= 0 && idx < dataList.length) {
          stdout.write('Masukkan data baru: ');
          String baru = stdin.readLineSync() ?? '';
          dataList[idx] = baru;
          print('Data berhasil diubah.');
        } else {
          print('Index tidak valid');
        }
        break;

      // =========================
      // HAPUS
      // =========================
      case 3:
        stdout.write('Masukkan index yang dihapus: ');
        int idx = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

        if (idx >= 0 && idx < dataList.length) {
          dataList.removeAt(idx);
          print('Data berhasil dihapus.');
        } else {
          print('Index tidak valid');
        }
        break;

      // =========================
      // HASIL AKHIR
      // =========================
      case 4:
        print('\n-- TAMPILAN HASIL AKHIR --');
        for (int i = 0; i < dataList.length; i++) {
          print('Index $i: ${dataList[i]}');
        }
        jalan = false;
        break;

      default:
        print('Menu tidak tersedia');
    }
  }
}
