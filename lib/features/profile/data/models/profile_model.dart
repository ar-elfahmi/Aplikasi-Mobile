class ProfileModel {
  final String nama;
  final String nim;
  final String tahunLulus;
  final String pekerjaan;
  final String instansi;

  ProfileModel({
    required this.nama,
    required this.nim,
    required this.tahunLulus,
    required this.pekerjaan,
    required this.instansi,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      tahunLulus: json['tahunLulus'] ?? '',
      pekerjaan: json['pekerjaan'] ?? '',
      instansi: json['instansi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'tahunLulus': tahunLulus,
      'pekerjaan': pekerjaan,
      'instansi': instansi,
    };
  }
}
