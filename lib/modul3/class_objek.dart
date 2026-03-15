import 'dart:io';

/// MIXINS
mixin Absensi {
  void catatHadir(String nama) {
    print("$nama tercatat hadir hari ini");
  }
}

mixin EmailKampus {
  String buatEmail(String nama) {
    String email = nama.toLowerCase().replaceAll(" ", ".") + "@kampus.ac.id";
    return email;
  }
}

mixin AksesSistem {
  void loginSistem(String role) {
    print("Login sebagai $role berhasil");
  }
}

/// CLASS DASAR
class Mahasiswa {
  String? nama;
  int? id;
  String? jurusan;

  void inputData() {
    stdout.write("Masukkan Nama: ");
    nama = stdin.readLineSync();

    stdout.write("Masukkan ID: ");
    id = int.tryParse(stdin.readLineSync() ?? '');

    stdout.write("Masukkan Jurusan: ");
    jurusan = stdin.readLineSync();
  }

  void tampilkanData() {
    print("Nama: ${nama ?? '-'}");
    print("ID: ${id ?? '-'}");
    print("Jurusan: ${jurusan ?? '-'}");
  }
}

/// DOSEN
class Dosen extends Mahasiswa with Absensi, EmailKampus, AksesSistem {
  String? mataKuliah;

  void inputDosen() {
    inputData();
    stdout.write("Masukkan Mata Kuliah: ");
    mataKuliah = stdin.readLineSync();
  }

  void infoDosen() {
    print("\n=== DATA DOSEN ===");
    tampilkanData();
    print("Mata Kuliah: ${mataKuliah ?? '-'}");

    loginSistem("Dosen");
    catatHadir(nama ?? "Tanpa Nama");
    print("Email Kampus: ${buatEmail(nama ?? 'user')}");
  }
}

/// FAKULTAS
class Fakultas extends Mahasiswa with Absensi, EmailKampus, AksesSistem {
  String? gedung;

  void inputFakultas() {
    inputData();
    stdout.write("Masukkan Gedung Fakultas: ");
    gedung = stdin.readLineSync();
  }

  void infoFakultas() {
    print("\n=== DATA STAFF FAKULTAS ===");
    tampilkanData();
    print("Gedung: ${gedung ?? '-'}");

    loginSistem("Staff Fakultas");
    catatHadir(nama ?? "Tanpa Nama");
    print("Email Kampus: ${buatEmail(nama ?? 'user')}");
  }
}

/// MAIN
void main() {
  print("Pilih Role:");
  print("1. Dosen");
  print("2. Staff Fakultas");

  String? pilih = stdin.readLineSync();

  if (pilih == "1") {
    Dosen d = Dosen();
    d.inputDosen();
    d.infoDosen();
  } else if (pilih == "2") {
    Fakultas f = Fakultas();
    f.inputFakultas();
    f.infoFakultas();
  } else {
    print("Pilihan tidak valid");
  }
}