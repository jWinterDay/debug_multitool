// import 'package:bp_template/app_translations.dart';
// import 'package:bp_template/base/base_model.dart';
// import 'package:bp_template/structure/components/popup_loader.dart';
// import 'package:flutter/cupertino.dart';

// class MySliverListInfo extends StatelessWidget {
//   MySliverListInfo({
//     this.state,
//     this.isEmpty,
//     this.child,
//   })  : assert(isEmpty != null),
//         assert(child != null),
//         assert(child is SliverList);

//   final BaseModel state;
//   final bool isEmpty;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     if (state == null || state.isLoading) {
//       return SliverFillRemaining(
//         child: PopupLoader(),
//       );
//     }

//     if (state.error != null) {
//       return SliverFillRemaining(
//         child: Center(
//           child: Text(
//             state.error.toString(),
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//     }

//     if (isEmpty) {
//       return SliverFillRemaining(
//         child: Center(
//           child: Text(
//             appTranslations.text('common_no_data'),
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//     }

//     return child;
//   }
// }
