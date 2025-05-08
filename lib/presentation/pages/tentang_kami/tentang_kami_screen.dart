import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/galeri.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';

class TentangKamiScreen extends StatelessWidget {
  const TentangKamiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String misiText = '''
Misi merupakan target – akhir apa yang diinginkan dan proses dimana akhir yang dicapai.

“Karena Allah begitu mengasihi dunia ini, sehingga Ia telah mengaruniakan AnakNya yang tunggal, supaya setiap orang yang percaya kepadaNya tidak binasa, melainkan beroleh hidup yang kekal.” – Yohanes 3:16 –

Mengapa kita ada di bumi? Kami percaya bahwa kami berada di kota Canberra ini untuk memenuhi tujuan Allah, Sang Pencipta. Sebagai ciptaan-Nya kita tidak dapat menentukan tujuan sendiri tetapi kita harus menanyakan kepada Sang Pencipta sendiri, dimana kami menemukan bahwa rencana-Nya hanya berpusat pada penciptaan akhir-Nya yaitu People atau Manusia. Dia ingin mengembalikan manusia ke dalam desain aslinya sebagaimana Dia menciptakan mereka ke dalam gambar-Nya sendiri. Dia ingin memberdayakan kita, ciptaan-Nya, untuk menjadi duta atau pewarta ke dunia untuk membawa mereka ke dalam rencana-Nya juga. Dengan demikian tujuan dari gereja bukan terutama bangunan, program atau organisasi, tapi MANUSIA.

Kami juga dipanggil untuk memenuhi Amanat Agung, tidak hanya untuk membiarkan orang tahu tentang Allah dan keselamatan kekal, tapi hati menyentuh, meningkatkan kehidupan, dan menciptakan kesempatan kedua. Kami berada di sini untuk orang-orang, sebagai hamba yang rendah hati dan nasihat yang bijaksana. Kami fokus pada orang-orang, menciptakan dampak dan mengubah mereka menjadi lebih baik. Oleh karena itu, misi Gereja IFGF dapat dipersingkat menjadi satu kalimat:

“PEOPLE IS OUR MISSION”
''';
    return Scaffold(
      appBar: CustomAppBar(titleText: "Tentang Kami", showBackIcon: true),
      body: Container(
        width: Helper.widthScreen(context),
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
          child: Column(
            children: [
              _buildHeroSection(context),
              Transform.translate(
                offset: Offset(0, -40),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  width: Helper.widthScreen(context),
                  decoration: BoxDecoration(
                    color: BaseColor.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AssetsIcon.pin),
                          SizedBox(width: 4),
                          Text("Misi Kami").p16m().black2(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Misi merupakan target – akhir apa yang diinginkan dan proses dimana  akhir yang dicapai.\n\n“Karena Allah begitu mengasihi dunia ini, sehingga Ia telah  mengaruniakan AnakNya yang tunggal, supaya setiap orang yang  percaya kepadaNya tidak binasa, melainkan beroleh hidup yang kekal.” – Yohanes 3:16 –",
                      ).p14r().black2(),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Modal.baseBottomSheet(context,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(AssetsIcon.pin),
                                            SizedBox(width: 4),
                                            Text("Misi Kami").p16m().black2(),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          misiText,
                                        ).p14r().black2(),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          child: Text("Lihat selengkapnya").p14r().blue(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  width: Helper.widthScreen(context),
                  decoration: BoxDecoration(
                    color: BaseColor.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AssetsIcon.target),
                          SizedBox(width: 4),
                          Text("Visi Kami").p16m().black2(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Setiap anggota jemaat dibangun dan ditumbuhkan melalui 10 visi  kerasulan dan dinamis sehingga mereka dapat menjadi rumah (House  of)")
                          .p14r()
                          .black2(),
                      SizedBox(height: 10),
                      Image.asset(AssetsImage.coreValues)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                width: Helper.widthScreen(context),
                decoration: BoxDecoration(
                  color: BaseColor.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Ikuti Sosial Media Kami").p16m().black2(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Helper.openLink(
                                "https://maps.app.goo.gl/EG96BoUJZLMi44vV6");
                          },
                          child: _buildSosmedIcon(
                              title: "Lokasi", icon: AssetsIcon.locationBlack),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Helper.openLink(
                              "https://www.tiktok.com/@ifgf.purwokerto?_t=ZS-8w1E6Ms1s8e&_r=1",
                            );
                          },
                          child: _buildSosmedIcon(
                              title: "Tiktok", icon: AssetsIcon.tiktok),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Helper.openLink(
                              "https://www.instagram.com/ifgf_purwokerto?igsh=azJkZmNqc2FkM2Vk",
                            );
                          },
                          child: _buildSosmedIcon(
                              title: "Instagram", icon: AssetsIcon.instagram),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Galeri Kami").p16m().black2(),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => _onGoToPhotoView(
                          image: AssetsImage.galeri2, context: context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          AssetsImage.galeri2,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: listImage.map((item) {
                        return InkWell(
                          onTap: () => _onGoToPhotoView(
                              image: item.image, context: context),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.image ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onGoToPhotoView({String? image, BuildContext? context}) {
    context?.push(RoutePath.photoView, extra: image);
  }

  Widget _buildSosmedIcon({String? title, String? icon}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BaseColor.white,
            border: Border.all(color: BaseColor.border),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon ?? "",
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(title ?? "").p14r().black2()
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: 250,
      width: Helper.widthScreen(context),
      child: Stack(
        children: [
          Image.asset(
            AssetsImage.galeri1,
            fit: BoxFit.cover,
            width: Helper.widthScreen(context),
            height: 250,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsImage.logoDark, width: 86.0),
                  SizedBox(height: 8),
                  Text(
                    'People is Our Mission',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ).p18b().white()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
