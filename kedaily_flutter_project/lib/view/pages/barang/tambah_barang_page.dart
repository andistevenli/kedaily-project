import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/button/secondary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/group_box/bar_code_group_box.dart';
import '../../../component/group_box/create_edit_group_box.dart';
import '../../../component/list_tile_swipe/delete_list_tile_swipe.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../constant/my_color.dart';
import '../../../constant/my_format.dart';
import '../../../view_model/barang_view_model.dart';
import '../../../view_model/detail_barang_view_model.dart';
import '../../../view_model/kategori_barang_view_model.dart';
import '../../../view_model/lokasi_barang_view_model.dart';
import '../../../view_model/nama_pasaran_view_model.dart';
import '../detail_barang/tambah_detail_barang_page.dart';
import '../nama_pasaran/tambah_nama_pasaran_page.dart';

class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});

  static const routeName = '/tambahBarangPage';

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaBarangTextEditingController =
      TextEditingController();
  final TextEditingController _kodeBarangTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaBarangTextEditingController.dispose();
    _kodeBarangTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerBarang = Provider.of<BarangViewModel>(context, listen: false);
    final providerNamaPasaran =
        Provider.of<NamaPasaranViewModel>(context, listen: false);
    final providerDetailBarang =
        Provider.of<DetailBarangViewModel>(context, listen: false);
    providerBarang.kategoriSelectedValue = null;
    providerBarang.lokasiSelectedValue = null;
    providerDetailBarang.daftarDetailbarang = null;
    providerNamaPasaran.daftarNamaBarangPasaran = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer2<LokasiBarangViewModel, BarangViewModel>(
                  builder: (context, lokasiBarangProvider, barangProvider, _) {
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
                    value: barangProvider.lokasiSelectedValue == null
                        ? null
                        : barangProvider.lokasiSelectedValue!,
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
                      barangProvider
                          .setLokasiSelectedValueDropDownButton(value!);
                      barangProvider.kategoriSelectedValue = null;
                    },
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer2<KategoriBarangViewModel, BarangViewModel>(builder:
                  (context, kategoriBarangProvider, barangProvider, _) {
                if (barangProvider.lokasiSelectedValue == null) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: MyNoDataWidget2(),
                  );
                } else {
                  kategoriBarangProvider.readKategoriBarangByid(
                      barangProvider.lokasiSelectedValue!);
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
                      value: barangProvider.kategoriSelectedValue == null
                          ? null
                          : barangProvider.kategoriSelectedValue!,
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
                        barangProvider
                            .setKategoriSelectedValueDropDownButton(value!);
                      },
                    );
                  }
                }
              }),
              const SizedBox(
                height: 20,
              ),
              BarCodeGroupBox(
                enabled: true,
                textEditingController: _kodeBarangTextEditingController,
                helper: 'Ketikkan kode barang yang diinginkan',
                hint: 'Contoh: 123456789',
                label: 'Kode Barang',
                icon: Icons.tag,
                maxLength: 15,
                widget: Consumer<BarangViewModel>(
                    builder: (context, barangProvider, _) {
                  return SecondaryButton(
                    icon: Icons.barcode_reader,
                    label: 'Scan Bar Code',
                    onPressedEvent: () async {
                      barangProvider.barCode = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ));
                      _kodeBarangTextEditingController.text =
                          barangProvider.barCode;
                      if (_kodeBarangTextEditingController.text == '-1') {
                        _kodeBarangTextEditingController.text = '';
                      }
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              NameTextBox(
                enabled: true,
                textEditingController: _namaBarangTextEditingController,
                helperText: 'Ketikkan nama barang yang diinginkan',
                hintText: 'Contoh: Rokok Gudang Gula',
                labelText: 'Nama Barang',
                icon: Icons.inventory_rounded,
                maxLength: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer2<BarangViewModel, NamaPasaranViewModel>(
                  builder: (context, barangProvider, namaPasaranProvider, _) {
                if (barangProvider.kategoriSelectedValue == null ||
                    barangProvider.kategoriSelectedValue == 0) {
                  return const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: MyNoDataWidget2(),
                    ),
                  );
                } else {
                  if (namaPasaranProvider.daftarNamaBarangPasaran == null ||
                      namaPasaranProvider.daftarNamaBarangPasaran!.isEmpty) {
                    return CreateEditGroupBox(
                      icon: Icons.add,
                      itemCount: 1,
                      label: 'Tambah Nama Pasaran',
                      onPressedButton: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                              context, TambahNamaPasaranPage.routeName);
                        }
                      },
                      itemBuilder: (context, index) {
                        return const Text(
                            'Belum ada nama pasaran yang ditambahkan');
                      },
                    );
                  } else {
                    return CreateEditGroupBox(
                      icon: Icons.add,
                      itemCount:
                          namaPasaranProvider.daftarNamaBarangPasaran!.length,
                      label: 'Tambah Nama Pasaran',
                      onPressedButton: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                              context, TambahNamaPasaranPage.routeName);
                        }
                      },
                      itemBuilder: (context, index) {
                        return DeleteListTileSwipe(
                          title: namaPasaranProvider
                              .daftarNamaBarangPasaran![index].namaPasaran!,
                          subtitle: '',
                          trailing: null,
                          onPressedDelete: (context) {
                            namaPasaranProvider
                                .removeListNamaPasaranModel(index);
                          },
                        );
                      },
                    );
                  }
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer2<BarangViewModel, DetailBarangViewModel>(
                  builder: (context, barangProvider, detailBarangProvider, _) {
                if (providerBarang.kategoriSelectedValue == null ||
                    providerBarang.kategoriSelectedValue == 0) {
                  return const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: MyNoDataWidget2(),
                  );
                } else {
                  if (detailBarangProvider.daftarDetailbarang == null ||
                      detailBarangProvider.daftarDetailbarang!.isEmpty) {
                    return CreateEditGroupBox(
                      itemCount: 1,
                      label: 'Tambah Detail Barang',
                      icon: Icons.add,
                      onPressedButton: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                            context,
                            TambahDetailBarangPage.routeName,
                            arguments: TambahDetailBarangArguments(
                              idBarang: int.parse(
                                  _kodeBarangTextEditingController.text),
                              idKategori: barangProvider.kategoriSelectedValue,
                            ),
                          );
                        }
                      },
                      itemBuilder: (context, index) {
                        return const Text(
                            'Belum ada detail barang yang ditambahkan');
                      },
                    );
                  } else {
                    return CreateEditGroupBox(
                      itemCount:
                          detailBarangProvider.daftarDetailbarang!.length,
                      label: 'Tambah Detail Barang',
                      icon: Icons.add,
                      onPressedButton: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                            context,
                            TambahDetailBarangPage.routeName,
                            arguments: TambahDetailBarangArguments(
                              idBarang: int.parse(
                                  _kodeBarangTextEditingController.text),
                              idKategori: barangProvider.kategoriSelectedValue,
                            ),
                          );
                        }
                      },
                      itemBuilder: (context, index) {
                        final int price = detailBarangProvider
                            .daftarDetailbarang![index].hargaBarang!;
                        final String harga = MyFormat.formatUang.format(price);
                        return DeleteListTileSwipe(
                          title: harga,
                          subtitle:
                              'Stok: ${detailBarangProvider.daftarDetailbarang![index].stokBarang}',
                          trailing: detailBarangProvider
                                      .daftarDetailbarang![index].satuan ==
                                  null
                              ? null
                              : Text(
                                  detailBarangProvider
                                      .daftarDetailbarang![index]
                                      .satuan!
                                      .namaSatuan!,
                                  style: const TextStyle(
                                      color: MyColor.successColor),
                                ),
                          onPressedDelete: (context) {
                            detailBarangProvider
                                .removeListDetailBarangModel(index);
                          },
                        );
                      },
                    );
                  }
                }
              }),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                icon: Icons.add,
                label: 'Tambah Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    if (providerBarang.kategoriSelectedValue != null) {
                      if ((providerNamaPasaran.daftarNamaBarangPasaran ==
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isEmpty) &&
                          (providerDetailBarang.daftarDetailbarang == null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isEmpty)) {
                        providerBarang.createBarang(
                            providerBarang.kategoriSelectedValue!,
                            int.parse(_kodeBarangTextEditingController.text),
                            _namaBarangTextEditingController.text);
                      } else if ((providerNamaPasaran.daftarNamaBarangPasaran ==
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isEmpty) &&
                          (providerDetailBarang.daftarDetailbarang != null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isNotEmpty)) {
                        providerBarang.createBarang(
                            providerBarang.kategoriSelectedValue!,
                            int.parse(_kodeBarangTextEditingController.text),
                            _namaBarangTextEditingController.text);
                        providerDetailBarang.createDetailBarang(
                          int.parse(_kodeBarangTextEditingController.text),
                        );
                      } else if ((providerNamaPasaran.daftarNamaBarangPasaran !=
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isNotEmpty) &&
                          (providerDetailBarang.daftarDetailbarang == null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isEmpty)) {
                        providerBarang.createBarang(
                            providerBarang.kategoriSelectedValue!,
                            int.parse(_kodeBarangTextEditingController.text),
                            _namaBarangTextEditingController.text);
                        providerNamaPasaran.createNamaPasaran(
                          int.parse(_kodeBarangTextEditingController.text),
                        );
                      } else {
                        providerBarang.createBarang(
                            providerBarang.kategoriSelectedValue!,
                            int.parse(_kodeBarangTextEditingController.text),
                            _namaBarangTextEditingController.text);
                        providerNamaPasaran.createNamaPasaran(
                          int.parse(_kodeBarangTextEditingController.text),
                        );
                        providerDetailBarang.createDetailBarang(
                          int.parse(_kodeBarangTextEditingController.text),
                        );
                      }
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
