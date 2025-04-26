import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_super_sunday/create_jadwal_super_sunday_provider/create_jadwal_super_sunday_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateJadwalSuperSunday extends StatefulWidget {
  final bool? isEdit;
  const CreateJadwalSuperSunday({super.key, this.isEdit = false});

  @override
  State<CreateJadwalSuperSunday> createState() =>
      _CreateJadwalSuperSundayState();
}

class _CreateJadwalSuperSundayState extends State<CreateJadwalSuperSunday> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController preacherController = TextEditingController();
  final TextEditingController singerController = TextEditingController();
  final TextEditingController keyboardController = TextEditingController();
  final TextEditingController basController = TextEditingController();
  final TextEditingController gitarController = TextEditingController();
  final TextEditingController drumController = TextEditingController();
  final TextEditingController multimediaController = TextEditingController();
  final TextEditingController dokumentasiController = TextEditingController();
  final TextEditingController lcdOperatorController = TextEditingController();
  final TextEditingController lightingController = TextEditingController();

  final List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false
            ? "Edit Super Sunday"
            : "Tambah Super Sunday",
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
                  title: "Lokasi Jadwal",
                  hintText: "Masukkan tempat jadwal ya",
                  prefixIcon: AssetsIcon.locationBlack,
                  controller: locationController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Preacher",
                  hintText: "Masukkan petugas preacher ya",
                  prefixIcon: AssetsIcon.user,
                  controller: preacherController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Singer",
                  hintText: "Masukkan petugas singer ya",
                  prefixIcon: AssetsIcon.user,
                  controller: singerController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Keyboard",
                  hintText: "Masukkan petugas keyboard ya",
                  prefixIcon: AssetsIcon.user,
                  controller: keyboardController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Bas",
                  hintText: "Masukkan petugas bas ya",
                  prefixIcon: AssetsIcon.user,
                  controller: basController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Gitar",
                  hintText: "Masukkan petugas gitar ya",
                  prefixIcon: AssetsIcon.user,
                  controller: gitarController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Drum",
                  hintText: "Masukkan petugas drum ya",
                  prefixIcon: AssetsIcon.user,
                  controller: drumController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Multimedia",
                  hintText: "Masukkan petugas multimedia ya",
                  prefixIcon: AssetsIcon.user,
                  controller: multimediaController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Dokumentasi",
                  hintText: "Masukkan petugas dokumentasi ya",
                  prefixIcon: AssetsIcon.user,
                  controller: dokumentasiController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "LCD Operator",
                  hintText: "Masukkan petugas LCD Operator ya",
                  prefixIcon: AssetsIcon.user,
                  controller: lcdOperatorController,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  title: "Lighting",
                  hintText: "Masukkan petugas lighting ya",
                  prefixIcon: AssetsIcon.user,
                  controller: lightingController,
                ),
                SizedBox(height: 20),
                Text("Upload Foto").p14r().black2(),
                SizedBox(height: 4),
                _imagePickerDialog(),
                SizedBox(height: 16),
                Text("Note:\nGunakan pemisah koma jika petugas lebih dari satu orang.")
                    .p14r()
                    .black2(),
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
    final provider = context.read<CreateJadwalSuperSundayProvider>();
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
