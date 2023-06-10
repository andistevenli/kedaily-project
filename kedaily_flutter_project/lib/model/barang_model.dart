class BarangModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? namaBarang;
  Kategori? kategori;

  BarangModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.namaBarang,
      this.kategori});

  BarangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaBarang = json['nama_barang'];
    kategori = json['kategori_barang'] == null
        ? null
        : Kategori.fromJson(json['kategori_barang']);
  }
}

class Kategori {
  int? id;
  String? namaKategori;
  Lokasi? lokasi;

  Kategori({this.id, this.namaKategori});

  Kategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['nama_kategori'];
    lokasi = json['lokasi_barang'] == null
        ? null
        : Lokasi.fromJson(json['lokasi_barang']);
  }
}

class Lokasi {
  int? id;
  String? deskripsi;

  Lokasi({this.id, this.deskripsi});

  Lokasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deskripsi = json['deskripsi'];
  }
}
