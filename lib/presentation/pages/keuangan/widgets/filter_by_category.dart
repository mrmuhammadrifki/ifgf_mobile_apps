import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

class FilterByCategory extends StatefulWidget {
  final List<String> list;
  final String? value;
  final ValueChanged<String>? onChanged;
  const FilterByCategory({
    super.key,
    required this.list,
    this.value,
    this.onChanged,
  });

  @override
  State<FilterByCategory> createState() => _FilterByCategoryState();
}

class _FilterByCategoryState extends State<FilterByCategory> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value != null && widget.list.contains(widget.value)
        ? widget.value ?? ""
        : widget.list.first;
  }

  @override
  void didUpdateWidget(covariant FilterByCategory oldWidget) {
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: BaseColor.white,
        border: Border.all(color: BaseColor.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: false,
          icon: SvgPicture.asset(AssetsIcon.arrowDown),
          style: const TextStyle(
            color: BaseColor.black2,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onChanged?.call(newValue);
            }
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value).p16r().black2(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
