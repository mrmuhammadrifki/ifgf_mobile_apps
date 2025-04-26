import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';

class DetailJadwal extends StatefulWidget {
  const DetailJadwal({super.key});

  @override
  State<DetailJadwal> createState() => _DetailJadwalState();
}

class _DetailJadwalState extends State<DetailJadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Detail Jadwal',
        showBackIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AssetsImage.thubmnailExample,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Super Sunday").p24m().black2(),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(AssetsIcon.location),
                        SizedBox(width: 3),
                        Text("IFGF Purwokerto").p14m().grey2()
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(AssetsIcon.calendarBlue),
                        SizedBox(width: 3),
                        Text("Jumat, 18 April 2025 20.00").p14m().grey2()
                      ],
                    ),
                    SizedBox(height: 24),
                    Text("Petugas").p18m().black2(),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Preacher",
                      names: "Juwita Kristiani Hia",
                    ),
                    SizedBox(height: 8),
                    _buildPetugas(
                      job: "Singer",
                      names: "Rifki dan Fidel",
                    ),
                    SizedBox(height: 16),
                    Text("Musik").p14m().black2(),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          _buildPetugas(
                            job: "Keyboard",
                            names: "Sukri",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "Bas",
                            names: "Fidel",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "Gitar",
                            names: "Aliya",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "Drum",
                            names: "Fikri",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("The Box").p14m().black2(),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          _buildPetugas(
                            job: "Multimedia",
                            names: "Umar",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "Dokumentasi",
                            names: "Rifki",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "LCD Operator",
                            names: "Tata",
                          ),
                          SizedBox(height: 8),
                          _buildPetugas(
                            job: "Lighting",
                            names: "Abdi",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.red),
                            onPressed: () async {
                              final result = await Modal.showConfirmationDialog(
                                context,
                                title: "Hapus Jadwal",
                                message:
                                    "Apakah anda yakin ingin menghapus jadwal ini?",
                              );
                            },
                            child: Text("Hapus"),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.blue),
                            onPressed: () {
                              _onGoToEditSuperSunday();
                            },
                            child: Text("Edit"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _onGoToEditSuperSunday() {
    context.push(RoutePath.createJadwalSuperSunday, extra: true);
  }

  Widget _buildPetugas({required String job, required String names}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(job).p14r().black2(),
        ),
        const Text(":").p14r().black2(),
        const SizedBox(width: 8),
        Expanded(
          child: Text(names).p14r().black2(),
        ),
      ],
    );
  }
}
