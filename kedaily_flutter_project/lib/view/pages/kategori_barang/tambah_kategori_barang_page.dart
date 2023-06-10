import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/button/primary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../view_model/kategori_barang_view_model.dart';
import '../../../view_model/lokasi_barang_view_model.dart';

class TambahKategoriBarangPage extends StatefulWidget {
  const TambahKategoriBarangPage({super.key});

  static const routeName = '/tambahKategoriBarangPage';

  @override
  State<TambahKategoriBarangPage> createState() => _TambahKategoriBarangPage();
}

class _TambahKategoriBarangPage extends State<TambahKategoriBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaKategoriTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaKategoriTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<KategoriBarangViewModel>(context, listen: false);
    provider.selectedValue = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Consumer<LokasiBarangViewModel>(
              builder: (context, lokasiBarangProvider, _) {
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
                  child: MyNoDataWidget2());
            } else {
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Consumer<KategoriBarangViewModel>(
                    builder: (context, kategoriBarangProvider, _) {
                      return DropDownItem(
                        label: 'Lokasi',
                        icon: Icons.location_on,
                        value: kategoriBarangProvider.selectedValue == null
                            ? null
                            : kategoriBarangProvider.selectedValue!,
                        listLength:
                            lokasiBarangProvider.daftarLokasiBarang!.length,
                        generator: (index) {
                          return DropdownMenuItem(
                            value: lokasiBarangProvider
                                .daftarLokasiBarang![index].id!,
                            child: Text(lokasiBarangProvider
                                .daftarLokasiBarang![index].deskripsi!),
                          );
                        },
                        onChanged: (value) {
                          kategoriBarangProvider
                              .setSelectedValueDropDownButton(value!);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NameTextBox(
                    enabled: true,
                    textEditingController: _namaKategoriTextEditingController,
                    helperText: 'Ketikkan nama kategori yang diinginkan',
                    hintText: 'Contoh: Kosmetik',
                    labelText: 'Nama Kategori',
                    icon: Icons.category,
                    maxLength: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    icon: Icons.add,
                    label: 'Tambah Kategori Barang',
                    onPressedEvent: () {
                      if (_formKey.currentState!.validate()) {
                        provider.createKategoriBarang(provider.selectedValue!,
                            _namaKategoriTextEditingController.text);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
