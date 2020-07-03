import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChannelFilterDialogScreen extends StatelessWidget {
  const ChannelFilterDialogScreen({
    @required this.isWhite,
  }) : assert(isWhite != null);

  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    final ChannelState channelStateStore = Provider.of<ChannelState>(context);
    if (channelStateStore?.currentChannel == null) {
      return Container();
    }

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(appTranslations.text('channel_filter_dialog_title')),
        previousPageTitle: appTranslations.text('common_back'),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            Set<String> list;

            if (isWhite) {
              list = channelStateStore.currentChannel.whiteListTyped;
            } else {
              list = channelStateStore.currentChannel.blackListTyped;
            }

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                // no data
                if (list.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        appTranslations.text('common_no_data'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),

                // items
                ...list.map((String filter) {
                  return SliverToBoxAdapter(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (isWhite) {
                              channelStateStore.currentChannel.removeWhiteListItem(filter);
                            } else {
                              channelStateStore.currentChannel.removeBlackListItem(filter);
                            }
                          },
                          child: Container(
                            color: MyColors.transparent,
                            padding: const EdgeInsets.only(right: 8.0),
                            child: const Icon(
                              CupertinoIcons.delete_simple,
                              color: MyColors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            color: MyColors.green.withOpacity(0.1),
                            child: Text(
                              filter,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()
              ],
            );
          },
        ),
      ),
    );
  }
}
