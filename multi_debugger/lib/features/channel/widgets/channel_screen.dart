import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/di/app_di.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({
    Key key,
  }) : super(key: key);

  @override
  State createState() => _ChannelState();
}

class _ChannelState extends State<ChannelScreen> {
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
      body: Row(
        children: [
          // channels tab
          Container(
            width: 100,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray3,
                  offset: Offset(1, 0),
                ),
              ],
              color: AppColors.gray2,
            ),
          ),
          const SizedBox(width: 1.0),

          // channel content
          Expanded(
            child: Column(
              children: [
                // tab bar
                Container(
                  height: 120,
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

                // channel actions
                Container(
                  height: 80,
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
                            color: AppColors.primaryColorDark,
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
