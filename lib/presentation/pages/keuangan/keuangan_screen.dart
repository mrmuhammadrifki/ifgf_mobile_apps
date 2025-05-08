import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/models/trx_response.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/cubit/list_trx_cubit.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/provider/keuangan_provider.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/widgets/filter_by_category.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/list_trx_shimmer.dart';

class KeuanganScreen extends StatefulWidget {
  const KeuanganScreen({super.key});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
  static final _keyLoader = GlobalKey<State>();
  Future<void> _onRefresh({String? date, String? category}) async {
    final refreshDate = date ?? selectedDate?.toIso8601String();
    debugPrint("Pilih : $date - $category");
    context.read<ListTrxCubit>().getAll(date: refreshDate, category: category);
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  final List<String> list = [
    "Semua Transaksi",
    "Persembahan Ibadah",
    "Perpuluhan",
    "Lain-lain",
  ];

  String? _selectedCategory;

  DateTime? selectedDate = DateTime.now();

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: provider.profile?.isAdmin ?? false
          ? CustomAppBar(
              titleText: "Keuangan",
              showBackIcon: true,
              suffixWidget: [
                TextButton(
                  onPressed: () => _onGoToCreateTrx(),
                  child: Text("Tambah").p18sm().blue(),
                )
              ],
            )
          : CustomAppBar(
              titleText: "Keuangan",
              showBackIcon: true,
            ),
      body: Container(
        width: Helper.widthScreen(context),
        height: Helper.heightScreen(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFCCDDF2),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: RefreshIndicator.adaptive(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ListTrxCubit, ListTrxState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => _buildHeroSection(),
                      success: (data) => _buildHeroSection(
                        totalPemasukan: data.totalPemasukan,
                        totalPengeluaran: data.totalPengeluaran,
                        totalSaldo: data.totalSaldo,
                      ),
                      failure: () =>
                          const Center(child: Text('Tidak ada data')),
                    );
                  },
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilterByCategory(
                    list: list,
                    value: _selectedCategory,
                    onChanged: (value) {
                      _selectedCategory = value;
                      _onRefresh(
                        date: selectedDate?.toIso8601String(),
                        category: _selectedCategory == "Semua Transaksi"
                            ? null
                            : _selectedCategory,
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                BlocBuilder<ListTrxCubit, ListTrxState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => ListTrxShimmer(),
                      success: (data) => data.data.isNotEmpty
                          ? _buildList(data: data.data)
                          : const Center(child: Text('Tidak ada data')),
                      failure: () =>
                          const Center(child: Text('Tidak ada data')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList({List<TrxResponse>? data}) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        final item = data?[index];
        return _buildTransactionList(index: index, item: item);
      },
    );
  }

  Widget _buildHeroSection(
      {String? totalPemasukan, String? totalPengeluaran, String? totalSaldo}) {
    return Stack(
      children: [
        Container(
          height: 310,
          width: double.infinity,
          color: BaseColor.blue,
        ),
        Positioned(
          top: 26,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _showMonthYearPicker(context),
                child: Row(
                  children: [
                    Text(
                      selectedDate?.toIso8601String().formattedMonthYear ?? "",
                    ).p16m().white(),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      AssetsIcon.arrowDown,
                      colorFilter: ColorFilter.mode(
                        BaseColor.white,
                        BlendMode.srcIn,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("Saldo").p18r().white(),
              SizedBox(height: 2),
              Text(totalSaldo?.toRupiah() ?? "Rp. 0").p32m().white(),
              SizedBox(height: 16),
              Row(
                children: [
                  _buildCashFlowCard(
                    title: "Pemasukan",
                    total: totalPemasukan?.toRupiah() ?? "Rp. 0",
                    icon: AssetsIcon.arrowDownGreen,
                  ),
                  SizedBox(width: 8),
                  _buildCashFlowCard(
                    title: "Pengeluaran",
                    total: totalPengeluaran?.toRupiah() ?? "Rp. 0",
                    icon: AssetsIcon.arrowUpDanger,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCashFlowCard({
    required String title,
    required String total,
    required String icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: BaseColor.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(icon),
            SizedBox(height: 2),
            Text(title).p14r().black2(),
            SizedBox(height: 4),
            Text(
              total,
              maxLines: 2,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ).p16m().black2(),
          ],
        ),
      ),
    );
  }

  void _showMonthYearPicker(BuildContext context) {
    return showMonthPicker(context, onSelected: (month, year) {
      if (kDebugMode) {
        print('Selected month: $month, year: $year');
      }
      setState(() {
        selectedDate = DateTime(year, month);
      });
      if (selectedDate != null) {
        _onRefresh(
          date: selectedDate?.toIso8601String(),
          category:
              _selectedCategory == "Semua Transaksi" ? null : _selectedCategory,
        );
      }
    },
        initialSelectedMonth: selectedDate?.month ?? 1,
        initialSelectedYear: selectedDate?.year ?? 2025,
        firstYear: 2000,
        lastYear: 2025,
        selectButtonText: 'OK',
        cancelButtonText: 'Cancel',
        highlightColor: Colors.blue,
        textColor: Colors.black,
        contentBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.grey[200]);
  }

  Widget _buildTransactionList({required int index, TrxResponse? item}) {
    final provider = context.watch<ProfileProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: BaseColor.border,
          width: 1,
        ),
      )),
      child: Column(
        children: [
          InkWell(
            onTap: provider.profile?.isAdmin ?? false
                ? () {
                    setState(() {
                      selectedIndex = selectedIndex == index ? null : index;
                    });
                  }
                : () => _onGoToCreateTrx(id: item?.id, isEdit: true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item?.category ?? "").p16m().black2(),
                    SizedBox(height: 2),
                    Text(item?.createdAt?.formattedDate ?? "").p14r().black2(),
                    SizedBox(height: 8),
                  ],
                ),
                Text(
                  item?.jenisTrx?.toLowerCase() == "pemasukan"
                      ? "+${item?.nominal.toString().toRupiah()}"
                      : "-${item?.nominal.toString().toRupiah()}",
                ).p16m().black2(),
              ],
            ),
          ),
          provider.profile?.isAdmin ?? false
              ? AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: selectedIndex == index
                      ? _buildActionButton(
                          key: const ValueKey('action'), id: item?.id)
                      : const SizedBox.shrink(key: ValueKey('empty')),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Future<void> _onDeleteTrx(String? id) async {
    final provider = context.read<KeuanganProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await provider.deleteTrx(id: id);

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      Modal.showSnackBar(
        context,
        text: "Berhasil menghapus transaksi",
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

  void _onGoToCreateTrx({bool? isEdit, String? id}) async {
    final result = await context.push(
      RoutePath.createTrx,
      extra: CreateAcaraParams(isEdit: isEdit ?? false, id: id ?? ""),
    );
    if (result == true) {
      Future.delayed(Duration.zero);
      _onRefresh();
    }
  }

  Row _buildActionButton({Key? key, String? id}) {
    return Row(
      key: key,
      children: [
        InkWell(
          onTap: () async {
            final result = await Modal.showConfirmationDialog(
              context,
              title: "Hapus Transaksi",
              message: "Apakah anda yakin ingin menghapus transaksi ini?",
            );

            if (result == true) {
              _onDeleteTrx(id);
              Future.delayed(Duration.zero);
              _onRefresh();
            }
          },
          child: Row(
            children: [
              SvgPicture.asset(AssetsIcon.delete),
              SizedBox(width: 4),
              Text("Hapus").p14r().red(),
            ],
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: () => _onGoToCreateTrx(isEdit: true, id: id),
          child: Row(
            children: [
              SvgPicture.asset(AssetsIcon.edit),
              SizedBox(width: 4),
              Text("Edit").p14r().black2(),
            ],
          ),
        ),
      ],
    );
  }
}
