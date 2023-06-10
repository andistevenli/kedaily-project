import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperNamaPasaran {
  final supabase = Supabase.instance.client;

  ///method create record pada tabel "nama_pasaran".
  Future<void> create(String namaPasaran, int idBarang) async {
    await supabase.from('nama_pasaran').insert({
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'nama_pasaran': namaPasaran,
      'id_barang': idBarang,
    });
  }

  ///method read record pada tabel "nama_pasaran".
  Future<List<dynamic>> read(int idBarang) async {
    return await supabase
        .from('nama_pasaran')
        .select('id, created_at, updated_at, nama_pasaran, id_barang')
        .eq('id_barang', idBarang);
  }

  ///method delete record pada tabel "nama_pasaran".
  Future<void> delete(int idBarang) async {
    await supabase.from('nama_pasaran').delete().eq('id', idBarang);
  }
}
