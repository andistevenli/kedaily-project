import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperLokasiBarang {
  final supabase = Supabase.instance.client;

  ///query create record pada tabel "lokasi_barang".
  Future<void> create(String deskripsi) async {
    await supabase.from('lokasi_barang').insert({
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'deskripsi': deskripsi,
    });
  }

  ///method read record pada tabel "lokasi_barang".
  Future<List<dynamic>> read() async {
    return await supabase
        .from('lokasi_barang')
        .select()
        .order('updated_at', ascending: false);
  }

  ///method read record pada tabel "lokasi_barang" berdasarkan pencarian
  Future<List<dynamic>> readBySearch(String kataKunci) async {
    return await supabase
        .from('lokasi_barang')
        .select()
        .like('deskripsi', '%$kataKunci%');
  }

  ///method update record pada tabel "lokasi_barang".
  Future<void> update(int id, String deskripsi) async {
    await supabase.from('lokasi_barang').update({
      'updated_at': DateTime.now().toString(),
      'deskripsi': deskripsi,
    }).eq('id', id);
  }

  ///method delete record pada tabel "lokasi_barang".
  Future<void> delete(int id) async {
    await supabase.from('lokasi_barang').delete().eq('id', id);
  }
}
