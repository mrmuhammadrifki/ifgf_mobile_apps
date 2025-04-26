import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';

class RegisterJemaatScreen extends StatefulWidget {
  final bool? isEdit;
  const RegisterJemaatScreen({super.key, this.isEdit});

  @override
  State<RegisterJemaatScreen> createState() => _RegisterJemaatScreenState();
}

class _RegisterJemaatScreenState extends State<RegisterJemaatScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final List<DateTime?> _dates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText:
            widget.isEdit ?? false ? "Edit Jemaat" : "Pendaftaran Jemaat Baru",
        showBackIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
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
                title: 'Nomor HP',
                hintText: 'Masukkan nomor hp-mu ya',
                prefixIcon: AssetsIcon.phone,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Username',
                hintText: 'Masukkan username-mu ya',
                prefixIcon: AssetsIcon.user,
                keyboardType: TextInputType.name,
                controller: usernameController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Password',
                hintText: 'Masukkan password-mu ya',
                prefixIcon: AssetsIcon.password,
                isPassword: true,
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                title: 'Konfirmasi Password',
                hintText: 'Masukkan konfirmasi password-mu ya',
                prefixIcon: AssetsIcon.password,
                textInputAction: TextInputAction.done,
                isPassword: true,
                obscureText: true,
                controller: passwordConfirmController,
              ),
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
