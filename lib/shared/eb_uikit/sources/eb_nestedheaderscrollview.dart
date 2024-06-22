import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NestedHeaderScrollView extends StatefulWidget {
  StatelessWidget header;
  StatelessWidget content;

  NestedHeaderScrollView({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => _NestedHeaderScrollState(
        header: header,
        content: content,
      );
}

class _NestedHeaderScrollState extends State<NestedHeaderScrollView>
    with SingleTickerProviderStateMixin {
  StatelessWidget header;
  StatelessWidget content;

  _NestedHeaderScrollState({
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.grey.shade100,
            title: header,
            centerTitle: true,
          )
          // SliverAppBar(
          //   // backgroundColor: Colors.grey.shade100,
          //   title: header,
          //   centerTitle: true,

          //   // collapsedHeight: 70,
          //   // expandedHeight: 70,

          //   // pinned: false,
          //   // floating: false,
          // ),
        ];
      },
      body: content,
    );
  }
}
