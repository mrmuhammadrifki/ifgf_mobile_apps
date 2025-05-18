import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/helper.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/models/file_upload_response.dart';
import 'package:ifgf_apps/data/models/image_response.dart';
import 'package:ifgf_apps/data/models/petugas.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_super_sunday/create_jadwal_super_sunday_provider/create_jadwal_super_sunday_provider.dart';
import 'package:ifgf_apps/presentation/widgets/cached_image.dart';
import 'package:ifgf_apps/presentation/widgets/custom_app_bar.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateJadwalSuperSunday extends StatefulWidget {
  final bool? isEdit;
  final String? id;
  const CreateJadwalSuperSunday({super.key, this.isEdit = false, this.id});

  @override
  State<CreateJadwalSuperSunday> createState() =>
      _CreateJadwalSuperSundayState();
}

class _CreateJadwalSuperSundayState extends State<CreateJadwalSuperSunday> {
  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController preacherController = TextEditingController();
  final TextEditingController worshipLeaderController = TextEditingController();
  final TextEditingController singerController = TextEditingController();
  final TextEditingController keyboardController = TextEditingController();
  final TextEditingController basController = TextEditingController();
  final TextEditingController gitarController = TextEditingController();
  final TextEditingController drumController = TextEditingController();
  final TextEditingController multimediaController = TextEditingController();
  final TextEditingController dokumentasiController = TextEditingController();
  final TextEditingController lcdOperatorController = TextEditingController();
  final TextEditingController lightingController = TextEditingController();

