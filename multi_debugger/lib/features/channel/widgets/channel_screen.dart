import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/features/actions_view/widgets/actions_view_screen.dart';
import 'package:multi_debugger/features/channel/components/channel_tab/channel_tab.dart';
import 'package:multi_debugger/features/channel/components/channel_tab_bar/channel_tab_bar.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({
    Key key,
  }) : super(key: key);

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
                ),
                const SizedBox(height: 1.0),

                // actions and data
                Expanded(
                  child: Row(
                    children: [
                      // actions
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: AppColors.gray3,
                              offset: Offset(1, 0),
                            )
                          ], color: AppColors.gray1),
                          child: const ActionsViewScreen(),
                        ),
                      ),
                      const SizedBox(width: 1.0),

                      // data
                      Expanded(
                        flex: 2,
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
