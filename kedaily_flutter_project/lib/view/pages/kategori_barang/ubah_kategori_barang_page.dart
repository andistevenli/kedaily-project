import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constant/my_color.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/disabled_text_box.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../view_model/kategori_barang_view_model.dart';
import '../../../view_model/lokasi_barang_view_model.dart';

class UbahKategoriBarangPage extends StatefulWidget {
  const UbahKategoriBarangPage({super.key});

  static const routeName = '/ubahKategoriBarangPage';

  @override
  State<UbahKategoriBarangPage> createState() => _UbahKategoriBarangPage();
}

class _UbahKategoriBarangPage extends State<UbahKategoriBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaKategoriTextEditingController =
      TextEditingController();
  final TextEditingController _namaLokasiTextEditingController =
      TextEditingController();
  final TextEditingController _newNamaKategoriTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaKategoriTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ChangeKategoriBarangArgumetns;
    final provider =
        Provider.of<KategoriBarangViewModel>(context, listen: false);
    provider.selectedValue = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Kategori Barang'),
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
                width: double.infinity,
                height: 100,
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
                  const Text(
                    'Dari:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColor.deleteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DisabledTextBox(
                    textEditingController: _namaLokasiTextEditingController,
                    icon: Icons.location_on,
                    teks: args.deskripsi == null ? '-' : args.deskripsi!,
                    label: 'Lokasi',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DisabledTextBox(
                    textEditingController: _namaKategoriTextEditingController,
                    icon: Icons.category,
                    teks: args.namaKategori,
                    label: 'Kategori',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Menjadi:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColor.successColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<KategoriBarangViewModel>(
                    builder: (context, kategoriBarangProvider, _) {
                      return DropDownItem(
                        label: 'Lokasi',
                        icon: Icons.location_on,
                        value: provider.selectedValue == null
                            ? null
                            : provider.selectedValue!,
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
                          provider.setSelectedValueDropDownButton(value!);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NameTextBox(
                    enabled: true,
                    textEditingController:
                        _newNamaKategoriTextEditingController,
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
                    icon: Icons.edit,
                    label: 'Ubah Kategori Barang',
                    onPressedEvent: () {
                      if (_formKey.currentState!.validate()) {
                        provider.updateKategoriBarang(
                            args.id,
                            provider.selectedValue!,
                            _newNamaKategoriTextEditingController.text);
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

class ChangeKategoriBarangArgumetns {
  final int id;
  final String namaKategori;
  final int? idLokasi;
  final String? deskripsi;

  ChangeKategoriBarangArgumetns(
      {required this.id,
      required this.namaKategori,
      required this.idLokasi,
      required this.deskripsi});
}
