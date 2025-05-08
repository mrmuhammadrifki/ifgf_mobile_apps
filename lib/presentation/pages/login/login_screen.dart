import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/resources/data_state.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/message.dart';
import 'package:ifgf_apps/core/utils/modal.dart';
import 'package:ifgf_apps/data/provider/firebase_auth_provider.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static final _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: BaseColor.softBlue,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: BaseColor.softBlue,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: BaseColor.softBlue,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: BaseColor.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.0),
                    _buildTitle(),
                    SizedBox(height: 24.0),
                    _buildForm(),
                    SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onLogin,
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum punya akun? ').p14r().grey2(),
                        GestureDetector(
                          onTap: _onGoToRegister,
                          child: Text('Daftar').p14m().blue(),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onGoToRegister() {
    context.push(RoutePath.registerAuth);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            title: 'Email',
            hintText: 'Masukkan email-mu ya',
            prefixIcon: AssetsIcon.user,
            keyboardType: TextInputType.name,
            controller: emailController,
            validator: (value) {
              value = value ?? "";

              if (value.isEmptyWithTrim()) {
                return ErrorMessage.required;
              }

              if (!value.isValidEmail()) {
                return ErrorMessage.emailValid;
              }

              return null;
            },
          ),
          SizedBox(height: 20.0),
          CustomTextFormField(
            title: 'Password',
            hintText: 'Masukkan password-mu ya',
            prefixIcon: AssetsIcon.password,
            textInputAction: TextInputAction.done,
            isPassword: true,
            obscureText: true,
            controller: passwordController,
          ),
        ],
      ),
    );
  }

  void _onLogin() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final email = emailController.text;
    final password = passwordController.text;

    final firebaseAuthProvider = context.read<FirebaseAuthProvider>();

    Modal.showLoadingDialog(context, _keyLoader);

    final response = await firebaseAuthProvider.signIn(
      email: email,
      password: password,
    );

    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    if (!mounted) return;

    if (response is DataSuccess) {
      context.go(RoutePath.home);
      Modal.showSnackBar(
        context,
        text: "Berhasil masuk",
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

  Widget _buildTitle() {
    return Column(
      children: [
        SizedBox(
          width: 86,
          height: 86,
          child: Image.asset(
            AssetsImage.logo,
          ),
        ),
        SizedBox(height: 8),
        Text('Gereja').p18sm().black2(),
        Text('IFGF Purwokerto').p18sm().black2(),
        Text('Connecting People with God’s Purpuse').p14r().grey2(),
      ],
    );
  }
}
