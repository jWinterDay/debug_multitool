// import 'package:flutter/cupertino.dart';
// import 'package:bp_template/tools/uikit.dart';

// typedef Future<void> TabChangedCallback(int index);

// class TabSwitcher extends StatefulWidget {
//   const TabSwitcher({
//     this.labels,
//     this.onTabChanged,
//     this.height,
//     this.initialIndex = 0,
//   })  : assert(labels != null),
//         assert(initialIndex != null),
//         assert(initialIndex >= 0 && initialIndex < labels.length);

//   final List<String> labels;
//   final TabChangedCallback onTabChanged;
//   final double height;
//   final int initialIndex;

//   @override
//   _TabSwitcherState createState() => _TabSwitcherState();
// }

// class _TabSwitcherState extends State<TabSwitcher>
//     with SingleTickerProviderStateMixin {
//   int _currentIndex;

//   @override
//   void initState() {
//     super.initState();

//     _currentIndex = widget.initialIndex;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final sectionWidth = size.width / widget.labels.length;

//     return Container(
//       child: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: List.generate(widget.labels.length, (index) {
//               return GestureDetector(
//                 onTap: () async {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                   await widget.onTabChanged(index);
//                 },
//                 child: Container(
//                   color: MyColors.white,
//                   width: sectionWidth,
//                   padding: const EdgeInsets.symmetric(horizontal: 2),
//                   child: Center(
//                     child: Text(
//                       widget.labels[index],
//                       style: TextStyle(
//                         color: _currentIndex == index
//                             ? MyColors.primary
//                             : MyColors.textPrimary,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             left: _currentIndex * sectionWidth,
//             bottom: 0,
//             child: Container(
//               color: MyColors.primary,
//               height: 2.0,
//               width: sectionWidth,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
