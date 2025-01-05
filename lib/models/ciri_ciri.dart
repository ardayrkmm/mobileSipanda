class CiriCiriModel {
  final String idCiri;
  final String idHewan;
  final String ciri;

  CiriCiriModel({
    required this.idCiri,
    required this.idHewan,
    required this.ciri,
  });

  // Method untuk membuat objek dari JSON
  factory CiriCiriModel.fromJson(Map<String, dynamic> json) {
    return CiriCiriModel(
      idCiri: json['id_ciri'],
      idHewan: json['id_hewan'],
      ciri: json['ciri'],
    );
  }

  // Method untuk mengonversi objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id_ciri': idCiri,
      'id_hewan': idHewan,
      'ciri': ciri,
    };
  }
}
