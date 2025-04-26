import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';

class CreateTrxScreen extends StatefulWidget {
  final bool? isEdit;
  const CreateTrxScreen({super.key, this.isEdit = false});

  @override
  State<CreateTrxScreen> createState() => _CreateTrxScreenState();
}

class _CreateTrxScreenState extends State<CreateTrxScreen> {
  final TextEditingController jenisTrxController = TextEditingController();
  final TextEditingController kategoriTrxController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  final List<DateTime?> _dates = [];

  final List<String> listJenisTrx = ["Pemasukan", "Pengeluaran"];

  final List<String> listKategoriTrx = [
    "Makan",
    "Minum",
    "Uang Mingguan",
    "Lain-lain"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText:
            widget.isEdit ?? false ? "Edit Transaksi" : "Tambah Transaksi",
        showBackIcon: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFCCDDF2),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdown(title: "Jenis Transaksi", list: listJenisTrx),
                SizedBox(height: 20),
                CustomDropdown(
                    title: "Kategori Transaksi", list: listKategoriTrx),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Tanggal Transaksi",
                  hintText: "Pilih tanggal transaksi ya",
                  prefixIcon: AssetsIcon.calendar,
                  isReadOnly: true,
                  isPicker: true,
                  onTap: () async {
                    await Helper.showCalendarPickerHelper(
                      context: context,
                      initialDates: _dates,
                      onDateSelected: (selectedDates) {
                        _dates
                          ..clear()
                          ..addAll(selectedDates);
                        dateController.text =
                            _dates.first?.toString().formattedDate ?? '';
                        log('Selected date: ${dateController.text}');
                      },
                    );
                  },
                  controller: dateController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Nominal",
                  hintText: "Masukkan nominal transaksi ya",
                  prefixIcon: AssetsIcon.moneyBlack,
                  keyboardType: TextInputType.number,
                  controller: totalController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Catatan",
                  hintText: "Masukkan catatan jika perlu ya",
                  prefixIcon: AssetsIcon.edit,
                  controller: totalController,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(widget.isEdit ?? false ? "Edit" : "Simpan"),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
