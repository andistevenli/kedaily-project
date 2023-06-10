import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/tambah_satuan_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/ubah_satuan_barang_page.dart';
import 'package:provider/provider.dart';
import '../../../../constant/my_color.dart';
import '../../../../constant/my_format.dart';
import '../../../component/box_detail_info.dart';
import '../../../component/button/floating_add_button.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/button/tertiary_button.dart';
import '../../../component/list_tile_swipe/edit_delete_list_tile_swipe.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget.dart';
import '../../../component/text_box/search_text_box.dart';
import '../../../view_model/satuan_barang_view_model.dart';

class DaftarSatuanBarang extends StatefulWidget {
  const DaftarSatuanBarang({super.key});

  static const routeName = '/daftarSatuanBarangPage';

  @override
  State<DaftarSatuanBarang> createState() => _DaftarSatuanBarangPage();
}

class _DaftarSatuanBarangPage extends State<DaftarSatuanBarang> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  void provider(BuildContext context) {
    final provider = Provider.of<SatuanBarangViewModel>(context, listen: false);
    provider.readSatuanBarang();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Satuan Barang'),
        actions: [
          IconButton(
            onPressed: () {
              provider(context);
              _searchTextEditingController.clear();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        toolTip: 'Tambah Satuan Barang',
        onPressed: () {
          Navigator.pushNamed(context, TambahSatuanBarangPage.routeName);
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
                maxLength: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<SatuanBarangViewModel>(
                  builder: (context, satuanBarangProvider, _) {
                return PrimaryButton(
                  icon: Icons.search,
                  label: 'Cari Satuan Barang',
                  onPressedEvent: () {
                    if (_formKey.currentState!.validate()) {
                      satuanBarangProvider.readSatuanBarangBySearch(
                          _searchTextEditingController.text);
                    }
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer<SatuanBarangViewModel>(
                  builder: (context, satuanBarangProvider, _) {
                if (satuanBarangProvider.daftarSatuanBarang == null) {
                  return Expanded(
                    child: Center(
                      child: MyLoadingAnimation.stretchedDots(),
                    ),
                  );
                }
                if (satuanBarangProvider.daftarSatuanBarang!.isEmpty) {
                  return const Expanded(
                    child: MyNoDataWidget(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          satuanBarangProvider.daftarSatuanBarang!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final DateTime createdAtDateTime = DateTime.parse(
                            satuanBarangProvider
                                .daftarSatuanBarang![index].createdAt!);
                        final String tanggalCreate =
                            MyFormat.formatTanggal.format(createdAtDateTime);
                        final DateTime updatedAtDateTime = DateTime.parse(
                            satuanBarangProvider
                                .daftarSatuanBarang![index].updatedAt!);
                        final String tanggalUpdate =
                            MyFormat.formatTanggal.format(updatedAtDateTime);
                        return EditDeleteListTileSwipe(
                          subtitle: 'updated at: $tanggalUpdate',
                          title: satuanBarangProvider
                              .daftarSatuanBarang![index].namaSatuan!,
                          trailing: satuanBarangProvider
                                      .daftarSatuanBarang![index].kategori ==
                                  null
                              ? null
                              : Text(
                                  satuanBarangProvider
                                      .daftarSatuanBarang![index]
                                      .kategori!
                                      .namaKategori!,
                                  style: const TextStyle(
                                      color: MyColor.successColor),
                                ),
                          onPressedEdit: (context) {
                            Navigator.pushNamed(
                              context,
                              UbahSatuanBarangPage.routeName,
                              arguments: ChangeSatuanBarangArguments(
                                id: satuanBarangProvider
                                    .daftarSatuanBarang![index].id!,
                                namaSatuan: satuanBarangProvider
                                    .daftarSatuanBarang![index].namaSatuan!,
                                idLokasi: satuanBarangProvider
                                            .daftarSatuanBarang![index]
                                            .kategori!
                                            .lokasi ==
                                        null
                                    ? null
                                    : satuanBarangProvider
                                        .daftarSatuanBarang![index]
                                        .kategori!
                                        .lokasi!
                                        .id!,
                                deskripsi: satuanBarangProvider
                                            .daftarSatuanBarang![index]
                                            .kategori!
                                            .lokasi ==
                                        null
                                    ? null
                                    : satuanBarangProvider
                                        .daftarSatuanBarang![index]
                                        .kategori!
                                        .lokasi!
                                        .deskripsi!,
                                idKategori: satuanBarangProvider
                                            .daftarSatuanBarang![index]
                                            .kategori ==
                                        null
                                    ? null
                                    : satuanBarangProvider
                                        .daftarSatuanBarang![index]
                                        .kategori!
                                        .id!,
                                namaKategori: satuanBarangProvider
                                            .daftarSatuanBarang![index]
                                            .kategori ==
                                        null
                                    ? null
                                    : satuanBarangProvider
                                        .daftarSatuanBarang![index]
                                        .kategori!
                                        .namaKategori!,
                              ),
                            );
                          },
                          onPressedDelete: (context) {
                            satuanBarangProvider.deleteSatuanBarang(
                                satuanBarangProvider
                                    .daftarSatuanBarang![index].id!);
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoxDetailInfo(
                                        subInfo: 'Nama satuan:',
                                        info: satuanBarangProvider
                                            .daftarSatuanBarang![index]
                                            .namaSatuan!,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoxDetailInfo(
                                        subInfo: 'Created at:',
                                        info: tanggalCreate,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoxDetailInfo(
                                        subInfo: 'Updated at:',
                                        info: tanggalUpdate,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoxDetailInfo(
                                        subInfo: 'Kategori barang:',
                                        info: satuanBarangProvider
                                                    .daftarSatuanBarang![index]
                                                    .kategori ==
                                                null
                                            ? '-'
                                            : satuanBarangProvider
                                                .daftarSatuanBarang![index]
                                                .kategori!
                                                .namaKategori!,
                                      ),
                                      satuanBarangProvider
                                                  .daftarSatuanBarang![index]
                                                  .kategori ==
                                              null
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 20,
                                            ),
                                      satuanBarangProvider
                                                  .daftarSatuanBarang![index]
                                                  .kategori ==
                                              null
                                          ? const SizedBox()
                                          : BoxDetailInfo(
                                              subInfo: 'Lokasi barang:',
                                              info: satuanBarangProvider
                                                          .daftarSatuanBarang![
                                                              index]
                                                          .kategori!
                                                          .lokasi ==
                                                      null
                                                  ? '-'
                                                  : satuanBarangProvider
                                                      .daftarSatuanBarang![
                                                          index]
                                                      .kategori!
                                                      .lokasi!
                                                      .deskripsi!,
                                            ),
                                      const SizedBox(
                                        height: 20,
                                      ),
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
