part of 'eb_uikit_example.dart';

class _MockScrollWithHeader extends StatelessWidget {
  const _MockScrollWithHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('_MockScrollWithHeader'),
      ),
      body: Column(
        children: [
          _fixEmptyView(),
          Expanded(
            child: ScrollWithHeader(
              header: _customHeader(),
              list: _list(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _list() {
    return [
      for (var i = 0; i < 100; i++) i % 2 == 0 ? _listItem(i) : _testListItem(i)
    ];
  }

  Expanded _customHeader() {
    return Expanded(
      child: Container(
        color: Colors.blue.shade200,
        width: double.infinity,
        height: 100,
        child: const Center(
          child: Text('This is Header'),
        ),
      ),
    );
  }

  Widget _listItem(int index) {
    return Card(
      color: EBColors.random,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text('Sample, Index : $index'),
      ),
    );
  }

  Widget _testListItem(int index) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text('Sample, Index : $index'),
      ),
    );
  }

  Container _fixEmptyView() {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      height: 100,
      child: const Center(
        child: Text('Fix Empty View'),
      ),
    );
  }
}

// class _MockCardListItemAB extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {// TODO: implement build
//     throw UnimplementedError();
//   }
// }
