import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/button/primary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/number_text_box.dart';
import '../../../view_model/detail_barang_view_model.dart';
import '../../../view_model/satuan_barang_view_model.dart';

class TambahDetailBarangPage extends StatefulWidget {
  const TambahDetailBarangPage({super.key});

  static const routeName = '/tambahDetailBarangPage';

  @override
  State<TambahDetailBarangPage> createState() => _TambahDetailBarangPageState();
}

class _TambahDetailBarangPageState extends State<TambahDetailBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hargaBarangTextEditingController =
      TextEditingController();
  final TextEditingController _stokBarangTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as TambahDetailBarangArguments;
    final provider = Provider.of<DetailBarangViewModel>(context, listen: false);
    provider.satuanSelectedValue = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Detail Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer<SatuanBarangViewModel>(
                  builder: (context, satuanBarangProvider, _) {
                satuanBarangProvider.readSatuanBarangByid(args.idKategori!);
                if (satuanBarangProvider.daftarSatuanBarang == null) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: MyLoadingAnimation.staggeredDotsWave(),
                    ),
                  );
                }
                if (satuanBarangProvider.daftarSatuanBarang!.isEmpty) {
                  return const SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: MyNoDataWidget2());
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Consumer<DetailBarangViewModel>(
                        builder: (context, detailBarangProvider, _) {
                          return DropDownItem(
                            label: 'Satuan',
                            icon: Icons.scale,
                            value:
                                detailBarangProvider.satuanSelectedValue == null
                                    ? null
                                    : detailBarangProvider.satuanSelectedValue!,
                            listLength:
                                satuanBarangProvider.daftarSatuanBarang!.length,
                            generator: (index) {
                              detailBarangProvider.namaSatuan =
                                  satuanBarangProvider
                                      .daftarSatuanBarang![index].namaSatuan!;
                              return DropdownMenuItem(
                                value: satuanBarangProvider
                                    .daftarSatuanBarang![index].id!,
                                child: Text(
                                  satuanBarangProvider
                                      .daftarSatuanBarang![index].namaSatuan!,
                                ),
                              );
                            },
                            onChanged: (value) {
                              detailBarangProvider
                                  .setSatuanSelectedValueDropDownButton(value!);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              NumberTextBox(
                enabled: true,
                textEditingController: _hargaBarangTextEditingController,
                helperText:
                    'Ketikkan harga barang yang diinginkan (per satuan)',
                hintText: 'Contoh: 10000 (per Pcs)',
                labelText: 'Harga Barang',
                icon: Icons.attach_money,
                maxLength: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              NumberTextBox(
                enabled: true,
                textEditingController: _stokBarangTextEditingController,
                helperText:
                    'Ketikkan jumlah stok barang yang diinginkan (untuk satuan)',
                hintText: 'Contoh: 25 (Botol)',
                labelText: 'Stok Barang',
                icon: Icons.tag,
                maxLength: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                icon: Icons.add,
                label: 'Tambah Detail Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    if (provider.satuanSelectedValue != null) {
                      provider.addListDetailBarangModel(
                        int.parse(_hargaBarangTextEditingController.text),
                        int.parse(_stokBarangTextEditingController.text),
                        provider.satuanSelectedValue!,
                        provider.namaSatuan,
                      );
                      provider.namaSatuan = '';
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

class TambahDetailBarangArguments {
  final int? idBarang;
  final int? idKategori;

  TambahDetailBarangArguments(
      {required this.idBarang, required this.idKategori});
}
