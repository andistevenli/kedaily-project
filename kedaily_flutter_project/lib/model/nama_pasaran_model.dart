class NamaPasaranModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? namaPasaran;
  String? idBarang;

  NamaPasaranModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.namaPasaran,
      this.idBarang});

  NamaPasaranModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaPasaran = json['nama_pasaran'];
    idBarang = json['id_barang'].toString();
  }
}
