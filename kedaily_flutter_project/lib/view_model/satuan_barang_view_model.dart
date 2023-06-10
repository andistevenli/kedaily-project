import 'package:flutter/material.dart';
import '../../model/helper/inventaris/supabase_helper_satuan_barang.dart';
import '../../model/satuan_barang_model.dart';

class SatuanBarangViewModel with ChangeNotifier {
  final SupabaseHelperSatuanBarang _supabaseHelperSatuanBarang =
      SupabaseHelperSatuanBarang();
  List<dynamic> satuanBarang = [];
  List<SatuanBarangModel>? daftarSatuanBarang;
  int? kategoriSelectedValue;
  int? lokasiSelectedValue;

  void setKategoriSelectedValueDropDownButton(int value) {
    kategoriSelectedValue = value;
    notifyListeners();
  }

  void setLokasiSelectedValueDropDownButton(int value) {
    lokasiSelectedValue = value;
    notifyListeners();
  }

  ///simpan dulu semua record satuan barang ke dalam class model.
  Future<List<SatuanBarangModel>> simpanSatuanBarang() async {
    satuanBarang = await _supabaseHelperSatuanBarang.read();
    daftarSatuanBarang = [];
    for (var isi in satuanBarang) {
      daftarSatuanBarang!.add(SatuanBarangModel.fromJson(isi));
    }
    satuanBarang.clear();
    return daftarSatuanBarang!;
  }

  ///simpan dulu record satuan barang berdasarkan id_kategori ke dalam class model
  Future<List<SatuanBarangModel>> simpanSatuanBarangIdKategori(
      int idKategori) async {
    satuanBarang = await _supabaseHelperSatuanBarang.readById(idKategori);
    daftarSatuanBarang = [];
    for (var isi in satuanBarang) {
      daftarSatuanBarang!.add(SatuanBarangModel.fromJson(isi));
    }
    satuanBarang.clear();
    return daftarSatuanBarang!;
  }

  ///simpan dulu record satuan barang berdasarkan pencarian ke dalam class model
  Future<List<SatuanBarangModel>> simpanSatuanBarangPencarian(
      String kataKunci) async {
    satuanBarang = await _supabaseHelperSatuanBarang.readBySearch(kataKunci);
    daftarSatuanBarang = [];
    for (var isi in satuanBarang) {
      daftarSatuanBarang!.add(SatuanBarangModel.fromJson(isi));
    }
    satuanBarang.clear();
    return daftarSatuanBarang!;
  }

  ///prosedur baca semua data satuan barang.
  Future<void> readSatuanBarang() async {
    daftarSatuanBarang = await simpanSatuanBarang();
    notifyListeners();
  }

  ///method baca data satuan barang berdasarkan id_kategori.
  Future<void> readSatuanBarangByid(int idKategori) async {
    daftarSatuanBarang = await simpanSatuanBarangIdKategori(idKategori);
    notifyListeners();
  }

  ///prosedur baca data satuan barang berdasarkan pencarian.
  Future<void> readSatuanBarangBySearch(String kataKunci) async {
    daftarSatuanBarang = await simpanSatuanBarangPencarian(kataKunci);
    notifyListeners();
  }

  ///prosedur tambah data satuan barang.
  Future<void> createSatuanBarang(int idKategori, String namaSatuan) async {
    await _supabaseHelperSatuanBarang.create(idKategori, namaSatuan);
    notifyListeners();
  }

  ///prosedur ubah data satuan barang.
  Future<void> updateSatuanBarang(
      int id, int idKategori, String namaSatuan) async {
    await _supabaseHelperSatuanBarang.update(id, idKategori, namaSatuan);
    notifyListeners();
  }

  ///prosedur hapus data satuan barang.
  Future<void> deleteSatuanBarang(int id) async {
    await _supabaseHelperSatuanBarang.delete(id);
    notifyListeners();
  }
}
