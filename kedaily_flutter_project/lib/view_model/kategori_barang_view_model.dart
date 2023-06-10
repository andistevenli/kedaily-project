import 'package:flutter/material.dart';
import '../../model/helper/inventaris/supabase_helper_kategori_barang.dart';
import '../../model/kategori_barang_model.dart';

class KategoriBarangViewModel with ChangeNotifier {
  final SupabaseHelperKategoriBarang _supabaseHelperKategoriBarang =
      SupabaseHelperKategoriBarang();
  List<dynamic> kategoriBarang = [];
  List<KategoriBarangModel>? daftarKategoriBarang;
  int? selectedValue;

  void setSelectedValueDropDownButton(int value) {
    selectedValue = value;
    notifyListeners();
  }

  ///simpan dulu semua record kategori barang ke dalam class model.
  Future<List<KategoriBarangModel>> simpanKategoriBarang() async {
    kategoriBarang = await _supabaseHelperKategoriBarang.read();
    daftarKategoriBarang = [];
    for (var isi in kategoriBarang) {
      daftarKategoriBarang!.add(KategoriBarangModel.fromJson(isi));
    }
    kategoriBarang.clear();
    return daftarKategoriBarang!;
  }

  ///simpan dulu record kategori barang berdasarkan id_lokasi ke dalam class model
  Future<List<KategoriBarangModel>> simpanKategoriBarangIdLokasi(
      int idLokasi) async {
    kategoriBarang = await _supabaseHelperKategoriBarang.readById(idLokasi);
    daftarKategoriBarang = [];
    for (var isi in kategoriBarang) {
      daftarKategoriBarang!.add(KategoriBarangModel.fromJson(isi));
    }
    kategoriBarang.clear();
    return daftarKategoriBarang!;
  }

  ///simpan dulu record kategori barang berdasarkan pencarian ke dalam class model
  Future<List<KategoriBarangModel>> simpanKategoriBarangPencarian(
      String kataKunci) async {
    kategoriBarang =
        await _supabaseHelperKategoriBarang.readBySearch(kataKunci);
    daftarKategoriBarang = [];
    for (var isi in kategoriBarang) {
      daftarKategoriBarang!.add(KategoriBarangModel.fromJson(isi));
    }
    kategoriBarang.clear();
    return daftarKategoriBarang!;
  }

  ///prosedur baca semua data kategori barang.
  Future<void> readKategoriBarang() async {
    daftarKategoriBarang = await simpanKategoriBarang();
    notifyListeners();
  }

  ///method baca data kategori barang berdasarkan id_lokasi.
  Future<void> readKategoriBarangByid(int idLokasi) async {
    daftarKategoriBarang = await simpanKategoriBarangIdLokasi(idLokasi);
    notifyListeners();
  }

  ///prosedur baca data kategori barang berdasarkan pencarian.
  Future<void> readKategoriBarangBySearch(String kataKunci) async {
    daftarKategoriBarang = await simpanKategoriBarangPencarian(kataKunci);
    notifyListeners();
  }

  ///prosedur tambah data kategori barang.
  Future<void> createKategoriBarang(int idLokasi, String namaKategori) async {
    await _supabaseHelperKategoriBarang.create(idLokasi, namaKategori);
    notifyListeners();
  }

  ///prosedur ubah data kategori barang.
  Future<void> updateKategoriBarang(
      int id, int idLokasi, String deskripsi) async {
    await _supabaseHelperKategoriBarang.update(id, idLokasi, deskripsi);
    notifyListeners();
  }

  ///prosedur hapus data kategori barang.
  Future<void> deleteKategoriBarang(int id) async {
    await _supabaseHelperKategoriBarang.delete(id);
    notifyListeners();
  }
}
