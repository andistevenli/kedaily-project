import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperBarang {
  final supabase = Supabase.instance.client;

  ///method create record pada tabel "barang".
  Future<void> create(int idKategori, int id, String namaBarang) async {
    await supabase.from('barang').insert({
      'id': id,
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'nama_barang': namaBarang,
      'id_kategori': idKategori,
    }).eq('id_kategori', idKategori);
  }

  ///method read record pada tabel "barang".
  Future<List<dynamic>> read() async {
    return await supabase.from('barang').select(
        'id, created_at, updated_at, nama_barang, kategori_barang(id,nama_kategori, lokasi_barang(id, deskripsi))');
  }

  ///method read record pada tabel "barang" berdasarkan pencarian
  Future<List<dynamic>> readBySearch(String kataKunci) async {
    return await supabase
        .from('barang')
        .select(
            'id, created_at, updated_at, nama_barang, kategori_barang(id,nama_kategori, lokasi_barang(id, deskripsi))')
        .like('nama_barang', '%$kataKunci%');
  }

  ///method read record pada tabel "barang" berdasarkan bar code
  Future<List<dynamic>> readByBarCode(int barCode) async {
    return await supabase
        .from('barang')
        .select(
            'id, created_at, updated_at, nama_barang, kategori_barang(id,nama_kategori, lokasi_barang(id, deskripsi))')
        .like('id', '%$barCode%');
  }

  ///method update record pada tabel "barang".
  Future<void> update(int id, int idKategori, String namaBarang) async {
    await supabase.from('barang').update({
      'updated_at': DateTime.now().toString(),
      'nama_barang': namaBarang,
      'id_kategori': idKategori,
    }).eq('id', id);
  }

  ///method delete record pada tabel "barang".
  Future<void> delete(int id) async {
    await supabase.from('barang').delete().eq('id', id);
  }
}
