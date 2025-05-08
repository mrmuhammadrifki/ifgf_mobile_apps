import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
import 'package:ifgf_apps/data/data_sources/local/shared_pref.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/provider/firebase_auth_provider.dart';
import 'package:ifgf_apps/presentation/pages/register_jemaat/provider/register_jemaat_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterJemaatScreen extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const RegisterJemaatScreen({super.key, this.isEdit, this.id});

  @override
  State<RegisterJemaatScreen> createState() => _RegisterJemaatScreenState();
}

class _RegisterJemaatScreenState extends State<RegisterJemaatScreen> {
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

  final list = [
    "Jemaat",
    "Admin",
  ];

  String? _selectedStatus;

  String? _initialName;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
        _onGetDetailJemaat(id: widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText:
            widget.isEdit ?? false ? "Edit Jemaat" : "Pendaftaran Jemaat Baru",
        showBackIcon: true,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Consumer<RegisterJemaatProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        provider.imageSelected.isEmpty
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: BaseColor.border,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    _initialName != null
                                        ? _initialName ?? ""
                                        : "Foto",
                                  ).p28m().black2(),
                                ),
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      provider.imageSelected.first?.url ?? "",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        SizedBox(height: 8),
                        _imagePickerDialog()
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
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
                CustomDropdown(
                  list: list,
                  title: "Status",
                  value: _selectedStatus,
                  onChanged: (value) {
                    _selectedStatus = value;
                  },
                ),
                SizedBox(height: 20.0),
                CustomTextFormField(
                  title: 'Email',
                  hintText: 'Masukkan email-mu ya',
                  prefixIcon: AssetsIcon.user,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  isReadOnly: widget.isEdit,
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
                if (widget.isEdit != true) SizedBox(height: 20.0),
                if (widget.isEdit != true)
                  CustomTextFormField(
                    title: 'Password',
                    hintText: 'Masukkan password-mu ya',
                    prefixIcon: AssetsIcon.password,
                    isPassword: true,
                    obscureText: true,
                    controller: passwordController,
                  ),
                if (widget.isEdit != true) SizedBox(height: 20.0),
                if (widget.isEdit != true)
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
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onRegister,
                    child: Text(widget.isEdit ?? false ? "Edit" : "Simpan"),
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
    final provider = context.read<RegisterJemaatProvider>();
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
                  onTap: () {
                    context.pop();
                    provider.selectImage(
                      index: 0,
                    );
                  },
                  child: _buildImageSource(title: "Ambil dari kamera"),
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    context.pop();
                    provider.selectImage(
                      index: 1,
                    );
                  },
                  child: _buildImageSource(title: "Ambil dari galeri"),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
      child: Text("Ganti Foto Profil").p16m().blue(),
    );
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

  void _onGetDetailJemaat({String? id}) async {
    final provider = context.read<RegisterJemaatProvider>();

    final response = await provider.getDetailJemaat(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      fullNameController.text = response.data?.fullName ?? "";
      birthDateController.text = response.data?.birthDate.formattedDate ?? "";
      _dates.add(DateTime.parse(response.data?.birthDate ?? ""));
      phoneController.text = response.data?.phoneNumber ?? "";
      emailController.text = response.data?.email ?? "";
      setState(() {
        _selectedStatus =
            response.data?.isAdmin == true ? list.last : list.first;
        _initialName = response.data?.fullName.getInitials;
      });
      final photoProfile = response.data?.photoProfile;
      if (photoProfile != null && photoProfile.isNotEmpty) {
        final profile = photoProfile.first;
        if (profile?.url.isNotEmpty == true) {
          provider.addImage(profile);
        }
      }
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

  void _onRegister() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final email = emailController.text;
    final password = passwordController.text;
    final fullname = fullNameController.text;
    final birthDate = _dates.first;
    final phone = phoneController.text;
    final status = _selectedStatus ?? list.first;
    final isAdmin = status == "Jemaat" ? false : true;

    final firebaseAuthProvider = context.read<FirebaseAuthProvider>();
    final provider = context.read<RegisterJemaatProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit == true) {
      final response = await provider.updateJemaat(
        uid: widget.id,
        fullName: fullname,
        birthDate: birthDate,
        phoneNumber: phone,
        isAdmin: isAdmin,
        photoProfile: provider.imageSelected.isEmpty
            ? ImageResponse(url: "", filePath: "")
            : provider.imageSelected.first,
      );

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (!mounted) return;

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengubah akun",
          snackbarType: SnackbarType.success,
        );
      } else {
        final errorMessage = response.error?.toString() ??
            "Terjadi kesalahan, silakan coba lagi.";
        Modal.showSnackBar(
          context,
          text: errorMessage,
          snackbarType: SnackbarType.danger,
        );
      }
    } else {
      final response = await firebaseAuthProvider.signUp(
        email: email,
        password: password,
        fullName: fullname,
        birthDate: birthDate,
        phoneNumber: phone,
        isAdmin: isAdmin,
        photoProfile: provider.imageSelected.isEmpty
            ? ImageResponse(url: "", filePath: "")
            : provider.imageSelected.first,
      );

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (!mounted) return;

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil daftar akun",
          snackbarType: SnackbarType.success,
        );
      } else {
        final errorMessage = response.error?.toString() ??
            "Terjadi kesalahan, silakan coba lagi.";
        Modal.showSnackBar(
          context,
          text: errorMessage,
          snackbarType: SnackbarType.danger,
        );
      }
    }
  }
}
