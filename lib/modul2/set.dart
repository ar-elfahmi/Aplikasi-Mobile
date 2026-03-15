import 'dart:io';

void tampilData(Set<String> data) {
  print('\n=== SEMUA DATA ===');
  int no = 1;
  for (var item in data) {
    print('$no. $item');
    no++;
  }
  print('Total data: ${data.length}');
}

void main() {
  // DATA AWAL (tidak diubah)
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};

  tampilData(burung);

  // TAMBAH DATA
  stdout.write('\nMasukkan data baru: ');
  String tambah = stdin.readLineSync() ?? '';

  if (burung.add(tambah)) {
    print('Data "$tambah" berhasil ditambahkan!');
  } else {
    print('Data "$tambah" sudah ada!');
  }

  // TAMBAH DUPLICATE
  stdout.write('\nMasukkan data duplicate: ');
  String dup = stdin.readLineSync() ?? '';

  if (burung.add(dup)) {
    print('Data "$dup" berhasil ditambahkan!');
  } else {
    print('Data "$dup" tidak ditambahkan karena duplicate!');
  }

  // HAPUS DATA
  stdout.write('\nMasukkan data yang ingin dihapus: ');
  String hapus = stdin.readLineSync() ?? '';

  if (burung.remove(hapus)) {
    print('Data "$hapus" berhasil dihapus!');
  } else {
    print('Data "$hapus" tidak ditemukan!');
  }

  // CEK DATA
  stdout.write('\nMasukkan data yang ingin dicek: ');
  String cek = stdin.readLineSync() ?? '';

  if (burung.contains(cek)) {
    print('Data "$cek" ADA di Set!');
  } else {
    print('Data "$cek" tidak ada di Set!');
  }

  // HASIL AKHIR
  tampilData(burung);
}
