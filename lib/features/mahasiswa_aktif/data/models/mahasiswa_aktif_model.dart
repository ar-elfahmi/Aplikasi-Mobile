class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final int semester;
  final double ipk;
  final String statusAkademik;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.semester,
    required this.ipk,
    required this.statusAkademik,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      semester: json['semester'] ?? 0,
      ipk: (json['ipk'] ?? 0).toDouble(),
      statusAkademik: json['statusAkademik'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'semester': semester,
      'ipk': ipk,
      'statusAkademik': statusAkademik,
    };
  }
}
