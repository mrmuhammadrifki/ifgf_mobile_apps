import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/event_card.dart';

class AcaraScreen extends StatefulWidget {
  const AcaraScreen({super.key});

  @override
  State<AcaraScreen> createState() => _AcaraScreenState();
}

class _AcaraScreenState extends State<AcaraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Acara",
        showBackIcon: true,
        suffixWidget: [
          TextButton(
            onPressed: () => _onGoToCreateAcara(),
            child: Text("Tambah").p18sm().blue(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
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
              Text("Acara Terdekat Minggu Ini").p18m().black2(),
              SizedBox(height: 16),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCard(
                    title: "Party",
                    location: "IFGF Purwokerto",
                    dateTime: "Jumat, 18 April 2025 20.00",
                    imageUrl: AssetsImage.acaraExample,
                    actionButtons: _buildActionButton(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onGoToCreateAcara({bool? isEdit}) {
    context.push(RoutePath.createAcara, extra: isEdit);
  }

  List<Widget> _buildActionButton() {
    return [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.red,
          ),
          onPressed: () async {
            final result = await Modal.showConfirmationDialog(
              context,
              title: "Hapus Acara",
              message: "Apakah anda yakin ingin menghapus acara ini?",
            );
          },
          child: Text("Hapus"),
        ),
      ),
      SizedBox(width: 4),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.yellow,
          ),
          onPressed: () => _onGoToCreateAcara(isEdit: true),
          child: Text("Edit"),
        ),
      ),
      SizedBox(width: 4),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.blue,
          ),
          onPressed: () {},
          child: Text("Bagikan"),
        ),
      ),
    ];
  }
}
