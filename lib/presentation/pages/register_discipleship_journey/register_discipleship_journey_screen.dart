import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';

class RegisterDiscipleshipJourneyScreen extends StatefulWidget {
  final bool? isEdit;
  const RegisterDiscipleshipJourneyScreen({super.key, this.isEdit});

  @override
  State<RegisterDiscipleshipJourneyScreen> createState() =>
      _RegisterDiscipleshipJourneyScreenState();
}

class _RegisterDiscipleshipJourneyScreenState
    extends State<RegisterDiscipleshipJourneyScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final List<DateTime?> _dates = [];

  final List<String> jenisDiscipleshipJourneyList = [
    "Discipleship Journey 1",
    "Discipleship Journey 2",
    "Discipleship Journey 3",
    "Discipleship Journey 4",
    "Discipleship Journey 5",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false
            ? "Edit Member Discipleship Journey"
            : "Pendaftaran Member Discipleship Journey",
        showBackIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: Helper.heightScreen(context),
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
          child: Column(
            children: [
              CustomTextFormField(
                title: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap-mu ya',
                prefixIcon: AssetsIcon.user,
                keyboardType: TextInputType.name,
                controller: fullNameController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Tanggal Lahir',
                hintText: 'Pilih tanggal lahir-mu ya',
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
                      birthDateController.text =
                          _dates.first?.toString().formattedDate ?? '';
                      log('Selected date: ${birthDateController.text}');
                    },
                  );
                },
                controller: birthDateController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Umur',
                hintText: 'Masukkan umur-mu ya',
                prefixIcon: AssetsIcon.user,
                keyboardType: TextInputType.number,
                controller: ageController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Nomor HP',
                hintText: 'Masukkan nomor hp-mu ya',
                prefixIcon: AssetsIcon.phone,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              SizedBox(height: 20.0),
              CustomDropdown(title: "Jenis Discipleship Journey", list: jenisDiscipleshipJourneyList),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(widget.isEdit ?? false ? "Edit" : "Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
