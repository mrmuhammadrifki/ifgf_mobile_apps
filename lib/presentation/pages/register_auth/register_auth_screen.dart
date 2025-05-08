import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/message.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/provider/firebase_auth_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterAuthScreen extends StatefulWidget {
  const RegisterAuthScreen({super.key});

  @override
  State<RegisterAuthScreen> createState() => _RegisterAuthScreenState();
}

class _RegisterAuthScreenState extends State<RegisterAuthScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final List<DateTime?> _dates = [];

  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

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
                        onPressed: _onRegister,
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

  void _onRegister() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final email = emailController.text;
    final password = passwordController.text;
    final fullname = fullNameController.text;
    final birthDate = _dates.first;
    final phone = phoneController.text;

    final firebaseAuthProvider = context.read<FirebaseAuthProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await firebaseAuthProvider.signUp(
      email: email,
      password: password,
      fullName: fullname,
      birthDate: birthDate,
      phoneNumber: phone,
    );

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      context.pop();
      Modal.showSnackBar(
        context,
        text: "Berhasil daftar akun",
        snackbarType: SnackbarType.success,
      );
    } else {
      final errorMessage =
          response.error?.toString() ?? "Terjadi kesalahan, silakan coba lagi.";
      Modal.showSnackBar(
        context,
        text: errorMessage,
        snackbarType: SnackbarType.danger,
      );
    }
  }

  void _onGoToLogin() {
    context.pop();
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
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
            title: 'Email',
            hintText: 'Masukkan email-mu ya',
            prefixIcon: AssetsIcon.user,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: (value) {
              value = value ?? "";

              if (value.isEmptyWithTrim()) {
                return ErrorMessage.required;
              }

              if (!value.isValidEmail()) {
                return ErrorMessage.emailValid;
              }

              return null;
            },
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
            validator: (value) {
              value = value ?? "";

              if (value.isEmptyWithTrim()) {
                return ErrorMessage.required;
              }

              if (value != passwordController.text) {
                return ErrorMessage.passwordSame;
              }

              return null;
            },
          ),
        ],
      ),
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
