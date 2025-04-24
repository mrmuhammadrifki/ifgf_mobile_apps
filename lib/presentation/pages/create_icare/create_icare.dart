import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/create_icare/create_icare_provider/create_icare_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateIcare extends StatefulWidget {
  final bool? isEdit;
  const CreateIcare({super.key, this.isEdit = false});

  @override
  State<CreateIcare> createState() => _CreateIcareState();
}

class _CreateIcareState extends State<CreateIcare> {
  final TextEditingController jenisIcareController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final List<DateTime?> _dates = [];

  final List<String> jenisIcareList = [
    "Icare 1",
    "Icare 2",
    "Icare 3",
    "Icare 4",
    "Icare 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false ? "Edit Icare" : "Tambah Icare",
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
                CustomDropdown(title: "Jenis Icare", list: jenisIcareList),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Tanggal Jadwal",
                  hintText: "Pilih tanggal jadwal ya",
                  prefixIcon: AssetsIcon.calendar,
                  isReadOnly: true,
                  isPicker: true,
                  onTap: () async {
                    await Helper.showDateTimePickerHelper(
                      context: context,
                      initialDate: DateTime.now(),
                      onDateTimeSelected: (selectedDateTime) {
                        _dates
                          ..clear()
                          ..add(selectedDateTime);
                        dateController.text =
                            _dates.first?.toString().formattedDateTime ?? '';
                        log('Selected date: ${dateController.text}');
                      },
                    );
                  },
                  controller: dateController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Tempat",
                  hintText: "Masukkan tempat ya",
                  prefixIcon: AssetsIcon.locationBlack,
                  controller: locationController,
                ),
                SizedBox(height: 20),
                Text("Upload Foto").p14r().black2(),
                SizedBox(height: 4),
                _imagePickerDialog(),
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

  Widget _imagePickerDialog() {
    final provider = context.read<CreateIcareProvider>();
    return InkWell(
        onTap: () {
          Modal.baseBottomSheet(
            context,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Pilih Foto").p18m().black2(),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () => provider.selectImage(index: 0),
                    child: _buildImageSource(title: "Ambil dari kamera"),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () => provider.selectImage(index: 1),
                    child: _buildImageSource(title: "Ambil dari galeri"),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
        child: _buildCustomButton(title: "Thumbnail"));
  }

  Widget _buildImageSource({required String title}) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ).p16r().black2(),
    );
  }

  Widget _buildCustomButton({required String title}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsIcon.camera),
          SizedBox(width: 3),
          Text(title).p16r().black2(),
        ],
      ),
    );
  }
}
