import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constant/my_color.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/text_box/disabled_text_box.dart';
import '../../../component/text_box/general_text_box.dart';
import '../../../view_model/lokasi_barang_view_model.dart';

class UbahLokasiBarangPage extends StatefulWidget {
  const UbahLokasiBarangPage({super.key});

  static const routeName = '/ubahLokasiBarangPage';

  @override
  State<UbahLokasiBarangPage> createState() => _UbahLokasiBarangPage();
}

class _UbahLokasiBarangPage extends State<UbahLokasiBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newDeskripsiTextEditingController =
      TextEditingController();
  final TextEditingController _deskripsiTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _deskripsiTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ChangeLokasiBarangArguments;
    final provider = Provider.of<LokasiBarangViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Lokasi Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
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
                textEditingController: _deskripsiTextEditingController,
                icon: Icons.location_on,
                teks: args.deskripsi,
                label: 'Lokasi',
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
              GeneralTextBox(
                enabled: true,
                textEditingController: _newDeskripsiTextEditingController,
                helperText:
                    'Ketikkan deskripsi yang mewakili lokasi barang yang akan disimpan',
                hintText: 'Contoh: Rak Coklat Baris ke 3',
                labelText: 'Deskripsi',
                icon: Icons.description,
                maxLength: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                icon: Icons.edit,
                label: 'Ubah Lokasi Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    provider.updateLokasiBarang(
                        args.id, _newDeskripsiTextEditingController.text);
                    if (context.mounted) {
                      Navigator.pop(context);
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

class ChangeLokasiBarangArguments {
  final int id;
  final String deskripsi;

  ChangeLokasiBarangArguments({required this.id, required this.deskripsi});
}
