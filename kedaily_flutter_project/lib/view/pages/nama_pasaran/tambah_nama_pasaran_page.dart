import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/button/primary_button.dart';
import '../../../component/text_box/name_text_box.dart';
import '../../../view_model/nama_pasaran_view_model.dart';

class TambahNamaPasaranPage extends StatefulWidget {
  const TambahNamaPasaranPage({super.key});

  static const routeName = '/tambahNamaPasaranPage';

  @override
  State<TambahNamaPasaranPage> createState() => _TambahNamaPasaranPageState();
}

class _TambahNamaPasaranPageState extends State<TambahNamaPasaranPage> {
  final TextEditingController _namaPasaranTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NamaPasaranViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Nama Pasaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              NameTextBox(
                enabled: true,
                textEditingController: _namaPasaranTextEditingController,
                helperText: 'Ketikkan nama lain (pasaran) terkait barang ini',
                hintText: 'Contoh: Racun (Rokok)',
                labelText: 'Nama Pasaran',
                icon: Icons.inventory_rounded,
                maxLength: 20,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                icon: Icons.add,
                label: 'Tambah Nama Pasaran',
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    provider.addListNamaPasaranModel(
                        _namaPasaranTextEditingController.text);
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
