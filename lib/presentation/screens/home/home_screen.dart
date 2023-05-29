import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          context.brightness == Brightness.light
              ? 'assets/images/enkora_logo.png'
              : 'assets/images/enkora_logo_dark.png',
          scale: 5.0,
          alignment: Alignment.bottomLeft,
        ),
        titleSpacing: 0,
        bottom: const PreferredSize(child: SizedBox.shrink(), preferredSize: Size.fromHeight(8.0)),
      ),
      body: _ContentBox(),
    );
  }
}

class _ContentBox extends StatelessWidget {
  const _ContentBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _boxHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16.0),
          _SettingsTile(
            title: 'Read tag'.tt(context),
            subtitle: 'Shows the access rights of the tag'.tt(context),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.readTag),
          ),
        ],
        //   );
        // },
      ),
    );
  }

  double _boxHeight(BuildContext context) => 100.h - kToolbarHeight - MediaQuery.of(context).padding.top;
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? subtitleError;
  final bool errorBadge;
  final Function onTap;
  final bool hideTrailing;
  final bool loadingTitle;
  final bool loadingSubtitle;
  final Widget? trailing;

  const _SettingsTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.hideTrailing = false,
    this.errorBadge = false,
    this.subtitleError,
    this.loadingTitle = false,
    this.loadingSubtitle = false,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? _listTitleStyle = context.bodyLarge?.copyWith(fontWeight: FontWeight.w600);
    final TextStyle? _listSubtitleStyle = context.bodyMedium?.copyWith(
      color: context.subtitleColor,
      fontWeight: FontWeight.w400,
    );

    final subtitleErrorCheck =
        subtitleError != null ? Text(subtitleError!, style: _listSubtitleStyle?.copyWith(color: AppColor.error)) : null;
    final subtitleFinal = subtitle != null ? Text(subtitle!, style: _listSubtitleStyle) : subtitleErrorCheck;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      child: Column(
        children: [
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: context.theme.cellBackgroundColor,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () => onTap(),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  title: Text(title, style: _listTitleStyle),
                  subtitle: subtitleFinal,
                  trailing: hideTrailing
                      ? trailing
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (errorBadge) ...[
                              Icon(
                                Icons.error,
                                color: context.theme.fullBadgeColor,
                              ),
                            ],
                            Icon(
                              Icons.navigate_next_rounded,
                              color: context.primaryColor,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadlineWidget extends StatelessWidget {
  const _HeadlineWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextStyle? _headlineStyle =
        context.bodySmall?.copyWith(color: context.subtitleColor, fontWeight: FontWeight.w600);

    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text.toUpperCase().tt(context), style: _headlineStyle).paddingSymmetric(horizontal: 16.0),
        ],
      ).paddingOnly(bottom: 8.0, top: 8.0),
    );
  }
}

// class LabelSkeleton extends StatelessWidget {
//   final double? width;
//
//   const LabelSkeleton({Key? key, required this.width}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: context.brightness == Brightness.dark ? const Color(0xff28343d) : const Color(0xffe5e5e5),
//       highlightColor: const Color(0x15e5e5e5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Skeleton(width: width),
//         ],
//       ),
//     );
//   }
// }
