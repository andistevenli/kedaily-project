import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/button/primary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../view_model/kategori_barang_view_model.dart';
import '../../../view_model/lokasi_barang_view_model.dart';
import '../../../view_model/satuan_barang_view_model.dart';

class TambahSatuanBarangPage extends StatefulWidget {
  const TambahSatuanBarangPage({super.key});

  static const routeName = '/tambahSatuanBarangPage';

  @override
  State<TambahSatuanBarangPage> createState() => _TambahSatuanBarangPage();
}

class _TambahSatuanBarangPage extends State<TambahSatuanBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaSatuanBarangTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaSatuanBarangTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SatuanBarangViewModel>(context, listen: false);
    provider.kategoriSelectedValue = null;
    provider.lokasiSelectedValue = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Satuan Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer2<LokasiBarangViewModel, SatuanBarangViewModel>(builder:
                  (context, lokasiBarangProvider, satuanBarangProvider, _) {
                lokasiBarangProvider.readLokasiBarang();
                if (lokasiBarangProvider.daftarLokasiBarang == null) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: MyLoadingAnimation.staggeredDotsWave(),
                    ),
                  );
                }
                if (lokasiBarangProvider.daftarLokasiBarang!.isEmpty) {
                  return const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: MyNoDataWidget2(),
                  );
                } else {
                  return DropDownItem(
                    label: 'Lokasi',
                    icon: Icons.location_on,
                    value: satuanBarangProvider.lokasiSelectedValue == null
                        ? null
                        : satuanBarangProvider.lokasiSelectedValue!,
                    listLength: lokasiBarangProvider.daftarLokasiBarang!.length,
                    generator: (index) {
                      return DropdownMenuItem(
                        value:
                            lokasiBarangProvider.daftarLokasiBarang![index].id!,
                        child: Text(lokasiBarangProvider
                            .daftarLokasiBarang![index].deskripsi!),
                      );
                    },
                    onChanged: (value) {
                      satuanBarangProvider
                          .setLokasiSelectedValueDropDownButton(value!);
                      satuanBarangProvider.kategoriSelectedValue = null;
                    },
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer2<KategoriBarangViewModel, SatuanBarangViewModel>(builder:
                  (context, kategoriBarangProvider, satuanBarangProvider, _) {
                if (satuanBarangProvider.lokasiSelectedValue == null) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: MyNoDataWidget2(),
                  );
                } else {
                  kategoriBarangProvider.readKategoriBarangByid(
                      satuanBarangProvider.lokasiSelectedValue!);
                  if (kategoriBarangProvider.daftarKategoriBarang == null) {
                    return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: MyLoadingAnimation.staggeredDotsWave(),
                      ),
                    );
                  }
                  if (kategoriBarangProvider.daftarKategoriBarang!.isEmpty) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: MyNoDataWidget2(),
                    );
                  } else {
                    return DropDownItem(
                      label: 'Kategori',
                      icon: Icons.category,
                      value: satuanBarangProvider.kategoriSelectedValue == null
                          ? null
                          : satuanBarangProvider.kategoriSelectedValue!,
                      listLength:
                          kategoriBarangProvider.daftarKategoriBarang!.length,
                      generator: (index) {
                        return DropdownMenuItem(
                          value: kategoriBarangProvider
                              .daftarKategoriBarang![index].id!,
                          child: Text(kategoriBarangProvider
                              .daftarKategoriBarang![index].namaKategori!),
                        );
                      },
                      onChanged: (value) {
                        satuanBarangProvider
                            .setKategoriSelectedValueDropDownButton(value!);
                      },
                    );
                  }
                }
              }),
              const SizedBox(
                height: 20,
              ),
              NameTextBox(
                enabled: true,
                textEditingController: _namaSatuanBarangTextEditingController,
                helperText: 'Ketikkan nama satuan yang diinginkan',
                hintText: 'Contoh: Pcs',
                labelText: 'Nama Satuan',
                icon: Icons.scale,
                maxLength: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                icon: Icons.add,
                label: 'Tambah Satuan Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    if (provider.kategoriSelectedValue != null) {
                      provider.createSatuanBarang(
                          provider.kategoriSelectedValue!,
                          _namaSatuanBarangTextEditingController.text);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
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
