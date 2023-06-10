import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/barang/tambah_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/barang/ubah_barang_page.dart';
import 'package:provider/provider.dart';

import '../../../component/box_detail_info.dart';
import '../../../component/button/floating_add_button.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/button/tertiary_button.dart';
import '../../../component/group_box/create_detail_barang_group_box.dart';
import '../../../component/list_tile_swipe/edit_delete_list_tile_swipe.dart';
import '../../../component/list_tile_swipeless.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/search_text_box.dart';
import '../../../constant/my_color.dart';
import '../../../constant/my_format.dart';
import '../../../view_model/barang_view_model.dart';
import '../../../view_model/detail_barang_view_model.dart';
import '../../../view_model/nama_pasaran_view_model.dart';

class DaftarBarangPage extends StatefulWidget {
  const DaftarBarangPage({super.key});

  static const routeName = '/daftarBarangPage';

  @override
  State<DaftarBarangPage> createState() => _DaftarBarangPageState();
}

class _DaftarBarangPageState extends State<DaftarBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  void provider(BuildContext context) {
    final providerBarang = Provider.of<BarangViewModel>(context, listen: false);
    providerBarang.readBarang();
  }

  @override
  void initState() {
    super.initState();
    provider(context);
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerBarang = Provider.of<BarangViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
        actions: [
          IconButton(
            onPressed: () {
              _searchTextEditingController.clear();
              provider(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        toolTip: 'Tambah Barang',
        onPressed: () {
          Navigator.pushNamed(context, TambahBarangPage.routeName);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SearchTextBox(
                enabled: true,
                textEditingController: _searchTextEditingController,
                maxLength: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                icon: Icons.search,
                label: 'Cari Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    providerBarang
                        .readBarangBySearch(_searchTextEditingController.text);
                  }
                },
              ),
              const SizedBox(height: 20),
              Consumer3<BarangViewModel, NamaPasaranViewModel,
                  DetailBarangViewModel>(
                builder: (context, barangProvider, namaPasaranProvider,
                    detailBarangProvider, _) {
                  if (barangProvider.daftarBarang == null) {
                    return Flexible(
                      child: Center(
                        child: MyLoadingAnimation.stretchedDots(),
                      ),
                    );
                  }
                  if (barangProvider.daftarBarang!.isEmpty) {
                    return const Flexible(
                      child: MyNoDataWidget(),
                    );
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: barangProvider.daftarBarang!.length,
                        itemBuilder: (context, index) {
                          final DateTime createdAtDateTime = DateTime.parse(
                              barangProvider.daftarBarang![index].createdAt!);
                          final String tanggalCreate =
                              MyFormat.formatTanggal.format(createdAtDateTime);
                          final DateTime updatedAtDateTime = DateTime.parse(
                              barangProvider.daftarBarang![index].updatedAt!);
                          final String tanggalUpdate =
                              MyFormat.formatTanggal.format(updatedAtDateTime);
                          return EditDeleteListTileSwipe(
                            title:
                                barangProvider.daftarBarang![index].namaBarang!,
                            subtitle: tanggalUpdate,
                            trailing:
                                barangProvider.daftarBarang![index].kategori ==
                                        null
                                    ? null
                                    : Text(
                                        barangProvider.daftarBarang![index]
                                            .kategori!.namaKategori!,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                            onPressedEdit: (context) {
                              Navigator.pushNamed(
                                context,
                                UbahBarangPage.routeName,
                                arguments: ChangeBarangArguments(
                                  idBarang:
                                      barangProvider.daftarBarang![index].id!,
                                  namaBarang: barangProvider
                                      .daftarBarang![index].namaBarang!,
                                  lokasiBarang: barangProvider
                                              .daftarBarang![index]
                                              .kategori!
                                              .lokasi ==
                                          null
                                      ? null
                                      : barangProvider.daftarBarang![index]
                                          .kategori!.lokasi!.deskripsi,
                                  kategoriBarang: barangProvider
                                              .daftarBarang![index].kategori ==
                                          null
                                      ? null
                                      : barangProvider.daftarBarang![index]
                                          .kategori!.namaKategori,
                                  namaPasaranBarangArguments: namaPasaranProvider
                                                  .daftarNamaBarangPasaran ==
                                              null ||
                                          namaPasaranProvider
                                              .daftarNamaBarangPasaran!.isEmpty
                                      ? null
                                      : [
                                          NamaPasaranBarangArguments(
                                            namaPasaranBarang:
                                                namaPasaranProvider
                                                    .daftarNamaBarangPasaran![
                                                        index]
                                                    .namaPasaran!,
                                          )
                                        ],
                                  detailBarangArguments: detailBarangProvider
                                                  .daftarDetailbarang ==
                                              null ||
                                          detailBarangProvider
                                              .daftarDetailbarang!.isEmpty
                                      ? null
                                      : [
                                          DetailBarangArguments(
                                            hargaBarang: detailBarangProvider
                                                .daftarDetailbarang![index]
                                                .hargaBarang!,
                                            stokBarang: detailBarangProvider
                                                .daftarDetailbarang![index]
                                                .stokBarang!,
                                            satuanBarang: detailBarangProvider
                                                .daftarDetailbarang![index]
                                                .satuan!
                                                .namaSatuan!,
                                          )
                                        ],
                                ),
                              );
                            },
                            onPressedDelete: (context) {
                              barangProvider.deleteBarang(
                                  barangProvider.daftarBarang![index].id!);
                              _searchTextEditingController.clear();
                              provider(context);
                            },
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.all(24),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        const Icon(
                                            Icons.keyboard_double_arrow_down,
                                            color: Colors.grey),
                                        const SizedBox(height: 20),
                                        BoxDetailInfo(
                                          subInfo: 'Nama barang:',
                                          info: barangProvider
                                              .daftarBarang![index].namaBarang!,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Consumer<NamaPasaranViewModel>(builder:
                                            (context, namaPasaranProvider, _) {
                                          namaPasaranProvider.readNamaPasaran(
                                              barangProvider
                                                  .daftarBarang![index].id!);
                                          if (namaPasaranProvider
                                                  .daftarNamaBarangPasaran ==
                                              null) {
                                            return const SizedBox(
                                              height: 100,
                                              child: MyNoDataWidget2(),
                                            );
                                          }
                                          if (namaPasaranProvider
                                              .daftarNamaBarangPasaran!
                                              .isEmpty) {
                                            return const SizedBox(
                                              height: 100,
                                              child: MyNoDataWidget2(),
                                            );
                                          } else {
                                            return DisplayGroupBox(
                                              label: 'Nama pasaran:',
                                              itemCount: barangProvider
                                                  .daftarBarang!.length,
                                              itemBuilder: (context, index) {
                                                return ListTileSwipeless(
                                                  title: namaPasaranProvider
                                                      .daftarNamaBarangPasaran![
                                                          index]
                                                      .namaPasaran!,
                                                  subtitle: '',
                                                );
                                              },
                                            );
                                          }
                                        }),
                                        const SizedBox(height: 20),
                                        Consumer<DetailBarangViewModel>(
                                          builder: (context,
                                              detailBarangProvider, _) {
                                            detailBarangProvider
                                                .readDetailBarang(barangProvider
                                                    .daftarBarang![index].id!);
                                            if (detailBarangProvider
                                                    .daftarDetailbarang ==
                                                null) {
                                              return const SizedBox(
                                                height: 100,
                                                child: MyNoDataWidget2(),
                                              );
                                            }
                                            if (detailBarangProvider
                                                .daftarDetailbarang!.isEmpty) {
                                              return const SizedBox(
                                                height: 100,
                                                child: MyNoDataWidget2(),
                                              );
                                            } else {
                                              return DisplayGroupBox(
                                                label: 'Detail barang:',
                                                itemCount: detailBarangProvider
                                                    .daftarDetailbarang!.length,
                                                itemBuilder: (context, index) {
                                                  final int price =
                                                      detailBarangProvider
                                                          .daftarDetailbarang![
                                                              index]
                                                          .hargaBarang!;
                                                  final String harga = MyFormat
                                                      .formatUang
                                                      .format(price);
                                                  return ListTileSwipeless(
                                                    title: harga,
                                                    subtitle:
                                                        'stok: ${detailBarangProvider.daftarDetailbarang![index].stokBarang.toString()}',
                                                    trailing: Text(
                                                      detailBarangProvider
                                                          .daftarDetailbarang![
                                                              index]
                                                          .satuan!
                                                          .namaSatuan!,
                                                      style: const TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                        barangProvider.daftarBarang![index]
                                                    .kategori ==
                                                null
                                            ? const SizedBox()
                                            : const SizedBox(height: 20),
                                        barangProvider.daftarBarang![index]
                                                    .kategori ==
                                                null
                                            ? const SizedBox()
                                            : BoxDetailInfo(
                                                subInfo: 'Kategori barang:',
                                                info: barangProvider
                                                            .daftarBarang![
                                                                index]
                                                            .kategori ==
                                                        null
                                                    ? '-'
                                                    : barangProvider
                                                        .daftarBarang![index]
                                                        .kategori!
                                                        .namaKategori!,
                                              ),
                                        barangProvider.daftarBarang![index]
                                                    .kategori ==
                                                null
                                            ? const SizedBox()
                                            : barangProvider
                                                        .daftarBarang![index]
                                                        .kategori!
                                                        .lokasi ==
                                                    null
                                                ? const SizedBox()
                                                : const SizedBox(height: 20),
                                        barangProvider.daftarBarang![index]
                                                    .kategori ==
                                                null
                                            ? const SizedBox()
                                            : barangProvider
                                                        .daftarBarang![index]
                                                        .kategori!
                                                        .lokasi ==
                                                    null
                                                ? const SizedBox()
                                                : BoxDetailInfo(
                                                    subInfo: 'Lokasi barang:',
                                                    info: barangProvider
                                                                .daftarBarang![
                                                                    index]
                                                                .kategori!
                                                                .lokasi ==
                                                            null
                                                        ? '-'
                                                        : barangProvider
                                                            .daftarBarang![
                                                                index]
                                                            .kategori!
                                                            .lokasi!
                                                            .deskripsi!,
                                                  ),
                                        const SizedBox(height: 20),
                                        BoxDetailInfo(
                                          subInfo: 'Updated at:',
                                          info: tanggalUpdate,
                                        ),
                                        const SizedBox(height: 20),
                                        BoxDetailInfo(
                                          subInfo: 'Created at:',
                                          info: tanggalCreate,
                                        ),
                                        const SizedBox(height: 20),
                                        TertiaryButton(
                                          label: 'Tutup',
                                          buttonColor: MyColor.deleteColor,
                                          labelColor: MyColor.whiteColor,
                                          onPressedEvent: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
