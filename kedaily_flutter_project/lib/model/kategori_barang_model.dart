class KategoriBarangModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? namaKategori;
  Lokasi? lokasi;

  KategoriBarangModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.namaKategori,
    this.lokasi,
  });

  KategoriBarangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaKategori = json['nama_kategori'];
    lokasi = json['lokasi_barang'] != null
        ? Lokasi.fromJson(json['lokasi_barang'])
        : null;
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
