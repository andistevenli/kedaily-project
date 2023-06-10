import 'package:flutter/material.dart';
import '../../model/detail_barang_model.dart';
import '../../model/helper/inventaris/supabase_helper_detail_barang.dart';

class DetailBarangViewModel with ChangeNotifier {
  final SupabaseHelperDetailBarang _supabaseHelperDetailBarang =
      SupabaseHelperDetailBarang();
  List<dynamic> detailBarang = [];
  List<DetailBarangModel>? daftarDetailbarang;
  int? satuanSelectedValue;
  String namaSatuan = '';

  void setSatuanSelectedValueDropDownButton(int value) {
    satuanSelectedValue = value;
    notifyListeners();
  }

  //simpan dulu semua record detail_barang ke dalam class model.
  Future<List<DetailBarangModel>> simpanDetailBarang(int idBarang) async {
    detailBarang = await _supabaseHelperDetailBarang.read(idBarang);
    daftarDetailbarang = [];
    for (var isi in detailBarang) {
      daftarDetailbarang!.add(DetailBarangModel.fromJson(isi));
    }
    detailBarang.clear();
    return daftarDetailbarang!;
  }

  ///prosedur baca semua data detail_barang.
  Future<void> readDetailBarang(int idBarang) async {
    daftarDetailbarang = await simpanDetailBarang(idBarang);
    notifyListeners();
  }

  ///prosedur tambah data detail barang.
  Future<void> createDetailBarang(int idBarang) async {
    for (int i = 0; i < daftarDetailbarang!.length; i++) {
      await _supabaseHelperDetailBarang.create(
        daftarDetailbarang![i].hargaBarang!,
        daftarDetailbarang![i].stokBarang!,
        daftarDetailbarang![i].satuan!.id!,
        idBarang,
      );
    }
    notifyListeners();
  }

  ///prosedur hapus data detail barang.
  Future<void> deleteDetailBarang(int idBarang) async {
    await _supabaseHelperDetailBarang.delete(idBarang);
    notifyListeners();
  }

  ///prosedur hapus data detail barang dari list class model
  void removeListDetailBarangModel(int index) {
    daftarDetailbarang!.removeAt(index);
    notifyListeners();
  }

  ///prosedur tambah data detail barang dari list class model
  void addListDetailBarangModel(
      int hargaBarang, int stokBarang, int idSatuan, String namaSatuan) {
    daftarDetailbarang ??= [];
    daftarDetailbarang!.add(DetailBarangModel(
        hargaBarang: hargaBarang,
        stokBarang: stokBarang,
        satuan: Satuan(id: idSatuan, namaSatuan: namaSatuan)));
    notifyListeners();
  }

  ///prosedur ubah data detail barang dari list class model
  void changeListDetailBarangModel(
      int index, int hargaBarang, int stokBarang, int idSatuan) {
    daftarDetailbarang![index].hargaBarang = hargaBarang;
    daftarDetailbarang![index].stokBarang = stokBarang;
    daftarDetailbarang![index].satuan!.id = idSatuan;
    notifyListeners();
  }
}
