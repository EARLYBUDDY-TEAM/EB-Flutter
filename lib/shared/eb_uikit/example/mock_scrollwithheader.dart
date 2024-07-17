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
              item: (index) => _listItem(index),
              length: 100,
            ),
          ),
        ],
      ),
    );
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

  Card _listItem(int index) {
    return Card(
      color: EBColors.random,
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
