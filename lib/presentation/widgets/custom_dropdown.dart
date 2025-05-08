import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> list;
  final String title;
  final String? value;
  final ValueChanged<String>? onChanged;

  const CustomDropdown({
    super.key,
    required this.list,
    required this.title,
    this.value,
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value != null && widget.list.contains(widget.value)
        ? widget.value ?? ""
        : widget.list.first;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != null &&
        widget.value != oldWidget.value &&
        widget.list.contains(widget.value)) {
      setState(() {
        selectedValue = widget.value!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title).p14r(),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: BaseColor.white,
            border: Border.all(color: BaseColor.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AssetsIcon.category),
              const SizedBox(width: 3),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    isExpanded: true,
                    icon: SvgPicture.asset(AssetsIcon.arrowDown),
                    style: const TextStyle(
                      color: BaseColor.black2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (String? newValue) {
                      if (provider.profile?.isAdmin ?? false) {
                        if (newValue != null) {
                          setState(() {
                            selectedValue = newValue;
                          });
                          widget.onChanged?.call(newValue);
                        }
                      }
                    },
                    items: widget.list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value).p16r().black2(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
