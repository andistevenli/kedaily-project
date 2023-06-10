import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constant/my_color.dart';
import '../../../../constant/my_format.dart';
import '../../../component/box_detail_info.dart';
import '../../../component/group_box/create_detail_barang_group_box.dart';
import '../../../component/list_tile_swipeless.dart';
import '../../../component/my_no_data_widget.dart';
import '../../../view_model/barang_view_model.dart';
import '../../../view_model/detail_barang_view_model.dart';
import '../../../view_model/nama_pasaran_view_model.dart';

class ScanBarCodeBarang extends StatefulWidget {
  const ScanBarCodeBarang({super.key});

  static const String routeName = '/scan_barang_page';

  @override
  State<ScanBarCodeBarang> createState() => _ScanBarCodeBarangState();
}

class _ScanBarCodeBarangState extends State<ScanBarCodeBarang> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ChangeScanBarCodeBarangPageArguments;
    final providerBarang = Provider.of<BarangViewModel>(context, listen: false);
    final providerDetailBarang =
        Provider.of<DetailBarangViewModel>(context, listen: false);
    final providerNamaPasaran =
        Provider.of<NamaPasaranViewModel>(context, listen: false);
    if (args.idBarang != -1) {
      providerBarang.readBarangByBarCode(args.idBarang);
      providerDetailBarang.readDetailBarang(args.idBarang);
      providerNamaPasaran.readNamaPasaran(args.idBarang);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Scan'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: args.idBarang == -1
          ? const MyNoDataWidget()
          : ListView(
              padding: const EdgeInsets.all(24),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Kode Barang:',
                        style: TextStyle(color: MyColor.subInfoColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        providerBarang.daftarBarang![0].id.toString(),
                        style: const TextStyle(
                          color: MyColor.infoColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxDetailInfo(
                  subInfo: 'Nama Barang:',
                  info: providerBarang.daftarBarang![0].namaBarang!,
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxDetailInfo(
                  subInfo: 'Kategori Barang:',
                  info: providerBarang.daftarBarang![0].kategori == null
                      ? '-'
                      : providerBarang.daftarBarang![0].kategori!.namaKategori!,
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxDetailInfo(
                  subInfo: 'Lokasi Barang:',
                  info: providerBarang.daftarBarang![0].kategori!.lokasi == null
                      ? '-'
                      : providerBarang
                          .daftarBarang![0].kategori!.lokasi!.deskripsi!,
                ),
                const SizedBox(
                  height: 20,
                ),
                providerNamaPasaran.daftarNamaBarangPasaran!.isEmpty
                    ? DisplayGroupBox(
                        label: 'Nama Pasaran',
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return const Text(
                              'Tidak ada nama pasaran yang dibuat untuk barang ini');
                        },
                      )
                    : DisplayGroupBox(
                        label: 'Nama Pasaran',
                        itemCount:
                            providerNamaPasaran.daftarNamaBarangPasaran!.length,
                        itemBuilder: (context, index) {
                          return ListTileSwipeless(
                            title: providerNamaPasaran
                                .daftarNamaBarangPasaran![0].namaPasaran!,
                            subtitle: '',
                          );
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                providerDetailBarang.daftarDetailbarang!.isEmpty
                    ? DisplayGroupBox(
                        label: 'Detail Barang',
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return const Text(
                              'Tidak ada detail barang yang dibuat untuk barang ini');
                        },
                      )
                    : DisplayGroupBox(
                        label: 'Detail Barang',
                        itemCount:
                            providerDetailBarang.daftarDetailbarang!.length,
                        itemBuilder: (context, index) {
                          final int price = providerDetailBarang
                              .daftarDetailbarang![0].hargaBarang!;
                          final String harga =
                              MyFormat.formatUang.format(price);
                          return ListTileSwipeless(
                            title: harga,
                            subtitle:
                                'stok: ${providerDetailBarang.daftarDetailbarang![0].stokBarang}',
                            trailing: Text(
                              providerDetailBarang
                                  .daftarDetailbarang![0].satuan!.namaSatuan!,
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
    );
  }
}

class ChangeScanBarCodeBarangPageArguments {
  final int idBarang;

  ChangeScanBarCodeBarangPageArguments({required this.idBarang});
}
