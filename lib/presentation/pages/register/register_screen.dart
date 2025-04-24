import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final List<DateTime?> _dates = [];

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: BaseColor.softBlue,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: BaseColor.softBlue,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: BaseColor.softBlue,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: BaseColor.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.0),
                    _buildTitle(),
                    SizedBox(height: 24.0),
                    _buildForm(),
                    SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Daftar'),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah punya akun? ').p14r().grey2(),
                        GestureDetector(
                          onTap: _onGoToLogin,
                          child: Text('Login').p14m().blue(),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onGoToLogin() {
    context.pop();
  }

  Widget _buildForm() {
    return Column(
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
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        SizedBox(
          width: 86,
          height: 86,
          child: Image.asset(
            AssetsImage.logo,
          ),
        ),
        SizedBox(height: 8),
        Text('Gereja').p18r().black2(),
        Text('IFGF Purwokerto').p18r().black2(),
        Text('Formulir Pendaftaran Jemaat').p18sm().black2(),
      ],
    );
  }
}
