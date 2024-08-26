part of '../../../entity.dart';

final class Subway extends Equatable {
  final String type;

  const Subway({
    required this.type,
  });

  Color color() {
    switch (type) {
      case '1호선':
        return EBColors.subway.line1;
      case '2호선':
        return EBColors.subway.line2;
      case '3호선':
        return EBColors.subway.line3;
      case '4호선':
        return EBColors.subway.line4;
      case '5호선':
        return EBColors.subway.line5;
      case '6호선':
        return EBColors.subway.line6;
      case '7호선':
        return EBColors.subway.line7;
      case '8호선':
        return EBColors.subway.line8;
      case '9호선':
        return EBColors.subway.line9;
      case '인천1호선':
        return EBColors.subway.incheon1;
      case '인천2호선':
        return EBColors.subway.incheon2;
      case 'GTX-A':
        return EBColors.subway.gtx_a;
      case '공항철도':
        return EBColors.subway.gonghang;
      case '자기부상철도':
        return EBColors.subway.jagibusang;
      case '경의중앙선':
        return EBColors.subway.gyongijungang;
      case '에버라인':
        return EBColors.subway.everline;
      case '경춘선':
        return EBColors.subway.gyongchun;
      case '신분당선':
        return EBColors.subway.sinbundang;
      case '의정부경전철':
        return EBColors.subway.uijongbu;
      case '경강선':
        return EBColors.subway.gyonggang;
      case '우이신설선':
        return EBColors.subway.uisinsol;
      case '서해선':
        return EBColors.subway.sohae;
      case '김포골드라인':
        return EBColors.subway.gimpogold;
      case '수인분당선':
        return EBColors.subway.suinbundang;
      case '신림선':
        return EBColors.subway.sillim;
      default:
        return EBColors.subway.line1;
    }
  }

  @override
  List<Object?> get props => [type];

  static Subway mock() {
    return const Subway(type: '1호선');
  }
}
