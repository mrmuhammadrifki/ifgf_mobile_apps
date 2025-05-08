import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/currency_input_formatter.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/create_trx/provider/create_trx_provider.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_dropdown.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateTrxScreen extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const CreateTrxScreen({super.key, this.isEdit = false, this.id});

  @override
  State<CreateTrxScreen> createState() => _CreateTrxScreenState();
}

class _CreateTrxScreenState extends State<CreateTrxScreen> {
  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final List<DateTime?> _dates = [];

  final List<String> listJenisTrx = ["Pemasukan", "Pengeluaran"];

  final List<String> listKategoriTrx = [
    "Persembahan Ibadah",
    "Perpuluhan",
    "Lain-lain"
  ];

  String? _selectedJenisTrx;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
      _onGetOneTrx(id: widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        titleText:
            widget.isEdit ?? false ? "Edit Transaksi" : "Tambah Transaksi",
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown(
                    title: "Jenis Transaksi",
                    list: listJenisTrx,
                    value: _selectedJenisTrx,
                    onChanged: provider.profile?.isAdmin ?? false
                        ? (value) {
                            _selectedJenisTrx = value;
                            debugPrint(_selectedJenisTrx);
                          }
                        : null,
                  ),
                  SizedBox(height: 20),
                  CustomDropdown(
                    title: "Kategori Transaksi",
                    list: listKategoriTrx,
                    value: _selectedCategory,
                    onChanged: provider.profile?.isAdmin ?? false
                        ? (value) {
                            _selectedCategory = value;
                            debugPrint(_selectedCategory);
                          }
                        : null,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: "Tanggal Transaksi",
                    hintText: "Pilih tanggal transaksi ya",
                    prefixIcon: AssetsIcon.calendar,
                    isReadOnly: true,
                    isPicker: true,
                    onTap: provider.profile?.isAdmin ?? false
                        ? () async {
                            await Helper.showCalendarPickerHelper(
                              context: context,
                              initialDates: [DateTime.now()],
                              onDateSelected: (selectedDates) {
                                _dates
                                  ..clear()
                                  ..addAll(selectedDates);
                                dateController.text =
                                    _dates.first?.toString().formattedDate ??
                                        '';
                                log('Selected date: ${dateController.text}');
                              },
                            );
                          }
                        : null,
                    controller: dateController,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: "Nominal",
                    hintText: "Masukkan nominal transaksi ya",
                    prefixIcon: AssetsIcon.moneyBlack,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyInputFormatter()],
                    isReadOnly: provider.profile?.isAdmin == false,
                    controller: nominalController,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: "Catatan",
                    hintText: "Masukkan catatan jika perlu ya",
                    prefixIcon: AssetsIcon.edit,
                    isRequired: false,
                    isReadOnly: provider.profile?.isAdmin == false,
                    controller: noteController,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.profile?.isAdmin ?? false
                          ? _onCreateTrx
                          : null,
                      child: Text(
                        widget.isEdit ?? false ? "Edit" : "Simpan",
                      ),
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

  void _onGetOneTrx({String? id}) async {
    final provider = context.read<CreateTrxProvider>();

    final response = await provider.getOneTrx(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      setState(() {
        _selectedJenisTrx = response.data?.jenisTrx ?? "";
        _selectedCategory = response.data?.category ?? "";
      });
      _dates.add(DateTime.parse(response.data?.createdAt ?? ""));
      dateController.text = response.data?.createdAt?.formattedDate ?? "";
      nominalController.text = response.data?.nominal.toString() ?? "";
      noteController.text = response.data?.note ?? "";
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

  void _onCreateTrx() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final provider = context.read<CreateTrxProvider>();

    final jenisTrx = _selectedJenisTrx ?? listJenisTrx.first;
    final category = _selectedCategory ?? listKategoriTrx.first;
    final createdAt = _dates.first;
    final nominal = nominalController.text.replaceAll('.', '');
    final note = noteController.text;

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit ?? false) {
      final response = await provider.updateTrx(
        id: widget.id ?? "",
        jenisTrx: jenisTrx,
        category: category,
        createdAt: createdAt?.toIso8601String(),
        nominal: nominal,
        note: note,
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengedit transaksi",
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
      final response = await provider.createTrx(
        jenisTrx: jenisTrx,
        category: category,
        createdAt: createdAt?.toIso8601String(),
        nominal: nominal,
        note: note,
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil menambahkan transaksi",
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
