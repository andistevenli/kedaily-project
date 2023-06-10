import 'package:flutter/material.dart';
import 'package:kedaily_flutter_project/view/pages/satuan_barang/daftar_satuan_barang_page.dart';
import 'package:kedaily_flutter_project/view/pages/scan_barang/scan_bar_code_barang.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../component/button/floating_bar_code_button.dart';
import '../../component/button/primary_button.dart';
import '../../component/button/secondary_button.dart';
import '../../view_model/inventaris_view_model.dart';
import 'barang/daftar_barang_page.dart';
import 'kategori_barang/daftar_kategori_barang_page.dart';
import 'lokasi_barang/daftar_lokasi_barang_page.dart';

class InventarisPage extends StatelessWidget {
  const InventarisPage({super.key});

  static const routeName = '/inventarisPage';

  @override
  Widget build(BuildContext context) {
    final providerInventaris =
        Provider.of<InventarisViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris'),
      ),
      floatingActionButton: FloatingBarCodeButton(
        toolTip: 'Scan Bar Code',
        onPressed: () async {
          providerInventaris.barCode = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SimpleBarcodeScannerPage(),
            ),
          );
          if (context.mounted) {
            Navigator.pushNamed(context, ScanBarCodeBarang.routeName,
                arguments: ChangeScanBarCodeBarangPageArguments(
                    idBarang: int.parse(providerInventaris.barCode)));
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            SecondaryButton(
              icon: Icons.location_on,
              label: 'Lokasi Barang',
              onPressedEvent: () {
                Navigator.pushNamed(context, DaftarLokasiBarangPage.routeName);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SecondaryButton(
              icon: Icons.category,
              label: 'Kategori Barang',
              onPressedEvent: () {
                Navigator.pushNamed(
                    context, DaftarKategoriBarangPage.routeName);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SecondaryButton(
              icon: Icons.scale,
              label: 'Satuan Barang',
              onPressedEvent: () {
                Navigator.pushNamed(context, DaftarSatuanBarang.routeName);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              icon: Icons.inventory_rounded,
              label: 'Barang',
              onPressedEvent: () {
                Navigator.pushNamed(context, DaftarBarangPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