  final List<DateTime?> _dates = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty == true && widget.isEdit == true) {
        _onGetOneJadwal(id: widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.isEdit ?? false
            ? "Edit Super Sunday"
            : "Tambah Super Sunday",
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
            child: Column(
              children: [
                _buildForm(context),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onCreateJadwal,
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            title: "Tanggal",
            hintText: "Pilih tanggal ya",
            prefixIcon: AssetsIcon.calendar,
            isReadOnly: true,
            isPicker: true,
            onTap: () async {
              await Helper.showDateTimePickerHelper(
                context: context,
                initialDate: DateTime.now(),
                onDateTimeSelected: (selectedDateTime) {
                  _dates
                    ..clear()
                    ..add(selectedDateTime);
                  dateController.text =
                      _dates.first?.toString().formattedDateTime ?? '';
                  log('Selected date: ${dateController.text}');
                },
              );
            },
            controller: dateController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Tempat",
            hintText: "Masukkan tempat jadwal ya",
            prefixIcon: AssetsIcon.locationBlack,
            controller: locationController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Preacher",
            hintText: "Masukkan petugas preacher ya",
            prefixIcon: AssetsIcon.user,
            controller: preacherController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Worship Leader",
            hintText: "Masukkan petugas worship leader ya",
            prefixIcon: AssetsIcon.user,
            controller: worshipLeaderController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Singer",
            hintText: "Masukkan petugas singer ya",
            prefixIcon: AssetsIcon.user,
            controller: singerController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Keyboard",
            hintText: "Masukkan petugas keyboard ya",
            prefixIcon: AssetsIcon.user,
            controller: keyboardController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Bass",
            hintText: "Masukkan petugas bass ya",
            prefixIcon: AssetsIcon.user,
            controller: basController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Gitar",
            hintText: "Masukkan petugas gitar ya",
            prefixIcon: AssetsIcon.user,
            controller: gitarController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Drum",
            hintText: "Masukkan petugas drum ya",
            prefixIcon: AssetsIcon.user,
            controller: drumController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Multimedia",
            hintText: "Masukkan petugas multimedia ya",
            prefixIcon: AssetsIcon.user,
            controller: multimediaController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Dokumentasi",
            hintText: "Masukkan petugas dokumentasi ya",
            prefixIcon: AssetsIcon.user,
            controller: dokumentasiController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "LCD Operator",
            hintText: "Masukkan petugas LCD Operator ya",
            prefixIcon: AssetsIcon.user,
            controller: lcdOperatorController,
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            title: "Lighting",
            hintText: "Masukkan petugas lighting ya",
            prefixIcon: AssetsIcon.user,
            controller: lightingController,
          ),
          SizedBox(height: 20),
          Consumer<CreateJadwalSuperSundayProvider>(
            builder: (context, provider, child) {
              if (provider.imageSelected.length == 1) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.imageSelected.length,
                  itemBuilder: (context, index) {
                    final item = provider.imageSelected[index];
                    if (item?.url?.isNotEmpty == true) {
                      return _buildImagePreviewCard(
                        item,
                        provider,
                        index,
                      );
                    }
                    return SizedBox();
                  },
                );
              } else if (provider.imageSelected.length > 1) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: provider.imageSelected.length,
                  itemBuilder: (context, index) {
                    final item = provider.imageSelected[index];
                    if (item?.url?.isNotEmpty == true) {
                      return _buildImagePreviewCard(
                        item,
                        provider,
                        index,
                      );
                    }
                    return SizedBox();
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          Text("Upload Foto").p14r().black2(),
          SizedBox(height: 4),
          Row(
            children: [
              _imagePickerDialog(),
              SizedBox(width: 8),
              _imagePickerDialog(isPoster: true),
            ],
          ),
          SizedBox(height: 16),
          Text("Note:\nGunakan pemisah koma jika petugas lebih dari satu orang.")
              .p14r()
              .black2(),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  void _onCreateJadwal() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final createJadwalSuperSundayProvider =
        context.read<CreateJadwalSuperSundayProvider>();

    final dateTime = _dates.first;
    final location = locationController.text;
    final preacher = preacherController.text;
    final worshipLeader = worshipLeaderController.text;
    final singer = singerController.text;
    final keyboard = keyboardController.text;
    final bas = basController.text;
    final gitar = gitarController.text;
    final drum = drumController.text;
    final multimedia = multimediaController.text;
    final dokumentasi = dokumentasiController.text;
    final lcdOperator = lcdOperatorController.text;
    final lighting = lightingController.text;
    final thumbnail = createJadwalSuperSundayProvider.getThumbnail();
    final poster = createJadwalSuperSundayProvider.getPoster();

    if (thumbnail == null) {
      Modal.showSnackBar(
        context,
        text:
            "Thumbnail belum dipilih. Silakan pilih thumbnail terlebih dahulu.",
        snackbarType: SnackbarType.warning,
      );
      return;
    }

    Modal.showLoadingDialog(context, _keyLoader);

    if (widget.isEdit ?? false) {
      final response = await createJadwalSuperSundayProvider.updateJadwal(
        id: widget.id ?? "",
        dateTime: dateTime?.toIso8601String(),
        location: location,
        petugas: Petugas(
          preacher: preacher,
          worshipLeader: worshipLeader,
          singer: singer,
          keyboard: keyboard,
          bas: bas,
          gitar: gitar,
          drum: drum,
          multimedia: multimedia,
          dokumentasi: dokumentasi,
          lcdOperator: lcdOperator,
          lighting: lighting,
        ),
        thumbnail: ImageResponse(
          url: thumbnail.url ?? "",
          filePath: thumbnail.path ?? "",
        ),
        poster: poster != null
            ? ImageResponse(
                url: poster.url ?? "",
                filePath: poster.path ?? "",
              )
            : ImageResponse(
                url: "",
                filePath: "",
              ),
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        debugPrint("SUKSES EDIT, MAU POP TRUE");
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil mengedit jadwal",
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
      final response = await createJadwalSuperSundayProvider.createJadwal(
        dateTime: dateTime?.toIso8601String(),
        location: location,
        petugas: Petugas(
          preacher: preacher,
          worshipLeader: worshipLeader,
          singer: singer,
          keyboard: keyboard,
          bas: bas,
          gitar: gitar,
          drum: drum,
          multimedia: multimedia,
          dokumentasi: dokumentasi,
          lcdOperator: lcdOperator,
          lighting: lighting,
        ),
        thumbnail: ImageResponse(
          url: thumbnail.url ?? "",
          filePath: thumbnail.path ?? "",
        ),
        poster: poster != null
            ? ImageResponse(
                url: poster.url ?? "",
                filePath: poster.path ?? "",
              )
            : ImageResponse(
                url: "",
                filePath: "",
              ),
      );

      if (!mounted) return;

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (response is DataSuccess) {
        Navigator.pop(context, true);
        Modal.showSnackBar(
          context,
          text: "Berhasil menambahkan jadwal",
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

  Padding _buildImagePreviewCard(FileUploadResponse? item,
      CreateJadwalSuperSundayProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
        right: 20,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedImage(
              url: item?.url ?? "",
              height: 350,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: -15,
            right: -10,
            child: GestureDetector(
              onTap: () {
                provider.removeImage(index);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: BaseColor.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: BaseColor.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _imagePickerDialog({bool isPoster = false}) {
    final provider = context.read<CreateJadwalSuperSundayProvider>();
    return Expanded(
      child: InkWell(
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
                          imageType: isPoster
                              ? ImageType.posters
                              : ImageType.thumbnails);
                    },
                    child: _buildImageSource(title: "Ambil dari kamera"),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      context.pop();
                      provider.selectImage(
                          index: 1,
                          imageType: isPoster
                              ? ImageType.posters
                              : ImageType.thumbnails);
                    },
                    child: _buildImageSource(title: "Ambil dari galeri"),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
        child: _buildCustomButton(title: isPoster ? "Poster" : "Thumbnail"),
      ),
    );
  }

  void _onGetOneJadwal({String? id}) async {
    final createJadwalProvider =
        context.read<CreateJadwalSuperSundayProvider>();

    final response = await createJadwalProvider.getOneAcara(id: id);

    if (!mounted) return;

    if (response is DataSuccess) {
      preacherController.text = response.data?.petugas?.preacher ?? "";
      worshipLeaderController.text =
          response.data?.petugas?.worshipLeader ?? "";
      singerController.text = response.data?.petugas?.singer ?? "";
      keyboardController.text = response.data?.petugas?.keyboard ?? "";
      basController.text = response.data?.petugas?.bas ?? "";
      gitarController.text = response.data?.petugas?.gitar ?? "";
      drumController.text = response.data?.petugas?.drum ?? "";
      multimediaController.text = response.data?.petugas?.multimedia ?? "";
      dokumentasiController.text = response.data?.petugas?.dokumentasi ?? "";
      lcdOperatorController.text = response.data?.petugas?.lcdOperator ?? "";
      lightingController.text = response.data?.petugas?.lighting ?? "";
      dateController.text = response.data?.dateTime?.formattedDateTime ?? "";
      _dates.add(DateTime.parse(response.data?.dateTime ?? ""));
      locationController.text = response.data?.location ?? "";
      final thumbnailList = response.data?.thumbnail;
      if (thumbnailList != null && thumbnailList.isNotEmpty) {
        final thumb = thumbnailList.first;
        if (thumb?.url.isNotEmpty == true) {
          createJadwalProvider.addImage(
            FileUploadResponse(
              url: thumb?.url,
              path: thumb?.filePath,
              imageType: ImageType.thumbnails,
            ),
          );
        }
      }

      final posterList = response.data?.poster;
      if (posterList != null && posterList.isNotEmpty) {
        final poster = posterList.first;
        if (poster?.url.isNotEmpty == true) {
          createJadwalProvider.addImage(
            FileUploadResponse(
              url: poster?.url,
              path: poster?.filePath,
              imageType: ImageType.posters,
            ),
          );
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

  Widget _buildCustomButton({required String title}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsIcon.camera),
          SizedBox(width: 3),
          Text(title).p16r().black2(),
        ],
      ),
    );
  }
}
