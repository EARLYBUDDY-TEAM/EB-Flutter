part of '../../../eb_menu.dart';
// 얼리버디 사용에 대한 책임 및 한계
// 남녀노소 누구에게나 무료로 제공되는 얼리버디의 모든 정보는 '참고용'입니다.
// 다양한 데이터를 통해 보다 정확한 정보를 제공해드리기 위해 얼리버디는 항상 노력하고 있습니다. 하지만 교통상황 등의 요인에 의해 정보의 정확성, 신뢰성이 보증되지 않을 수 있습니다. 서비스 이용 결과에 대한 어떠한 법적 책임을 부담 하지는 않으니 얼리버디는 참고용으로만 사용해주세요! 보다 정확하고 편리한 기능 과 정보를 제공하기 위해 늘 발전하는 얼리버디게 될게요, 감사합니다!
// 지도 관련 법적 공지
// 대한측량협회 심사필 제 2008-072호 (2008.03.20)
// 1. 지도는 공간정보의 구축 및 관리 등에 관한 법률 제 14조, 제15조, 제16조, 제 19조, 제 20조, 제 21조에 의거하여 국토교통부장관의 사전승인 없이는 복제, 국외 반출 및 본 지도를 이용한 다른 지도의 간행을 금하고 있습니다.
// 2. 위 사항의 위반자는 공간정보의 구축 및 관리 등에 관한 법률 제108조, 제109조 에 의거 제 16조 및 제 21조 위반 시 2년 이하의 징역 또는 2천만 원 이하의 벌금, 제 14조, 제 15조, 제 19조 위반 시 1년 이하의 징역 또는 1천만 원 이하의 벌금에 각 처합니다.
// 지도는 복제하거나 국외반출을 철저히 금하고 있으니 유념하시기 바랍니다.
// 얼리버디는 카카오맵(Kakao Corp.)을 사용하고 있습니다.
// 정보 제공처 지도, Map data ©
// Kakao Corp., OpenStreetMap contributors
// 교통정보, Traffic Data ©
// 한국도로공사, 서울시 교통정보센터, 서울시교통정보과, 국토교통부, 경기도 교통정보센터, tbs 교통방송

const _legalNoticeText = '''
얼리버디 사용에 대한 책임 및 한계

남녀노소 누구에게나 무료로 제공되는 얼리버디의 모든 정보는 '참고용'입니다.

다양한 데이터를 통해 보다 정확한 정보를 제공해드리기 위해 얼리버디는 항상 노력하고 있습니다. 하지만 교통상황 등의 요인에 의해 정보의 정확성, 신뢰성이 보증되지 않을 수 있습니다. 서비스 이용 결과에 대한 어떠한 법적 책임을 부담 하지는 않으니 얼리버디는 참고용으로만 사용해주세요! 보다 정확하고 편리한 기능 과 정보를 제공하기 위해 늘 발전하는 얼리버디게 될게요, 감사합니다!

지도 관련 법적 공지
대한측량협회 심사필 제 2008-072호 (2008.03.20)

1. 지도는 공간정보의 구축 및 관리 등에 관한 법률 제 14조, 제15조, 제16조, 제 19조, 제 20조, 제 21조에 의거하여 국토교통부장관의 사전승인 없이는 복제, 국외 반출 및 본 지도를 이용한 다른 지도의 간행을 금하고 있습니다.

2. 위 사항의 위반자는 공간정보의 구축 및 관리 등에 관한 법률 제108조, 제109조 에 의거 제 16조 및 제 21조 위반 시 2년 이하의 징역 또는 2천만 원 이하의 벌금, 제 14조, 제 15조, 제 19조 위반 시 1년 이하의 징역 또는 1천만 원 이하의 벌금에 각 처합니다.
지도는 복제하거나 국외반출을 철저히 금하고 있으니 유념하시기 바랍니다.
얼리버디는 카카오맵(Kakao Corp.)을 사용하고 있습니다.

정보 제공처 지도, Map data ©
Kakao Corp., OpenStreetMap contributors

교통정보, Traffic Data ©
한국도로공사, 서울시 교통정보센터, 서울시교통정보과, 국토교통부, 경기도 교통정보센터, tbs 교통방송
''';

final class LegalNoticeView extends StatelessWidget {
  const LegalNoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _longText(
                    _legalNoticeText,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _longText(String text) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: FontFamily.nanumSquareLight,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        '법적 공지 및 정보제공처',
        style: TextStyle(
          fontSize: 22,
          fontFamily: FontFamily.nanumSquareBold,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
