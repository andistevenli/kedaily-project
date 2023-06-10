import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/barang/daftar_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/barang/tambah_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/barang/ubah_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/detail_barang/tambah_detail_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/inventaris_page.dart';
import 'package:kedaily_flutter_project/view/pages/kategori_barang/daftar_kategori_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/kategori_barang/tambah_kategori_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/kategori_barang/ubah_kategori_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/lokasi_barang/daftar_lokasi_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/lokasi_barang/tambah_lokasi_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/lokasi_barang/ubah_lokasi_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/nama_pasaran/tambah_nama_pasaran_page.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/daftar_satuan_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/tambah_satuan_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/ubah_satuan_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/scan_barang/scan_bar_code_barang.dart';
import 'package:kedaily_flutter_project/view_model/barang_view_model.dart';
import 'package:kedaily_flutter_project/view_model/detail_barang_view_model.dart';
import 'package:kedaily_flutter_project/view_model/inventaris_view_model.dart';
import 'package:kedaily_flutter_project/view_model/kategori_barang_view_model.dart';
import 'package:kedaily_flutter_project/view_model/lokasi_barang_view_model.dart';
import 'package:kedaily_flutter_project/view_model/nama_pasaran_view_model.dart';
import 'package:kedaily_flutter_project/view_model/satuan_barang_view_model.dart';
import 'package:provider/provider.dart';
import 'constant/my_color.dart';

class Kedaily extends StatelessWidget {
  const Kedaily({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //inventaris
        ChangeNotifierProvider(
          create: (context) => LokasiBarangViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => KategoriBarangViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SatuanBarangViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BarangViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailBarangViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NamaPasaranViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => InventarisViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColor.whiteColor,
        ),
        initialRoute: InventarisPage.routeName,
        routes: {
          //inventaris
          InventarisPage.routeName: (context) => const InventarisPage(),
          //lokasi barang
          DaftarLokasiBarangPage.routeName: (context) =>
              const DaftarLokasiBarangPage(),
          TambahLokasiBarangPage.routeName: (context) =>
              const TambahLokasiBarangPage(),
          UbahLokasiBarangPage.routeName: (context) =>
              const UbahLokasiBarangPage(),
          //kategori barang
          DaftarKategoriBarangPage.routeName: (context) =>
              const DaftarKategoriBarangPage(),
          TambahKategoriBarangPage.routeName: (context) =>
              const TambahKategoriBarangPage(),
          UbahKategoriBarangPage.routeName: (context) =>
              const UbahKategoriBarangPage(),
          //satuan barang
          DaftarSatuanBarang.routeName: (context) => const DaftarSatuanBarang(),
          TambahSatuanBarangPage.routeName: (context) =>
              const TambahSatuanBarangPage(),
          UbahSatuanBarangPage.routeName: (context) =>
              const UbahSatuanBarangPage(),
          //barang
          DaftarBarangPage.routeName: (context) => const DaftarBarangPage(),
          TambahBarangPage.routeName: (context) => const TambahBarangPage(),
          UbahBarangPage.routeName: (context) => const UbahBarangPage(),
          //detail barang
          TambahDetailBarangPage.routeName: (context) =>
              const TambahDetailBarangPage(),
          //nama pasaran
          TambahNamaPasaranPage.routeName: (context) =>
              const TambahNamaPasaranPage(),
          //scan bar code barang
          ScanBarCodeBarang.routeName: (context) => const ScanBarCodeBarang(),
        },
      ),
    );
  }
}
