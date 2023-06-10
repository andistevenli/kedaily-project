import 'package:flutter/material.dart';
import '../../model/barang_model.dart';
import '../../model/helper/inventaris/supabase_helper_barang.dart';
import '../../model/helper/inventaris/supabase_helper_detail_barang.dart';
import '../../model/helper/inventaris/supabase_helper_nama_pasaran.dart';

class BarangViewModel with ChangeNotifier {
  final SupabaseHelperBarang _supabaseHelperBarang = SupabaseHelperBarang();
  final SupabaseHelperNamaPasaran _supabaseHelperNamaPasaran =
      SupabaseHelperNamaPasaran();
  final SupabaseHelperDetailBarang _supabaseHelperDetailBarang =
      SupabaseHelperDetailBarang();
  List<dynamic> barang = [];
  List<BarangModel>? daftarBarang;
  int? kategoriSelectedValue;
  int? lokasiSelectedValue;
  String barCode = '';

  void setBarCodeScanner(String code) {
    barCode = code;
    notifyListeners();
  }

  void setKategoriSelectedValueDropDownButton(int value) {
    kategoriSelectedValue = value;
    notifyListeners();
  }

  void setLokasiSelectedValueDropDownButton(int value) {
    lokasiSelectedValue = value;
    notifyListeners();
  }

  ///simpan dulu semua record barang ke dalam class model.
  Future<List<BarangModel>> simpanBarang() async {
    barang = await _supabaseHelperBarang.read();
    daftarBarang = [];
    for (var isi in barang) {
      daftarBarang!.add(BarangModel.fromJson(isi));
    }
    barang.clear();
    return daftarBarang!;
  }

  ///simpan dulu record barang berdasarkan pencarian ke dalam class model
  Future<List<BarangModel>> simpanBarangPencarian(String kataKunci) async {
    barang = await _supabaseHelperBarang.readBySearch(kataKunci);
    daftarBarang = [];
    for (var isi in barang) {
      daftarBarang!.add(BarangModel.fromJson(isi));
    }
    barang.clear();
    return daftarBarang!;
  }

  ///simpan dulu record barang berdasarkan hasil scan bar code ke dalam class model
  Future<List<BarangModel>> simpanBarangHasilScanBarCode(int barCode) async {
    barang = await _supabaseHelperBarang.readByBarCode(barCode);
    daftarBarang = [];
    for (var isi in barang) {
      daftarBarang!.add(BarangModel.fromJson(isi));
    }
    barang.clear();
    return daftarBarang!;
  }

  ///prosedur baca semua data barang.
  Future<void> readBarang() async {
    daftarBarang = await simpanBarang();
    notifyListeners();
  }

  ///prosedur baca data barang berdasarkan pencarian.
  Future<void> readBarangBySearch(String kataKunci) async {
    daftarBarang = await simpanBarangPencarian(kataKunci);
    notifyListeners();
  }

  ///prosedur baca data barang berdasarkan hasil scan bar code.
  Future<void> readBarangByBarCode(int barCode) async {
    daftarBarang = await simpanBarangHasilScanBarCode(barCode);
    notifyListeners();
  }

  ///prosedur tambah data barang.
  Future<void> createBarang(int idKategori, int id, String namaBarang) async {
    await _supabaseHelperBarang.create(idKategori, id, namaBarang);
    notifyListeners();
  }

  ///prosedur ubah data barang.
  Future<void> updateBarang(int id, int idKategori, String namaBarang) async {
    await _supabaseHelperBarang.update(id, idKategori, namaBarang);
    notifyListeners();
  }

  ///prosedur hapus data barang.
  Future<void> deleteBarang(int id) async {
    await _supabaseHelperBarang.delete(id);
    await _supabaseHelperNamaPasaran.delete(id);
    await _supabaseHelperDetailBarang.delete(id);
    notifyListeners();
  }
}
