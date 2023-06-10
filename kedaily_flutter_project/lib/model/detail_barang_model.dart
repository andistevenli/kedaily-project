class DetailBarangModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? hargaBarang;
  int? stokBarang;
  String? idBarang;
  Satuan? satuan;

  DetailBarangModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.hargaBarang,
      this.stokBarang,
      this.idBarang,
      this.satuan});

  DetailBarangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hargaBarang = json['harga_barang'];
    stokBarang = json['stok_barang'];
    idBarang = json['id_barang'].toString();
    satuan = json['satuan_barang'] == null
        ? null
        : Satuan.fromJson(json['satuan_barang']);
  }
}

class Satuan {
  int? id;
  String? namaSatuan;

  Satuan({this.id, this.namaSatuan});

  Satuan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaSatuan = json['nama_satuan'];
  }
}
