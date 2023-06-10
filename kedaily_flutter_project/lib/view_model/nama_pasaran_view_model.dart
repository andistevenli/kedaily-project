import 'package:flutter/material.dart';
import '../../model/helper/inventaris/supabase_helper_nama_pasaran.dart';
import '../../model/nama_pasaran_model.dart';

class NamaPasaranViewModel with ChangeNotifier {
  final SupabaseHelperNamaPasaran _supabaseHelperNamaPasaran =
      SupabaseHelperNamaPasaran();
  List<dynamic> namaBarangPasaran = [];
  List<NamaPasaranModel>? daftarNamaBarangPasaran;

  //simpan dulu semua record nama_pasaran ke dalam class model.
  Future<List<NamaPasaranModel>> simpanNamaPasaran(int idBarang) async {
    namaBarangPasaran = await _supabaseHelperNamaPasaran.read(idBarang);
    daftarNamaBarangPasaran = [];
    for (var isi in namaBarangPasaran) {
      daftarNamaBarangPasaran!.add(NamaPasaranModel.fromJson(isi));
    }
    namaBarangPasaran.clear();
    return daftarNamaBarangPasaran!;
  }

  ///prosedur baca semua data nama_pasaran.
  Future<void> readNamaPasaran(int idBarang) async {
    daftarNamaBarangPasaran = await simpanNamaPasaran(idBarang);
    notifyListeners();
  }

  ///prosedur tambah data nama_pasaran.
  Future<void> createNamaPasaran(int idBarang) async {
    for (int i = 0; i < daftarNamaBarangPasaran!.length; i++) {
      await _supabaseHelperNamaPasaran.create(
        daftarNamaBarangPasaran![i].namaPasaran!,
        idBarang,
      );
    }
    notifyListeners();
  }

  ///prosedur hapus data nama_pasaran.
  Future<void> deleteNamaPasaran(int idBarang) async {
    await _supabaseHelperNamaPasaran.delete(idBarang);
    notifyListeners();
  }

  ///prosedur hapus data detail barang dari list class model
  void removeListNamaPasaranModel(int index) {
    daftarNamaBarangPasaran!.removeAt(index);
    notifyListeners();
  }

  ///prosedur tambah data detail barang dari list class model
  void addListNamaPasaranModel(String namaPasaran) {
    daftarNamaBarangPasaran ??= [];
    daftarNamaBarangPasaran!.add(NamaPasaranModel(namaPasaran: namaPasaran));
    notifyListeners();
  }

  ///prosedur ubah data detail barang dari list class model
  void changeListNamaPasaranModel(int index, String namaPasaran) {
    daftarNamaBarangPasaran![index].namaPasaran = namaPasaran;
    notifyListeners();
  }
}
