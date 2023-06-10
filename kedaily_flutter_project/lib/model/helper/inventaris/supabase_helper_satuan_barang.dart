import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperSatuanBarang {
  final supabase = Supabase.instance.client;

  ///method create record pada tabel "satuan_barang".
  Future<void> create(int idKategori, String namaSatuan) async {
    await supabase.from('satuan_barang').insert({
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'nama_satuan': namaSatuan,
      'id_kategori': idKategori,
    }).eq('id_kategori', idKategori);
  }

  ///method read record pada tabel "satuan_barang".
  Future<List<dynamic>> read() async {
    return await supabase.from('satuan_barang').select(
        'id, created_at, updated_at, nama_satuan, kategori_barang(id,nama_kategori, lokasi_barang(id, deskripsi))');
  }

  ///method read record pada tabel "satuan_barang" berdasarkan id_kategori.
  Future<List<dynamic>> readById(int idKategori) async {
    return await supabase
        .from('satuan_barang')
        .select('id, created_at, updated_at, nama_satuan')
        .eq('id_kategori', idKategori);
  }

  ///method read record pada tabel "satuan_barang" berdasarkan pencarian
  Future<List<dynamic>> readBySearch(String kataKunci) async {
    return await supabase
        .from('satuan_barang')
        .select(
            'id, created_at, updated_at, nama_satuan, kategori_barang(id,nama_kategori, lokasi_barang(id, deskripsi))')
        .like('nama_satuan', '%$kataKunci%');
  }

  ///method update record pada tabel "satuan_barang".
  Future<void> update(int id, int idKategori, String namaSatuan) async {
    await supabase.from('satuan_barang').update({
      'updated_at': DateTime.now().toString(),
      'nama_satuan': namaSatuan,
      'id_kategori': idKategori,
    }).eq('id', id);
  }

  ///method delete record pada tabel "satuan_barang".
  Future<void> delete(int id) async {
    await supabase.from('satuan_barang').delete().eq('id', id);
  }
}
