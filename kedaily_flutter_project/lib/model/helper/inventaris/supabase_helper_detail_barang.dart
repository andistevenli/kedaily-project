import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperDetailBarang {
  final supabase = Supabase.instance.client;

  ///method create record pada tabel "detail_barang".
  Future<void> create(
      int hargaBarang, int stokBarang, int idSatuan, int idBarang) async {
    await supabase.from('detail_barang').insert({
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'harga_barang': hargaBarang,
      'stok_barang': stokBarang,
      'id_satuan': idSatuan,
      'id_barang': idBarang,
    });
  }

  ///method read record pada tabel "detail_barang".
  Future<List<dynamic>> read(int idBarang) async {
    return await supabase
        .from('detail_barang')
        .select(
            'id, created_at, updated_at, harga_barang, stok_barang, id_barang, satuan_barang(id, nama_satuan)')
        .eq('id_barang', idBarang);
  }

  ///method delete record pada tabel "detail_barang".
  Future<void> delete(int idBarang) async {
    await supabase.from('detail_barang').delete().eq('id', idBarang);
  }
}
