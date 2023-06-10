import 'package:flutter/material.dart';
import '../../model/helper/inventaris/supabase_helper_lokasi_barang.dart';
import '../../model/lokasi_barang_model.dart';

class LokasiBarangViewModel with ChangeNotifier {
  final SupabaseHelperLokasiBarang _supabaseHelperLokasiBarang =
      SupabaseHelperLokasiBarang();
  List<dynamic> lokasiBarang = [];
  List<LokasiBarangModel>? daftarLokasiBarang;

  ///simpan dulu semua record lokasi barang ke dalam class model.
  Future<List<LokasiBarangModel>> simpanLokasiBarang() async {
    lokasiBarang = await _supabaseHelperLokasiBarang.read();
    daftarLokasiBarang = [];
    for (var isi in lokasiBarang) {
      daftarLokasiBarang!.add(LokasiBarangModel.fromJson(isi));
    }
    lokasiBarang.clear();
    return daftarLokasiBarang!;
  }

  ///simpan dulu record lokasi barang berdasarkan pencarian ke dalam class model
  Future<List<LokasiBarangModel>> simpanLokasiBarangPencarian(
      String kataKunci) async {
    lokasiBarang = await _supabaseHelperLokasiBarang.readBySearch(kataKunci);
    daftarLokasiBarang = [];
    for (var isi in lokasiBarang) {
      daftarLokasiBarang!.add(LokasiBarangModel.fromJson(isi));
    }
    lokasiBarang.clear();
    return daftarLokasiBarang!;
  }

  ///prosedur baca semua data lokasi barang.
  Future<void> readLokasiBarang() async {
    daftarLokasiBarang = await simpanLokasiBarang();
    notifyListeners();
  }

  ///prosedur baca data lokasi barang berdasarkan pencarian.
  Future<void> readLokasiBarangBySearch(String kataKunci) async {
    daftarLokasiBarang = await simpanLokasiBarangPencarian(kataKunci);
    notifyListeners();
  }

  ///prosedur tambah data lokasi barang.
  Future<void> createLokasiBarang(String deskripsi) async {
    await _supabaseHelperLokasiBarang.create(deskripsi);
    notifyListeners();
  }

  ///prosedur ubah data lokasi barang.
  Future<void> updateLokasiBarang(int id, String deskripsi) async {
    await _supabaseHelperLokasiBarang.update(id, deskripsi);
    notifyListeners();
  }

  ///prosedur hapus data lokasi barang.
  Future<void> deleteLokasiBarang(int id) async {
    await _supabaseHelperLokasiBarang.delete(id);
    notifyListeners();
  }
}
