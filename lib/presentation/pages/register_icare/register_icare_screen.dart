import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/register_icare/provider/register_icare_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterIcareScreen extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const RegisterIcareScreen({super.key, this.isEdit, this.id});

  @override
  State<RegisterIcareScreen> createState() => _RegisterIcareScreenState();
}

class _RegisterIcareScreenState extends State<RegisterIcareScreen> {
  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<DateTime?> _dates = [];

  final listJenisIcare = [
    "Icare Kampus",
    "Icare Teens",
    "Icare Women",
    "Icare Keluarga Muda"
  ];

  String? _selectedJenisIcare;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
        _onGetOneMemberIcare(id: widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false
            ? "Edit Member Icare"
            : "Pendaftaran Member Icare",
        showBackIcon: true,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Form(
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
                CustomDropdown(
                  title: "Jenis Icare",
                  list: listJenisIcare,
                  value: _selectedJenisIcare,
                  onChanged: (value) {
                    _selectedJenisIcare = value;
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onRegisterIcare,
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

  void _onGetOneMemberIcare({String? id}) async {
    final provider = context.read<RegisterIcareProvider>();

    final response = await provider.getOneMemberIcare(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      fullNameController.text = response.data?.fullName ?? "";
      birthDateController.text =
          response.data?.birthDate?.formattedDate ?? "";
      _dates.add(DateTime.parse(response.data?.birthDate ?? ""));
      ageController.text = response.data?.age ?? "";
      phoneController.text = response.data?.phoneNumber ?? "";
      setState(() {
        _selectedJenisIcare = response.data?.jenisIcare ?? listJenisIcare.first;
      });
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

  void _onRegisterIcare() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final provider = context.read<RegisterIcareProvider>();

    final fullName = fullNameController.text;
    final birthDate = _dates.first;
    final age = ageController.text;
    final phone = phoneController.text;
    final jenisIcare = _selectedJenisIcare ?? listJenisIcare.first;

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit ?? false) {
      final response = await provider.updateMemberIcare(
          id: widget.id,
          fullName: fullName,
          birthDate: birthDate?.toIso8601String(),
          age: age,
          phone: phone,
          jenisIcare: jenisIcare);

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengubah member icare",
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
      final response = await provider.registerIcare(
          fullName: fullName,
          birthDate: birthDate?.toIso8601String(),
          age: age,
          phone: phone,
          jenisIcare: jenisIcare);

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mendaftar icare",
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
