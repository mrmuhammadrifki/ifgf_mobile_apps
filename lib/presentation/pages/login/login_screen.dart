import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                        onPressed: () => _onGoToHome(),
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

  void _onGoToHome() {
    context.go(RoutePath.home);
  }

  void _onGoToRegister() {
    context.push(RoutePath.register);
  }

  Widget _buildForm() {
    return Column(
      children: [
        CustomTextFormField(
          title: 'Username',
          hintText: 'Masukkan username-mu ya',
          prefixIcon: AssetsIcon.user,
          keyboardType: TextInputType.name,
          controller: usernameController,
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
    );
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
