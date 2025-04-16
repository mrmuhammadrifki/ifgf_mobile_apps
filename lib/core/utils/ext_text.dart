import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';

extension TextExtension on Text {
  Text dm28sb() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w600),
  );

  Text dm24sb() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w600),
  );

  Text dm20b() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w700),
  );

  Text dm18b() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700),
  );

  Text dm18sm() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w600),
  );

  Text dm16sb() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
  );

  Text dm16m() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w500),
  );

  Text dm16r() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w400),
  );

  Text dm15r() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w400),
  );

  Text dm14sb() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
  );

  Text dm14m() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500),
  );

  Text dm14r() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400),
  );
  Text dm12r() => copyWith(
    style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w400),
  );

  Text maxLines1() => copyWith(maxLines: 1);

  Text overflowEllipsis() => copyWith(overflow: TextOverflow.ellipsis);

  Text lineHeight1() => copyWith(style: const TextStyle(height: 1.2));

  Text white() => copyWith(style: const TextStyle(color: BaseColor.white));
  Text black() => copyWith(style: const TextStyle(color: BaseColor.black));
  Text black2() => copyWith(style: const TextStyle(color: Color(0xff0D131B)));
  Text grey() => copyWith(style: TextStyle(color: BaseColor.grey.shade500));
  Text grey2() => copyWith(style: const TextStyle(color: BaseColor.grey2));
  Text softBlue() =>
      copyWith(style: const TextStyle(color: BaseColor.softBlue));
  Text orange() => copyWith(style: const TextStyle(color: BaseColor.orange));
  Text red() => copyWith(style: const TextStyle(color: BaseColor.danger));

  Text copyWith({
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection = TextDirection.ltr,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextStyle? style,
  }) {
    return Text(
      data ?? '',
      key: key ?? this.key,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      style: style != null ? this.style?.merge(style) ?? style : this.style,
    );
  }
}
