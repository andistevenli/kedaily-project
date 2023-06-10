import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/kategori_barang/tambah_kategori_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/kategori_barang/ubah_kategori_barang_page.dart';
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
import '../../../view_model/kategori_barang_view_model.dart';

class DaftarKategoriBarangPage extends StatefulWidget {
  const DaftarKategoriBarangPage({super.key});

  static const routeName = '/daftarKategoriBarangPage';

  @override
  State<DaftarKategoriBarangPage> createState() => _DaftarKategoriBarangPage();
}

class _DaftarKategoriBarangPage extends State<DaftarKategoriBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  void provider(BuildContext context) {
    final provider =
        Provider.of<KategoriBarangViewModel>(context, listen: false);
    provider.readKategoriBarang();
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
        title: const Text('Daftar Kategori Barang'),
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
        toolTip: 'Tambah Kategori Barang',
        onPressed: () {
          Navigator.pushNamed(context, TambahKategoriBarangPage.routeName);
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
                maxLength: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<KategoriBarangViewModel>(
                  builder: (context, kategoriBarangProvider, _) {
                return PrimaryButton(
                  icon: Icons.search,
                  label: 'Cari Kategori Barang',
                  onPressedEvent: () {
                    if (_formKey.currentState!.validate()) {
                      kategoriBarangProvider.readKategoriBarangBySearch(
                          _searchTextEditingController.text);
                    }
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer<KategoriBarangViewModel>(
                  builder: (context, kategoriBarangProvider, _) {
                if (kategoriBarangProvider.daftarKategoriBarang == null) {
                  return Expanded(
                    child: Center(
                      child: MyLoadingAnimation.stretchedDots(),
                    ),
                  );
                }
                if (kategoriBarangProvider.daftarKategoriBarang!.isEmpty) {
                  return const Expanded(
                    child: MyNoDataWidget(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          kategoriBarangProvider.daftarKategoriBarang!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final DateTime createdAtDateTime = DateTime.parse(
                            kategoriBarangProvider
                                .daftarKategoriBarang![index].createdAt!);
                        final String tanggalCreate =
                            MyFormat.formatTanggal.format(createdAtDateTime);
                        final DateTime updatedAtDateTime = DateTime.parse(
                            kategoriBarangProvider
                                .daftarKategoriBarang![index].updatedAt!);
                        final String tanggalUpdate =
                            MyFormat.formatTanggal.format(updatedAtDateTime);
                        return EditDeleteListTileSwipe(
                          subtitle: 'updated at $tanggalUpdate',
                          title: kategoriBarangProvider
                              .daftarKategoriBarang![index].namaKategori!,
                          trailing: kategoriBarangProvider
                                      .daftarKategoriBarang![index].lokasi ==
                                  null
                              ? null
                              : Text(
                                  kategoriBarangProvider
                                      .daftarKategoriBarang![index]
                                      .lokasi!
                                      .deskripsi!,
                                  style: const TextStyle(
                                      color: MyColor.successColor),
                                ),
                          onPressedEdit: (context) {
                            Navigator.pushNamed(
                              context,
                              UbahKategoriBarangPage.routeName,
                              arguments: ChangeKategoriBarangArgumetns(
                                id: kategoriBarangProvider
                                    .daftarKategoriBarang![index].id!,
                                namaKategori: kategoriBarangProvider
                                    .daftarKategoriBarang![index].namaKategori!,
                                idLokasi: kategoriBarangProvider
                                            .daftarKategoriBarang![index]
                                            .lokasi ==
                                        null
                                    ? null
                                    : kategoriBarangProvider
                                        .daftarKategoriBarang![index]
                                        .lokasi!
                                        .id!,
                                deskripsi: kategoriBarangProvider
                                            .daftarKategoriBarang![index]
                                            .lokasi ==
                                        null
                                    ? null
                                    : kategoriBarangProvider
                                        .daftarKategoriBarang![index]
                                        .lokasi!
                                        .deskripsi!,
                              ),
                            );
                          },
                          onPressedDelete: (context) {
                            kategoriBarangProvider.deleteKategoriBarang(
                                kategoriBarangProvider
                                    .daftarKategoriBarang![index].id!);
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
                                          subInfo: 'Nama kategori:',
                                          info: kategoriBarangProvider
                                              .daftarKategoriBarang![index]
                                              .namaKategori!),
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
                                          info: tanggalUpdate),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BoxDetailInfo(
                                          subInfo: 'Lokasi barang:',
                                          info: kategoriBarangProvider
                                                      .daftarKategoriBarang![
                                                          index]
                                                      .lokasi ==
                                                  null
                                              ? '-'
                                              : kategoriBarangProvider
                                                  .daftarKategoriBarang![index]
                                                  .lokasi!
                                                  .deskripsi!),
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
