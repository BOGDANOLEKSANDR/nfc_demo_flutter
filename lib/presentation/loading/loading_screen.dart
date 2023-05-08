// import 'package:nfc_demo/common_libs.dart';
// import 'package:nfc_demo/presentation/widgets/loader.dart';
//
// class LoadingScreen extends StatelessWidget {
//   final Widget child;
//
//   const LoadingScreen({Key? key, required this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoadingCubit, LoadingState>(
//       listener: (context, state) {
//         if (state.isUnlockComplete) {
//           context.read<LoadingCubit>().hideWithDelay(const Duration(milliseconds: 2000));
//         }
//       },
//       builder: (context, state) {
//         return Stack(
//           fit: StackFit.expand,
//           children: [
//             WillPopScope(
//               onWillPop: () => Future.value(!state.isInitial),
//               child: child,
//             ),
//             if (state.isVisible)
//               Container(
//                 decoration: BoxDecoration(color: context.theme.overlayBackgroundColor),
//                 child: Center(
//                   child: Loader(
//                     icon: Image.asset(
//                       'assets/images/logo.png',
//                       scale: 6.0,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                 ),
//               ),
//             if (state.isUnlock)
//               Container(
//                 decoration: BoxDecoration(color: context.theme.overlayBackgroundColor),
//                 child: const Center(
//                   child: _LoadingWidget(),
//                 ),
//               ),
//             if (state.isUnlockComplete)
//               Container(
//                 decoration: BoxDecoration(color: context.theme.overlayBackgroundColor),
//                 child: const Center(
//                   child: _LoadingCompleteWidget(),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _LoadingCompleteWidget extends StatelessWidget {
//   const _LoadingCompleteWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               height: 70.0,
//               width: 70.0,
//               child: CustomPaint(
//                 painter: LoaderCanvas(
//                     radius: 1,
//                     degree: 360,
//                     backgroundColor: context.scaffoldBackgroundColor,
//                     foregroundColor: AppColor.greenBackground),
//               ),
//             ),
//             Icon(Icons.lock_open_rounded, color: AppColor.greenBackground, size: 38),
//           ],
//         ),
//         Text('Done'.tt(context), style: context.titleLarge).paddingOnly(top: 24.0),
//       ],
//     );
//   }
// }
//
// class _LoadingWidget extends StatelessWidget {
//   const _LoadingWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Loader(
//           icon: Icon(Icons.lock, color: context.secondaryColor, size: 38),
//           backgroundColor: context.scaffoldBackgroundColor,
//         ),
//         Text('Unlocking...'.tt(context), style: context.titleLarge).paddingOnly(top: 24.0),
//       ],
//     );
//   }
// }
