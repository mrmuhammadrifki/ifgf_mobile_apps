import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/register_discipleship_journey/provider/register_discipleship_journey_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterDiscipleshipJourneyScreen extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const RegisterDiscipleshipJourneyScreen({super.key, this.isEdit, this.id});

  @override
  State<RegisterDiscipleshipJourneyScreen> createState() =>
      _RegisterDiscipleshipJourneyScreenState();
}

class _RegisterDiscipleshipJourneyScreenState
    extends State<RegisterDiscipleshipJourneyScreen> {
  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

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
    "Kelas Come",
    "Kelas Grow",
    "Kelas Serve",
    "Kelas Lead",
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
        _onGetOneMemberDisciplehipJournet(id: widget.id);
      }
    });
  }

  String? _selectedDiscipleshipJourney;

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
                    title: "Jenis Discipleship Journey",
                    list: jenisDiscipleshipJourneyList,
                    value: _selectedDiscipleshipJourney,
                    onChanged: (value) {
                      _selectedDiscipleshipJourney = value;
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onRegisterDiscipleshipJouney,
                      child: Text(widget.isEdit ?? false ? "Edit" : "Simpan"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onGetOneMemberDisciplehipJournet({String? id}) async {
    final provider = context.read<RegisterDiscipleshipJourneyProvider>();

    final response = await provider.getOneMemberDiscipleshipJourney(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      fullNameController.text = response.data?.fullName ?? "";
      birthDateController.text = response.data?.birthDate?.formattedDate ?? "";
      _dates.add(DateTime.parse(response.data?.birthDate ?? ""));
      ageController.text = response.data?.age ?? "";
      phoneController.text = response.data?.phoneNumber ?? "";
      setState(() {
        _selectedDiscipleshipJourney =
            response.data?.jenisDiscipleshipJourney ??
                jenisDiscipleshipJourneyList.first;
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

  void _onRegisterDiscipleshipJouney() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final provider = context.read<RegisterDiscipleshipJourneyProvider>();

    final fullName = fullNameController.text;
    final birthDate = _dates.first;
    final age = ageController.text;
    final phone = phoneController.text;
    final jenisDiscipleshipJourney =
        _selectedDiscipleshipJourney ?? jenisDiscipleshipJourneyList.first;

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit ?? false) {
      final response = await provider.updateMemberDiscipleshipJourney(
        id: widget.id,
        fullName: fullName,
        birthDate: birthDate?.toIso8601String(),
        age: age,
        phone: phone,
        jenisDiscipleshipJourney: jenisDiscipleshipJourney,
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengubah discipleship journey",
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
      final response = await provider.registerDiscipleshipJourney(
          fullName: fullName,
          birthDate: birthDate?.toIso8601String(),
          age: age,
          phone: phone,
          jenisDiscipleshipJourney: jenisDiscipleshipJourney);

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mendaftar discipleship journey",
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
