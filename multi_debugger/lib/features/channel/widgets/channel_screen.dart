import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/features/actions_view/widgets/actions_view_screen.dart';
import 'package:multi_debugger/features/channel/blocs/channel_bloc.dart';
import 'package:multi_debugger/features/channel/components/channel_actions_widget/channel_actions_widget.dart';
import 'package:multi_debugger/features/channel/components/channel_tab/channel_tab.dart';
import 'package:multi_debugger/features/channel/components/channel_tab_bar/channel_tab_bar.dart';
import 'package:multi_debugger/features/payload_view/widgets/payload_view_screen.dart';

const int _initialFlex = 40;

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({
    Key key,
  }) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  ChannelBloc _bloc;

  final int _flex = _initialFlex;
  // int _prevFlex;
  // double _widthFlex = 0;

  @override
  void initState() {
    super.initState();

    _bloc = ChannelBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

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
                      Expanded(
                        flex: _flex,
                        child: const ActionsViewScreen(),
                      ),

                      const SizedBox(width: 1.0),

                      // splitter
                      // GestureDetector(
                      //   onHorizontalDragStart: (DragStartDetails details) {
                      //     _flex = _prevFlex ?? _initialFlex;
                      //     _widthFlex = 0.0;
                      //   },
                      //   onHorizontalDragUpdate: (DragUpdateDetails details) {
                      //     final double x = details.primaryDelta;
                      //     final RenderBox container = context.findRenderObject() as RenderBox;

                      //     _widthFlex += x;

                      //     if (_widthFlex.abs() > 10.0) {
                      //       final next = _flex + (_widthFlex.sign.toInt());
                      //       setState(() {
                      //         _flex = _flex + _widthFlex.sign.toInt();
                      //       });
                      //       _widthFlex = 0;
                      //     }
                      //   },
                      //   child: Container(
                      //     width: 30,
                      //     color: AppColors.gray6,
                      //   ),
                      // ),

                      // data
                      Expanded(
                        flex: 50,
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
