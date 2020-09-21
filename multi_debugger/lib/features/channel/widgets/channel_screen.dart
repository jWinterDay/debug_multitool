import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/features/actions_view/widgets/actions_view_screen.dart';
import 'package:multi_debugger/features/channel/components/channel_actions_widget/channel_actions_widget.dart';
import 'package:multi_debugger/features/channel/components/channel_tab/channel_tab.dart';
import 'package:multi_debugger/features/channel/components/channel_tab_bar/channel_tab_bar.dart';
import 'package:multi_debugger/features/payload_view/widgets/payload_view_screen.dart';

const double _kActionsInitialWidth = 400.0;

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({
    Key key,
  }) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final double _actionWidth = _kActionsInitialWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // channels tab
          Container(
            width: 100.0,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray3,
                  offset: Offset(1, 0),
                ),
              ],
              color: AppColors.gray2,
            ),
            child: const ChannelTab(),
          ),
          const SizedBox(width: 1.0),

          // channel content
          Expanded(
            child: Column(
              children: [
                // tab bar
                Container(
                  height: 120.0,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray3,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: AppColors.gray1,
                  ),
                  child: const ChannelTabBar(),
                ),
                const SizedBox(height: 1.0),

                // channel actions
                Container(
                  height: 80.0,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray3,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: AppColors.gray1,
                  ),
                  child: const ChannelActionsWidget(),
                ),
                const SizedBox(height: 1.0),

                // actions and data
                Expanded(
                  child: Row(
                    children: [
                      // actions
                      Container(
                        width: _actionWidth,
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: AppColors.gray3,
                            offset: Offset(1, 0),
                          )
                        ], color: AppColors.gray1),
                        child: const ActionsViewScreen(),
                      ),

                      const SizedBox(width: 1.0),

                      // splitter
                      // GestureDetector(
                      //   onHorizontalDragUpdate: (DragUpdateDetails details) {
                      //     // final Size size = MediaQuery.of(context).size;
                      //     // print('w = ${size.width}');
                      //     // final double x = details.primaryDelta;
                      //     // final RenderBox container = context.findRenderObject() as RenderBox;
                      //     // final Offset pos = container.globalToLocal(details.globalPosition);

                      //     // double nextWidth = _actionWidth + x;

                      //     // if (nextWidth > 100 && nextWidth < container.size.width - 200) {
                      //     //   print('container = ${container.size.width} nextWidth = $nextWidth');
                      //     //   setState(() {
                      //     //     _actionWidth = _actionWidth + x;
                      //     //   });
                      //     // }
                      //   },
                      //   child: Container(
                      //     width: 30,
                      //     color: AppColors.gray6,
                      //   ),
                      // ),
                      // const RowSplitter(),

                      // data
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gray3,
                                offset: Offset(1, 0),
                              )
                            ],
                            color: AppColors.background,
                          ),
                          child: const PayloadViewScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
