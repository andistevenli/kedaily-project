import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/lokasi_barang/tambah_lokasi_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/lokasi_barang/ubah_lokasi_barang_page.dart';
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
import '../../../view_model/lokasi_barang_view_model.dart';

class DaftarLokasiBarangPage extends StatefulWidget {
  const DaftarLokasiBarangPage({super.key});

  static const routeName = '/daftarLokasiBarangPage';

  @override
  State<DaftarLokasiBarangPage> createState() => _DaftarLokasiBarangPageState();
}

class _DaftarLokasiBarangPageState extends State<DaftarLokasiBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  void provider(BuildContext context) {
    final provider = Provider.of<LokasiBarangViewModel>(context, listen: false);
    provider.readLokasiBarang();
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
        title: const Text('Daftar Lokasi Barang'),
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
        toolTip: 'Tambah Lokasi Barang',
        onPressed: () {
          Navigator.pushNamed(context, TambahLokasiBarangPage.routeName);
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
              Consumer<LokasiBarangViewModel>(
                  builder: (context, lokasiBarangProvider, _) {
                return PrimaryButton(
                  icon: Icons.search,
                  label: 'Cari Lokasi Barang',
                  onPressedEvent: () {
                    if (_formKey.currentState!.validate()) {
                      lokasiBarangProvider.readLokasiBarangBySearch(
                          _searchTextEditingController.text);
                    }
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer<LokasiBarangViewModel>(
                  builder: (context, lokasiBarangProvider, _) {
                if (lokasiBarangProvider.daftarLokasiBarang == null) {
                  return Expanded(
                    child: Center(
                      child: MyLoadingAnimation.stretchedDots(),
                    ),
                  );
                }
                if (lokasiBarangProvider.daftarLokasiBarang!.isEmpty) {
                  return const Expanded(
                    child: MyNoDataWidget(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          lokasiBarangProvider.daftarLokasiBarang!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final DateTime createdAtDateTime = DateTime.parse(
                            lokasiBarangProvider
                                .daftarLokasiBarang![index].createdAt!);
                        final String tanggalCreate =
                            MyFormat.formatTanggal.format(createdAtDateTime);
                        final DateTime updatedAtDateTime = DateTime.parse(
                            lokasiBarangProvider
                                .daftarLokasiBarang![index].updatedAt!);
                        final String tanggalUpdate =
                            MyFormat.formatTanggal.format(updatedAtDateTime);
                        return EditDeleteListTileSwipe(
                          trailing: null,
                          subtitle: 'updated at $tanggalUpdate',
                          title: lokasiBarangProvider
                              .daftarLokasiBarang![index].deskripsi!,
                          onPressedEdit: (context) {
                            Navigator.pushNamed(
                              context,
                              UbahLokasiBarangPage.routeName,
                              arguments: ChangeLokasiBarangArguments(
                                id: lokasiBarangProvider
                                    .daftarLokasiBarang![index].id!,
                                deskripsi: lokasiBarangProvider
                                    .daftarLokasiBarang![index].deskripsi!,
                              ),
                            );
                          },
                          onPressedDelete: (context) {
                            lokasiBarangProvider.deleteLokasiBarang(
                                lokasiBarangProvider
                                    .daftarLokasiBarang![index].id!);
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
                                        subInfo: 'Deskripsi:',
                                        info: lokasiBarangProvider
                                            .daftarLokasiBarang![index]
                                            .deskripsi!,
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
                                          info: tanggalUpdate),
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
