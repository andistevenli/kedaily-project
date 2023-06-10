import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperKategoriBarang {
  final supabase = Supabase.instance.client;

  ///method create record pada tabel "kategori_barang".
  Future<void> create(int idLokasi, String namaKategori) async {
    await supabase.from('kategori_barang').insert({
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'nama_kategori': namaKategori,
      'id_lokasi': idLokasi,
    }).eq('id_lokasi', idLokasi);
  }

  ///method read record pada tabel "kategori_barang".
  Future<List<dynamic>> read() async {
    return await supabase.from('kategori_barang').select(
        'id, created_at, updated_at, nama_kategori, lokasi_barang(id, deskripsi)');
  }

  ///method read record pada tabel "kategori_barang" berdasarkan id_lokasi.
  Future<List<dynamic>> readById(int idLokasi) async {
    return await supabase
        .from('kategori_barang')
        .select('id, created_at, updated_at, nama_kategori')
        .eq('id_lokasi', idLokasi);
  }

  ///method read record pada tabel "kategori_barang" berdasarkan pencarian
  Future<List<dynamic>> readBySearch(String kataKunci) async {
    return await supabase
        .from('kategori_barang')
        .select(
            'id, created_at, updated_at, nama_kategori, lokasi_barang(id, deskripsi)')
        .like('nama_kategori', '%$kataKunci%');
  }

  ///method update record pada tabel "kategori_barang".
  Future<void> update(int id, int idLokasi, String namaKategori) async {
    await supabase.from('kategori_barang').update({
      'updated_at': DateTime.now().toString(),
      'nama_kategori': namaKategori,
      'id_lokasi': idLokasi,
    }).eq('id', id);
  }

  ///method delete record pada tabel "kategori_barang".
  Future<void> delete(int id) async {
    await supabase.from('kategori_barang').delete().eq('id', id);
  }
}
