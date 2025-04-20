import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/core/utils/extension.dart';
import 'package:ifgf_apps/core/utils/message.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final String errorText;
  final Color? titleColor;
  final bool? isReadOnly;
  final String? prefixIcon;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? isPicker;
  final Function()? onTap;

  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.errorText = "",
    this.titleColor = BaseColor.black,
    this.isReadOnly = false,
    this.prefixIcon,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.isRequired = true,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.isPicker = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    obscureText = widget.obscureText;
  }

  void onTapSuffix() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(color: widget.titleColor)).p14r(),
        const SizedBox(height: 6),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          readOnly: widget.isReadOnly ?? false,
          onTap: widget.onTap,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: BaseColor.border),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: (widget.isReadOnly ?? false)
                    ? BaseColor.border
                    : BaseColor.softBlue,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: BaseColor.hint,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      widget.prefixIcon ?? "",
                    ),
                  )
                : null,
            suffixIcon: getSuffixIcon(),
            errorText: widget.errorText.isNotEmpty ? widget.errorText : null,
          ),
          enableSuggestions: !widget.isPassword,
          autocorrect: !widget.isPassword,
          obscureText: obscureText,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction,
          validator: widget.validator ??
              (value) {
                if (widget.isRequired && (value ?? "").isEmptyWithTrim()) {
                  return ErrorMessage.required;
                }

                return null;
              },
        ),
      ],
    );
  }

  Widget? getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: BaseColor.black,
        ),
        onPressed: onTapSuffix,
      );
    } else if (widget.isPicker == true) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(AssetsIcon.arrowDown),
      );
    }
    return null;
  }
}
