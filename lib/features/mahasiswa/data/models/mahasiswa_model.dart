class MahasiswaModel {
  final String nama;
  final String nim;
  final String kelas;
  final String angkatan;
  final String email;

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.kelas,
    required this.angkatan,
    required this.email,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      kelas: json['kelas'] ?? '',
      angkatan: json['angkatan'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'kelas': kelas,
      'angkatan': angkatan,
      'email': email,
    };
  }
}
