import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/widgets/filter_by_category.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  final List<String> list = [
    "Semua Transaksi",
    "Icare",
    "Super Sunday",
    "Discipleship Journey",
  ];

  DateTime? selectedDate = DateTime.now();

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Keuangan",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: () => _onGoToCreateTrx(),
            child: Text("Tambah").p18sm().blue(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _buildMonthYearPicker(context);
                              },
                              child: Text(
                                selectedDate
                                        ?.toIso8601String()
                                        .formattedMonthYear ??
                                    "",
                              ).p16m().white(),
                            ),
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
                        SizedBox(height: 16),
                        Text("Saldo").p18r().white(),
                        SizedBox(height: 2),
                        Text("Rp. 10.000.000").p32m().white(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            _buildCashFlowCard(
                              title: "Pemasukan",
                              total: "Rp. 10.000.000",
                              icon: AssetsIcon.arrowDownGreen,
                            ),
                            SizedBox(width: 8),
                            _buildCashFlowCard(
                              title: "Pengeluaran",
                              total: "Rp. 5.000.000",
                              icon: AssetsIcon.arrowUpDanger,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterByCategory(list: list),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return _buildTransactionList(index: index);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
            Text(total).p16m().black2(),
          ],
        ),
      ),
    );
  }

  void _buildMonthYearPicker(BuildContext context) {
    return showMonthPicker(context, onSelected: (month, year) {
      if (kDebugMode) {
        print('Selected month: $month, year: $year');
      }
      setState(() {
        selectedDate = DateTime(year, month);
      });
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

  Widget _buildTransactionList({required int index}) {
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
            onTap: () {
              setState(() {
                selectedIndex = selectedIndex == index ? null : index;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Makan & Minum").p16m().black2(),
                    SizedBox(height: 2),
                    Text("Senin, 21 April 2025 15.20").p14r().black2(),
                    SizedBox(height: 8),
                  ],
                ),
                Text("-Rp. 80.000").p16m().black2(),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: selectedIndex == index
                ? _buildActionButton(key: const ValueKey('action'))
                : const SizedBox.shrink(key: ValueKey('empty')),
          )
        ],
      ),
    );
  }

  void _onGoToCreateTrx({bool? isEdit}) {
    context.push(RoutePath.createTrx, extra: isEdit);
  }

  Row _buildActionButton({Key? key}) {
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
          onTap: () => _onGoToCreateTrx(isEdit: true),
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
