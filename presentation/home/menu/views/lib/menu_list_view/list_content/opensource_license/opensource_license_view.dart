part of '../../../../eb_menu.dart';

final class OpenSourceLicenseView extends StatelessWidget {
  const OpenSourceLicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const _OpenSourceLicenseContent(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'OpenSource License',
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

final class _OpenSourceLicenseContent extends StatelessWidget {
  const _OpenSourceLicenseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemCount: dependencies.length,
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
      ),
    );
  }

  Widget? Function(BuildContext, int) get _itemBuilder {
    return (context, index) {
      return ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => _OpenSourceDescriptionView(
                package: dependencies[index],
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        title: Text(
          dependencies[index].name,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: FontFamily.nanumSquareBold,
          ),
        ),
      );
    };
  }

  Widget Function(BuildContext, int) get _separatorBuilder {
    return (context, index) {
      return const Divider(
        height: double.minPositive,
        color: Colors.grey,
        thickness: 0.5,
      );
    };
  }
}

final class _OpenSourceDescriptionView extends StatelessWidget {
  final Package package;
  final double fontSize = 20;

  const _OpenSourceDescriptionView({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: FontFamily.nanumSquareRegular,
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  const SizedBox(height: 5),
                  _version(),
                  const SizedBox(height: 20),
                  _description(),
                  _license(),
                  _link(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget _title() {
    return Text(
      package.name,
      style: TextStyle(
        fontSize: fontSize + 2,
        fontFamily: FontFamily.nanumSquareBold,
      ),
    );
  }

  Widget _version() {
    return Text(
      "version: ${package.version}",
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  Widget _description() {
    return Text(
      package.description,
    );
  }

  Widget _divider() {
    return const Divider(
      height: double.minPositive,
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _license() {
    final license = package.license;
    if (license == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        _divider(),
        const SizedBox(height: 20),
        Text(
          package.license ?? '',
          style: TextStyle(
            fontSize: fontSize - 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _link() {
    String? link;
    link = package.repository;
    link ??= package.homepage;

    if (link == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _divider(),
        const SizedBox(height: 20),
        Text(
          'Link',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          link,
          style: TextStyle(
            fontSize: fontSize - 2,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
