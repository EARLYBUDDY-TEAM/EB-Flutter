part of '../eb_resource.dart';

final class EBColors {
  static Color blue1 = const Color(0xff4DA6FF);
  static Color blue2 = const Color(0xff0783FF);
  static Color blue3 = const Color(0xff527AFF);
  static Color purple1 = const Color(0xff919DFD);
  static Color purple2 = const Color(0xff5C6EFF);
  static Color inactive = const Color(0xffA8A8A8);
  static Color text = const Color(0xff3C3C3C);

  static Color get random =>
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  static final subway = _Subway();
  static final bus = _Bus();
}

final class _Bus {
  Color ganson = HexColor('3469ec');
  Color jison = HexColor('33c63c');
  Color gwangyok = HexColor('ff574c');
  Color others = HexColor('85c900');
}

final class _Subway {
  Color line1 = HexColor('243899');
  Color line2 = HexColor('35b645');
  Color line3 = HexColor('f36e00');
  Color line4 = HexColor('219de2');
  Color line5 = HexColor('8828e2');
  Color line6 = HexColor('b75000');
  Color line7 = HexColor('697305');
  Color line8 = HexColor('e8146d');
  Color line9 = HexColor('d2a715');

  Color incheon1 = HexColor('6d98d2');
  Color incheon2 = HexColor('f7ac2e');
  Color gtx_a = HexColor('9A6292');
  Color gonghang = HexColor('70b5e6');
  Color jagibusang = HexColor('f08d41');
  Color gyongijungang = HexColor('7ac6a4');
  Color everline = HexColor('75c56e');
  Color gyongchun = HexColor('00b07a');
  Color sinbundang = HexColor('a71b2c');
  Color uijongbu = HexColor('ff9f00');
  Color gyonggang = HexColor('1e6ff7');
  Color uisinsol = HexColor('c7c300');
  Color sohae = HexColor('8ac832');
  Color gimpogold = HexColor('977300');
  Color suinbundang = HexColor('eeaa00');
  Color sillim = HexColor('6789CA');
}
