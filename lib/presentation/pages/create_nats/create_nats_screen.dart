import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/create_nats/provider/create_nats_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateNatsScreen extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const CreateNatsScreen({super.key, this.isEdit = false, this.id});

  @override
  State<CreateNatsScreen> createState() => _CreateNatsScreenState();
}

class _CreateNatsScreenState extends State<CreateNatsScreen> {
  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

  final TextEditingController ayatController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final List<DateTime?> _dates = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
        _onGetOneNats(id: widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false ? "Edit Nats" : "Tambah Nats",
        showBackIcon: true,
      ),
      body: SafeArea(
        child: Container(
          height: Helper.heightScreen(context),
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
                _buildForm(context),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onCreateAcara,
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

  void _onGetOneNats({String? id}) async {
    final provider = context.read<CreateNatsProvider>();

    final response = await provider.getOneNats(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      ayatController.text = response.data?.ayat ?? "";
      dateController.text = response.data?.tanggal?.formattedDate ?? "";
      _dates.add(DateTime.parse(response.data?.tanggal ?? ""));
      isiController.text = response.data?.isi ?? "";
      
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

  void _onCreateAcara() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final provider = context.read<CreateNatsProvider>();

    final ayat = ayatController.text;
    final date =  _dates.first;
    final isi = isiController.text;

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit ?? false) {
      final response = await provider.updateNats(
        id: widget.id ?? "",
        date: date?.toIso8601String(),
        ayat: ayat,
        isi: isi,
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengubah nats",
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
      final response = await provider.createNats(
        date: date?.toIso8601String(),
        ayat: ayat,
        isi: isi,
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil menambahkan nats",
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

   

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            title: "Tanggal",
            hintText: "Pilih tanggal ya",
            prefixIcon: AssetsIcon.calendar,
            isReadOnly: true,
            isPicker: true,
            onTap: () async {
              await Helper.showCalendarPickerHelper(
                context: context,
                initialDates: [DateTime.now()],
                onDateSelected: (selectedDateTime) {
                  _dates
                    ..clear()
                    ..add(selectedDateTime.first);
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
            title: "Ayat",
            hintText: "Masukkan nama ayat ya",
            prefixIcon: AssetsIcon.book,
            controller: ayatController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Isi Ayat",
            hintText: "Masukkan isi ayat ya",
            prefixIcon: AssetsIcon.ayat,
            controller: isiController,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
