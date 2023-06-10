class LokasiBarangModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deskripsi;

  LokasiBarangModel({this.id, this.createdAt, this.updatedAt, this.deskripsi});

  LokasiBarangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deskripsi = json['deskripsi'];
  }
}
