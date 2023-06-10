import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../component/button/primary_button.dart';
import '../../../component/text_box/general_text_box.dart';
import '../../../view_model/lokasi_barang_view_model.dart';

class TambahLokasiBarangPage extends StatefulWidget {
  const TambahLokasiBarangPage({super.key});

  static const routeName = '/tambahLokasiBarangPage';

  @override
  State<TambahLokasiBarangPage> createState() => _TambahLokasiBarangPageState();
}

class _TambahLokasiBarangPageState extends State<TambahLokasiBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _deskripsiTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _deskripsiTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LokasiBarangViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Lokasi Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              GeneralTextBox(
                enabled: true,
                textEditingController: _deskripsiTextEditingController,
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
                icon: Icons.add,
                label: 'Tambah Lokasi Barang',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    provider.createLokasiBarang(
                        _deskripsiTextEditingController.text);
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
