import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constant/my_color.dart';
import '../../../../constant/my_format.dart';
import '../../../component/box_detail_info.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/drop_down_item.dart';
import '../../../component/group_box/create_detail_barang_group_box.dart';
import '../../../component/group_box/create_edit_group_box.dart';
import '../../../component/list_tile_swipe/delete_list_tile_swipe.dart';
import '../../../component/list_tile_swipeless.dart';
import '../../../component/my_loading_animation.dart';
import '../../../component/my_no_data_widget_2.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../view_model/barang_view_model.dart';
import '../../../view_model/detail_barang_view_model.dart';
import '../../../view_model/kategori_barang_view_model.dart';
import '../../../view_model/lokasi_barang_view_model.dart';
import '../../../view_model/nama_pasaran_view_model.dart';
import '../detail_barang/tambah_detail_barang_page.dart';
import '../nama_pasaran/tambah_nama_pasaran_page.dart';

class UbahBarangPage extends StatefulWidget {
  const UbahBarangPage({super.key});

  static const routeName = '/ubahBarangPage';

  @override
  State<UbahBarangPage> createState() => _UbahBarangPageState();
}

class _UbahBarangPageState extends State<UbahBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaBarangTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaBarangTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChangeBarangArguments;
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
        title: const Text('Ubah Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
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
                      args.idBarang.toString(),
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
              BoxDetailInfo(
                subInfo: 'Nama Barang:',
                info: args.namaBarang,
              ),
              const SizedBox(
                height: 20,
              ),
              args.namaPasaranBarangArguments == null
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
                      itemCount: args.namaPasaranBarangArguments!.length,
                      itemBuilder: (context, index) {
                        return ListTileSwipeless(
                          title: args.namaPasaranBarangArguments![index]
                              .namaPasaranBarang,
                          subtitle: '',
                        );
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              args.detailBarangArguments == null
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
                      itemCount: args.detailBarangArguments!.length,
                      itemBuilder: (context, index) {
                        final int price =
                            args.detailBarangArguments![index].hargaBarang;
                        final String harga = MyFormat.formatUang.format(price);
                        return ListTileSwipeless(
                          title: harga,
                          subtitle:
                              'stok: ${args.detailBarangArguments![index].stokBarang.toString()}',
                          trailing: Text(
                            args.detailBarangArguments![index].satuanBarang,
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              BoxDetailInfo(
                subInfo: 'Kategori Barang:',
                info: args.kategoriBarang == null ? '-' : args.kategoriBarang!,
              ),
              const SizedBox(
                height: 20,
              ),
              BoxDetailInfo(
                subInfo: 'Lokasi Barang:',
                info: args.lokasiBarang == null ? '-' : args.lokasiBarang!,
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
                              idBarang: int.parse(args.idBarang.toString()),
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
                              idBarang: int.parse(args.idBarang.toString()),
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
                label: 'Ubah Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    if (providerBarang.kategoriSelectedValue != null) {
                      providerNamaPasaran.deleteNamaPasaran(args.idBarang);
                      providerDetailBarang.deleteDetailBarang(args.idBarang);
                      if ((providerNamaPasaran.daftarNamaBarangPasaran ==
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isEmpty) &&
                          (providerDetailBarang.daftarDetailbarang == null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isEmpty)) {
                        providerBarang.updateBarang(
                            args.idBarang,
                            providerBarang.kategoriSelectedValue!,
                            _namaBarangTextEditingController.text);
                      } else if ((providerNamaPasaran.daftarNamaBarangPasaran ==
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isEmpty) &&
                          (providerDetailBarang.daftarDetailbarang != null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isNotEmpty)) {
                        providerBarang.updateBarang(
                            args.idBarang,
                            providerBarang.kategoriSelectedValue!,
                            _namaBarangTextEditingController.text);
                        providerDetailBarang.createDetailBarang(args.idBarang);
                      } else if ((providerNamaPasaran.daftarNamaBarangPasaran !=
                                  null ||
                              providerNamaPasaran
                                  .daftarNamaBarangPasaran!.isNotEmpty) &&
                          (providerDetailBarang.daftarDetailbarang == null ||
                              providerDetailBarang
                                  .daftarDetailbarang!.isEmpty)) {
                        providerBarang.updateBarang(
                            args.idBarang,
                            providerBarang.kategoriSelectedValue!,
                            _namaBarangTextEditingController.text);
                        providerNamaPasaran.createNamaPasaran(args.idBarang);
                      } else {
                        providerBarang.updateBarang(
                            args.idBarang,
                            providerBarang.kategoriSelectedValue!,
                            _namaBarangTextEditingController.text);
                        providerNamaPasaran.createNamaPasaran(args.idBarang);
                        providerDetailBarang.createDetailBarang(args.idBarang);
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

class ChangeBarangArguments {
  final int idBarang;
  final String namaBarang;
  final String? lokasiBarang;
  final String? kategoriBarang;
  final List<NamaPasaranBarangArguments>? namaPasaranBarangArguments;
  final List<DetailBarangArguments>? detailBarangArguments;

  ChangeBarangArguments({
    required this.idBarang,
    required this.namaBarang,
    required this.lokasiBarang,
    required this.kategoriBarang,
    required this.namaPasaranBarangArguments,
    required this.detailBarangArguments,
  });
}

class DetailBarangArguments {
  final int hargaBarang;
  final int stokBarang;
  final String satuanBarang;

  DetailBarangArguments({
    required this.hargaBarang,
    required this.stokBarang,
    required this.satuanBarang,
  });
}

class NamaPasaranBarangArguments {
  final String namaPasaranBarang;

  NamaPasaranBarangArguments({required this.namaPasaranBarang});
}
