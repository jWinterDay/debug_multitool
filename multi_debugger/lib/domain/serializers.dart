// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/serializer.dart';
// import 'package:built_value/standard_json_plugin.dart';
// import 'package:ligastavok/domain/models/analytics/analytic_bet.dart';
// import 'package:ligastavok/domain/models/analytics/analytic_deposit_model.dart';
// import 'package:ligastavok/domain/models/analytics/analytic_stream_model.dart';
// import 'package:ligastavok/domain/models/app_route.dart';
// import 'package:ligastavok/domain/models/balance.dart';
// import 'package:ligastavok/domain/models/balance_item_next.dart';
// import 'package:ligastavok/domain/models/balance_model.dart';
// import 'package:ligastavok/domain/models/bet/bet.dart';
// import 'package:ligastavok/domain/models/bet/bet_block.dart';
// import 'package:ligastavok/domain/models/bet/bet_event.dart';
// import 'package:ligastavok/domain/models/bet/bet_game_next.dart';
// import 'package:ligastavok/domain/models/bet/bet_market.dart';
// import 'package:ligastavok/domain/models/bet/bet_outcome.dart';
// import 'package:ligastavok/domain/models/bet/bet_outcome_id_factor_id.dart';
// import 'package:ligastavok/domain/models/bet/bet_result_enum_status.dart';
// import 'package:ligastavok/domain/models/bet/bet_sport.dart';
// import 'package:ligastavok/domain/models/bet/bet_state_filter_type.dart';
// import 'package:ligastavok/domain/models/bet/bet_system.dart';
// import 'package:ligastavok/domain/models/bet/bet_type.dart';
// import 'package:ligastavok/domain/models/bet/bet_value_change_type.dart';
// import 'package:ligastavok/domain/models/bind_account_model.dart';
// import 'package:ligastavok/domain/models/bookmaker_single_bet.dart';
// import 'package:ligastavok/domain/models/cart/cart_delete_outcome_settings.dart';
// import 'package:ligastavok/domain/models/cart/cart_settings.dart';
// import 'package:ligastavok/domain/models/cart_type.dart';
// import 'package:ligastavok/domain/models/common/bool_result_model.dart';
// import 'package:ligastavok/domain/models/common/error_model.dart';
// import 'package:ligastavok/domain/models/common/meta.dart';
// import 'package:ligastavok/domain/models/common/sort_direction.dart';
// import 'package:ligastavok/domain/models/config/contact_config.dart';
// import 'package:ligastavok/domain/models/config/features_config.dart';
// import 'package:ligastavok/domain/models/config/local_settings.dart';
// import 'package:ligastavok/domain/models/config/index.dart';
// import 'package:ligastavok/domain/models/confirm_email_model.dart';
// import 'package:ligastavok/domain/models/confirm_phone_model.dart';
// import 'package:ligastavok/domain/models/counters.dart';
// import 'package:ligastavok/domain/models/counters_model.dart';
// import 'package:ligastavok/domain/models/currency.dart';
// import 'package:ligastavok/domain/models/currency/currency_type.dart';
// import 'package:ligastavok/domain/models/currency_next.dart';
// import 'package:ligastavok/domain/models/deposit_request.dart';
// import 'package:ligastavok/domain/models/dialog_bundle.dart';
// import 'package:ligastavok/domain/models/diff_collection_model.dart';
// import 'package:ligastavok/domain/models/diff_message_model.dart';
// import 'package:ligastavok/domain/models/error_model_next.dart';
// import 'package:ligastavok/domain/models/event/block.dart';
// import 'package:ligastavok/domain/models/event/block_brief.dart';
// import 'package:ligastavok/domain/models/event/category_market_next.dart';
// import 'package:ligastavok/domain/models/event/event.dart';
// import 'package:ligastavok/domain/models/event/event_action_model.dart';
// import 'package:ligastavok/domain/models/event/event_group_description_segment.dart';
// import 'package:ligastavok/domain/models/event/event_priority.dart';
// import 'package:ligastavok/domain/models/event/event_team.dart';
// import 'package:ligastavok/domain/models/event/game_competitor_next.dart';
// import 'package:ligastavok/domain/models/event/game_current_period_next.dart';
// import 'package:ligastavok/domain/models/event/game_item_next.dart';
// import 'package:ligastavok/domain/models/event/games_response_next.dart';
// import 'package:ligastavok/domain/models/event/live_status_next.dart';
// import 'package:ligastavok/domain/models/event/main_market.dart';
// import 'package:ligastavok/domain/models/event/market.dart';
// import 'package:ligastavok/domain/models/event/market_config.dart';
// import 'package:ligastavok/domain/models/event/market_config_item.dart';
// import 'package:ligastavok/domain/models/event/market_filter.dart';
// import 'package:ligastavok/domain/models/event/market_next.dart';
// import 'package:ligastavok/domain/models/event/odds_next.dart';
// import 'package:ligastavok/domain/models/event/outcome.dart';
// import 'package:ligastavok/domain/models/event/period_score.dart';
// import 'package:ligastavok/domain/models/event_counters_map.dart';
// import 'package:ligastavok/domain/models/event_details/event_details_filter_type.dart';
// import 'package:ligastavok/domain/models/event_details/event_details_sort_type.dart';
// import 'package:ligastavok/domain/models/event_market_category.dart';
// import 'package:ligastavok/domain/models/events_request.dart';
// import 'package:ligastavok/domain/models/game_live_status_next.dart';
// import 'package:ligastavok/domain/models/get_device_id_deprecated.dart';
// import 'package:ligastavok/domain/models/get_token_deprecated.dart';
// import 'package:ligastavok/domain/models/life_cycle.dart';
// import 'package:ligastavok/domain/models/line_calendar_filter.dart';
// import 'package:ligastavok/domain/models/line_min_number.dart';
// import 'package:ligastavok/domain/models/make_bet_model.dart';
// import 'package:ligastavok/domain/models/namespace.dart';
// import 'package:ligastavok/domain/models/odd_next.dart';
// import 'package:ligastavok/domain/models/order.dart';
// import 'package:ligastavok/domain/models/order_amount.dart';
// import 'package:ligastavok/domain/models/orders.dart';
// import 'package:ligastavok/domain/models/orders_model.dart';
// import 'package:ligastavok/domain/models/outcome_bet_next.dart';
// import 'package:ligastavok/domain/models/partners_stream_request_model.dart';
// import 'package:ligastavok/domain/models/partners_stream_response_model.dart';
// import 'package:ligastavok/domain/models/payment.dart';
// import 'package:ligastavok/domain/models/payment_model.dart';
// import 'package:ligastavok/domain/models/payments.dart';
// import 'package:ligastavok/domain/models/payments/withdraw_model.dart';
// import 'package:ligastavok/domain/models/payout_agreement.dart';
// import 'package:ligastavok/domain/models/profile_item.dart';
// import 'package:ligastavok/domain/models/profile_next.dart';
// import 'package:ligastavok/domain/models/proposed_type.dart';
// import 'package:ligastavok/domain/models/score.dart';
// import 'package:ligastavok/domain/models/score_map.dart';
// import 'package:ligastavok/domain/models/score_part.dart';
// import 'package:ligastavok/domain/models/session_model_next.dart';
// import 'package:ligastavok/domain/models/sport.dart';
// import 'package:ligastavok/domain/models/sport_model.dart';
// import 'package:ligastavok/domain/models/sport_type.dart';
// import 'package:ligastavok/domain/models/sports_model.dart';
// import 'package:ligastavok/domain/models/sports_tree_category.dart';
// import 'package:ligastavok/domain/models/sports_tree_sport.dart';
// import 'package:ligastavok/domain/models/state_history.dart';
// import 'package:ligastavok/domain/models/static_text_block_model.dart';
// import 'package:ligastavok/domain/models/static_text_block_response_model.dart';
// import 'package:ligastavok/domain/models/statistics_status.dart';
// import 'package:ligastavok/domain/models/system_config_android_model.dart';
// import 'package:ligastavok/domain/models/system_config_ios_model.dart';
// import 'package:ligastavok/domain/models/system_config_model.dart';
// import 'package:ligastavok/domain/models/target_market_type.dart';
// import 'package:ligastavok/domain/models/topic.dart';
// import 'package:ligastavok/domain/models/tournament.dart';
// import 'package:ligastavok/domain/models/user.dart';
// import 'package:ligastavok/domain/models/user/user_status.dart';
// import 'package:ligastavok/domain/models/userOrders.dart';
// import 'package:ligastavok/domain/models/user_bet_item_next.dart';
// import 'package:ligastavok/domain/models/user_bets_response_next.dart';
// import 'package:ligastavok/domain/models/user_info.dart';
// import 'package:ligastavok/domain/models/user_info_model.dart';
// import 'package:ligastavok/domain/models/user_info_next.dart';
// import 'package:ligastavok/domain/models/user_vip_status.dart';
// import 'package:ligastavok/domain/models/vip_statuses.dart';
// import 'package:ligastavok/domain/models/websocket_rpc.dart';
// import 'package:ligastavok/domain/models/winning_amount.dart';
// import 'package:ligastavok/domain/models/withdraw_account.dart';
// import 'package:ligastavok/domain/models/withdraw_channel.dart';
// import 'package:ligastavok/domain/models/withdraw_channels.dart';
// import 'package:ligastavok/domain/models/withdraw_channels_model.dart';
// import 'package:ligastavok/domain/models/withdraw_fee_channel.dart';
// import 'package:ligastavok/domain/models/withdraw_fees.dart';
// import 'package:ligastavok/domain/models/withdraw_fees_model.dart';
// import 'package:ligastavok/domain/models/withdraw_fees_request.dart';
// import 'package:ligastavok/domain/models/withdraw_response_model.dart';
// import 'package:ligastavok/domain/network/model/action_lines/action_lines_request.dart';
// import 'package:ligastavok/domain/network/model/action_lines/action_lines_response.dart';
// import 'package:ligastavok/domain/network/model/autocomplete.dart';
// import 'package:ligastavok/domain/network/model/bets/bet_requests/bet_model.dart';
// import 'package:ligastavok/domain/network/model/bets/bet_requests/bet_outcome_model.dart';
// import 'package:ligastavok/domain/network/model/bets/bet_requests/bet_request.dart';
// import 'package:ligastavok/domain/network/model/bets/bet_response.dart';
// import 'package:ligastavok/domain/network/model/bets/bet_response_result.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_history_calculation_state.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_history_request.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_limit_batch_request.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_limit_model.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_limit_request.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_limit_response.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_topic_limit_model.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_topic_limit_request.dart';
// import 'package:ligastavok/domain/network/model/bets/bets_topic_limit_response.dart';
// import 'package:ligastavok/domain/network/model/bets/order_status_request.dart';
// import 'package:ligastavok/domain/network/model/bets/order_status_response.dart';
// import 'package:ligastavok/domain/network/model/event/block_brief_model.dart';
// import 'package:ligastavok/domain/network/model/event/block_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_competitor_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_counters_map_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_features_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_ids_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_info_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_popularity_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_priority_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_team_model.dart';
// import 'package:ligastavok/domain/network/model/event/event_video_stream_next.dart';
// import 'package:ligastavok/domain/network/model/event/market_base_model.dart';
// import 'package:ligastavok/domain/network/model/event/market_model.dart';
// import 'package:ligastavok/domain/network/model/event/market_with_outcomes_model.dart';
// import 'package:ligastavok/domain/network/model/event/outcome_model.dart';
// import 'package:ligastavok/domain/network/model/event/score_map_model.dart';
// import 'package:ligastavok/domain/network/model/event/score_model.dart';
// import 'package:ligastavok/domain/network/model/eventlist/eventlist_request.dart';
// import 'package:ligastavok/domain/network/model/eventlist/eventlist_response.dart';
// import 'package:ligastavok/domain/network/model/payments/deposit_channel.dart';
// import 'package:ligastavok/domain/network/model/payments/deposit_channel_response.dart';
// import 'package:ligastavok/domain/network/model/payments/deposit_channel_result.dart';
// import 'package:ligastavok/domain/network/model/payments/deposit_channel_type.dart';
// import 'package:ligastavok/domain/network/model/payments/payment_system.dart';
// import 'package:ligastavok/domain/network/model/payments/payments_history_request.dart';
// import 'package:ligastavok/domain/network/model/payments/payments_system_response.dart';
// import 'package:ligastavok/domain/network/model/request/empty_request.dart';
// import 'package:ligastavok/domain/network/model/request/register_device_token_request.dart';
// import 'package:ligastavok/domain/network/model/request/register_device_token_request_next.dart';
// import 'package:ligastavok/domain/network/model/search.dart';
// import 'package:ligastavok/domain/network/model/sportstree/category.dart';
// import 'package:ligastavok/domain/network/model/sportstree/grouping_model.dart';
// import 'package:ligastavok/domain/network/model/sportstree/grouping_request.dart';
// import 'package:ligastavok/domain/network/model/sportstree/grouping_response.dart';
// import 'package:ligastavok/domain/network/model/sportstree/sport.dart';
// import 'package:ligastavok/domain/network/model/sportstree/sports_tree.dart';
// import 'package:ligastavok/domain/network/model/sportstree/sports_tree_response.dart';
// import 'package:ligastavok/domain/network/model/sportstree/tournament_api.dart';
// import 'package:ligastavok/domain/network/model/websocket/json_rpc.dart';
// import 'package:ligastavok/domain/network/model/withdraw/withdraw_channel_request.dart';
// import 'package:ligastavok/domain/network/model/withdraw/withdraw_cupis.dart';
// import 'package:ligastavok/domain/network/model/withdraw/withdraw_request.dart';
// import 'package:ligastavok/domain/relative_path_uri.dart';
// import 'package:ligastavok/domain/states/live_tab.dart';
// import 'package:ligastavok/domain/states/states.dart';
// import 'package:ligastavok/feature/bet/network/model/bet_outcome_next.dart';
// import 'package:ligastavok/feature/bet/network/model/check_bet_item_next.dart';
// import 'package:ligastavok/feature/bet/network/model/check_bet_request_next.dart';
// import 'package:ligastavok/feature/bet/network/model/check_bet_response_next.dart';
// import 'package:ligastavok/feature/bet/network/model/make_bet_request_next.dart';
// import 'package:ligastavok/feature/cms/repository/cms_request.dart';
// import 'package:ligastavok/feature/deposit/repository/model/deposit_model.dart';
// import 'package:ligastavok/feature/deposit/repository/model/deposit_response_model.dart';
// import 'package:ligastavok/feature/documents/repository/entity/documents_response.dart';
// import 'package:ligastavok/feature/favorites/repository/model/add_favorite_request.dart';
// import 'package:ligastavok/feature/favorites/repository/model/delete_favorite_request.dart';
// import 'package:ligastavok/feature/favorites/repository/model/favorite_model.dart';
// import 'package:ligastavok/feature/favorites/repository/model/favorite_response.dart';
// import 'package:ligastavok/feature/favorites/repository/model/get_favorites_request.dart';
// import 'package:ligastavok/feature/fee/repository/model/deposit_fee.dart';
// import 'package:ligastavok/feature/identification/repository/model/identification_additionalway_card_model.dart';
// import 'package:ligastavok/feature/identification/repository/model/simple_identification_state_model.dart';
// import 'package:ligastavok/feature/identification/repository/model/simple_identification_state_response.dart';
// import 'package:ligastavok/feature/identification/repository/model/simple_identity_docs_dto.dart';
// import 'package:ligastavok/feature/identification/repository/model/simple_identity_scans_dto.dart';
// import 'package:ligastavok/feature/identification/repository/model/user_address_model.dart';
// import 'package:ligastavok/feature/making_bet_next/domain/state/make_bet_state.dart';
// import 'package:ligastavok/feature/promocode/redux/promocode_state.dart';
// import 'package:ligastavok/feature/promocode/repository/promocode_list_response_model.dart';
// import 'package:ligastavok/feature/registration/repository/registration_repository_model.dart';
// import 'package:ligastavok/feature/registration_next/repository/entity/registration_request_next.dart';
// import 'package:ligastavok/feature/registration_next/repository/entity/registration_response_next.dart';
// import 'package:ligastavok/feature/registration_next/repository/entity/secrete_question_response.dart';
// import 'package:ligastavok/feature/sportbook/model/sport_categories_next.dart';
// import 'package:ligastavok/feature/sportbook/model/sport_leagues_next.dart';
// import 'package:ligastavok/feature/sportbook/model/sport_next.dart';
// import 'package:ligastavok/feature/sportbook/model/sportbook_response_next.dart';
// import 'package:ligastavok/feature/sportbook/model/sports_response_next.dart';
// import 'package:ligastavok/feature/sportbook/model/translations_next.dart';
// import 'package:ligastavok/feature/stories/domain/model/story_model.dart';
// import 'package:ligastavok/feature/video_broadcast/video_broadcast.dart';
// import 'package:ligastavok/utilities/validation/config/validation_rule_config.dart';

// part 'serializers.g.dart';

// @SerializersFor([
//   AuthState,
//   MainMarket,
//   User,
//   Event,
//   Outcome,
//   Block,
//   BlockBrief,
//   Market,
//   ScorePart,
//   ScoreMap,
//   Score,
//   ScoreModel,
//   EventTeam,
//   MarketFilter,
//   LineState,
//   Counters,
//   Order,
//   OrderAmount,
//   Currency,
//   Orders,
//   OrdersModel,
//   UserOrders,
//   BoolResultModel,
//   ErrorModel,
//   Meta,
//   UserInfo,
//   DiffMessageModel,
//   EventPriority,
//   DiffCollectionModel,
//   WinningAmount,
//   Bet,
//   OrderStatusResponse,
//   OrderStatusRequest,
//   SportType,
//   BetOutcome,
//   BetEvent,
//   BetMarket,
//   BetBlock,
//   BetStateFilterType,
//   TargetMarketType,
//   BetSport,
//   Sport,
//   SportsTreeSport,
//   SportBookState,
//   Tournament,
//   SportsTreeCategory,
//   FavoritesState,
//   NetworkConfig,
//   NetworkConfigItem,
//   BetResponseResult,
//   BetResponse,
//   BetType,
//   BetOutcomeIdFactorId,
//   GetDeviceIdModel,
//   GetTokenModel,
//   UserState,
//   UserStatus,
//   CartState,
//   ProfileItem,
//   UserInfoModel,
//   Balance,
//   BalanceModel,
//   AutocompleteRequest,
//   AutoCompleteResponse,
//   AutocompleteResult,
//   AutocompleteRow,
//   SearchRequest,
//   SearchResponse,
//   EventModel,
//   EventPriorityModel,
//   EventPopularityModel,
//   EventIdsModel,
//   EventInfoModel,
//   BlockBriefModel,
//   EventTeamModel,
//   EventCompetitorModel,
//   EventFeaturesModel,
//   Payments,
//   PaymentModel,
//   Payment,
//   PayoutAgreement,
//   StateHistory,
//   EventsRequest,
//   EventListRequest,
//   EventListResponse,
//   EventListModel,
//   WithdrawChannelsModel,
//   WithdrawChannels,
//   WithdrawChannel,
//   WithdrawFeesRequest,
//   WithdrawFeesModel,
//   WithdrawFeeChannel,
//   WithdrawFees,
//   RegistrationState,
//   MarketModel,
//   OutcomeModel,
//   BetOutcomeModel,
//   BlockModel,
//   ConfigState,
//   MarketWithOutcomesModel,
//   MarketBaseModel,
//   ScoreMapModel,
//   Topic,
//   SportsTreeApiModel,
//   SportApiModel,
//   CategoryApiModel,
//   TournamentApiModel,
//   SportsModel,
//   EmptyRequest,
//   SportsTreeResponse,
//   CountersModel,
//   CountersSocketModel,
//   PaymentsHistoryRequest,
//   WithdrawChannelsRequest,
//   DepositChannel,
//   DepositChannelResponse,
//   DepositChannelResult,
//   PaymentsSystemsResponse,
//   PaymentSystem,
//   DepositChannelType,
//   CurrencyType,
//   BetsHistoryRequest,
//   BetsHistoryCalculationState,
//   SortDirection,
//   Namespace,
//   ProposedType,
//   BetValueChangeType,
//   ErrorState,
//   ActionLinesRequest,
//   ActionLinesResponse,
//   DepositFeeResponse,
//   DepositFeeRequest,
//   DepositFeeResult,
//   DepositFeeChannel,
//   BetDetailsState,
//   BetModel,
//   BetRequest,
//   BetState,
//   MakeBetState,
//   EventDetailState,
//   EventDetailsSortType,
//   EventDetailsFilterType,

//   SingleState,
//   QuickState,
//   BookmakerSingleBet,
//   ConfirmEmailResultModel,
//   ConfirmEmailModel,
//   ConfirmPhoneModel,
//   ConfirmPhoneModelResult,
//   BindAccountModel,
//   BindAccountResultModel,
//   WithdrawAccount,
//   AppRoute,
//   DepositRequest,
//   DepositResponseModel,
//   WithdrawRequest,
//   WithdrawResponseModel,
//   WithdrawCupisRequest,
//   WithdrawCupisResponse,
//   DepositModel,
//   WithdrawModel,
//   EventCountersMap,
//   EventCountersMapModel,
//   WithdrawCupisRequest,
//   RegistrationType,
//   UserVipStatus,
//   VipStatuses,
//   StaticTextBlockResponseModel,
//   StaticTextBlockModel,
//   RemoteConfigModel,
//   SystemConfigModel,
//   SystemConfigAndroidModel,
//   SystemConfigIosModel,
//   LineCalendarFilter,
//   LineMinNumber,
//   //Analytics
//   AnalyticBet,
//   AnalyticDepositModel,
//   AnalyticStreamModel,
//   ArchiveState,
//   BetsLimitRequest,
//   BetsLimitBatchRequest,
//   BetLimitsModel,
//   BetLimitsResponse,
//   BetsTopicLimitModel,
//   BetsTopicLimitRequest,
//   BetsTopicLimitResponse,
//   RegisterDeviceTokenRequest,
//   RegisterDeviceTokenRequestNext,
//   CartType,
//   MakeBetModel,
//   DialogBundle,
//   LiveTab,
//   QaConfig,
//   BetResultEnumStatus,
//   BetStateFilterType,
//   FavoritesResponse,
//   FavoritesModel,
//   AddFavoriteRequest,
//   GetFavoritesRequest,
//   EventActionModel,
//   DeleteFavoriteRequest,
//   BetResultEnumStatus,
//   CartState,
//   CartSettings,
//   CartDeleteOutcomeSettings,
//   GroupingModel,
//   GroupingRequest,
//   GroupingResponse,
//   RegistrationRepositoryModel,
//   SimplifiedIdentificationDocsDto,
//   SimpleIdentityScansDto,
//   SimplifiedIdentificationAddress,
//   SimpleIdentificationStateModel,
//   SimpleIdentificationStateResponse,
//   StatisticsStatus,
//   IdentificationAdditionalWayCardModel,
//   PartnersStreamUrlResponseModel,
//   PartnersStreamRequestModel,
//   StoriesResponse,
//   AppLifecycle,
//   // new
//   AppConfig,
//   InfoConfig,
//   FeaturesConfig,
//   LocalSettings,
//   CmsRequest,
//   RelativePathUri,
//   PromocodeListResponseModel,
//   PromocodeListResponseModelResult,
//   PromocodeListEntityDTO,
//   PromocodeState,
//   JsonRpcRequest,
//   JsonRpcRequestParams,
//   JsonRpcRequestArgs,
//   WebsocketRpcModel,
//   WebsocketRpcResultModel,
//   ValidationRuleConfig,
//   SessionModelNext,
//   UserInfoNext,
//   ProfileNext,
//   //sport next
//   ErrorModelNext,
//   BalanceItemNext,
//   ErrorModelNext,
//   SportsResponseNext,
//   SportNext,
//   TranslationsNext,
//   SportbookResponseNext,
//   SportCategoriesNext,
//   SportLeaguesNext,

//   //event next
//   GamesResponseNext,
//   GameItemNext,
//   GameCompetitorNext,
//   MarketNext,
//   LiveStatusNext,
//   OddsNext,
//   UserBetsResponseNext,
//   UserBetItemNext,
//   CurrencyNext,
//   BetSystem,
//   BetGameNext,
//   GameLiveStatusNext,
//   MarketNext,
//   OddNext,
//   OutcomeBetNext,
//   MarketConfig,
//   MarketConfigItem,
//   EventGroupDescriptionSegment,
//   CategoryMarketNext,
//   GameCurrentPeriodNext,
//   ContactConfig,
//   VideoPlayerStateModel,
//   PeriodScore,
//   EventMarketCategory,
//   EventVideoStreamNext,

//   //registration next
//   RegistrationResponseNext,
//   RegisteredUserInfoNext,
//   SecreteQuestionResponse,
//   SecreteQuestionTranslation,
//   RegistrationRequestNext,
//   RegistrationProfileNext,
//   RegistrationPhoneNumberNext,
//   RegistrationAddressNext,
//   RegistrationOnlineContactNext,
//   DocumentsResponse,
//   DocumentNetworkModel,

//   // bets
//   MakeBetRequestNext,
//   BetOutcomeNext,
//   CheckBetResponseNext,
//   CheckBetItemNext,
//   CheckBetRequestNext,
// ])
// final Serializers serializers = (_$serializers.toBuilder()
//       ..add(SportModel.serializer())
//       ..addBuilderFactory(
//         const FullType(
//           BuiltMap,
//           [FullType(String), FullType(SportModel)],
//         ),
//         () => MapBuilder<String, SportModel>(),
//       )
//       ..addBuilderFactory(
//         const FullType(
//           BuiltMap,
//           [FullType(String), FullType(BlockBriefModel)],
//         ),
//         () => MapBuilder<String, BlockBriefModel>(),
//       )
//       ..add(DiffModel.serializer())
//       ..addBuilderFactory(
//         const FullType(
//           BuiltList,
//           [FullType(int)],
//         ),
//         () => ListBuilder<int>(),
//       )
//       ..addBuilderFactory(
//         const FullType(
//           BuiltList,
//           [FullType(DiffMessageModel)],
//         ),
//         () => ListBuilder<DiffMessageModel>(),
//       )
// // ..addBuilderFactory(
// //   const FullType(
// //     BuiltList,
// //     [FullType(ScoreModel)],
// //   ),
// //   () => ListBuilder<ScoreModel>(),
// // )
//       ..addBuilderFactory(
//         const FullType(
//           BuiltList,
//           [FullType(Counters)],
//         ),
//         () => ListBuilder<Counters>(),
//       )
//       ..addBuilderFactory(
//         const FullType(
//           BuiltList,
//           [
//             FullType(
//               BuiltMap,
//               [FullType(String), FullType(int)],
//             ),
//           ],
//         ),
//         () => ListBuilder<MapBuilder<String, int>>(),
//       )
//       ..addPlugin(
//         StandardJsonPlugin(),
//       ))
//     .build();
// const intListFullType = const FullType(
//   BuiltList,
//   [FullType(int)],
// );
// const listOfMapsWithStringAndIntFullType = const FullType(
//   BuiltList,
//   [
//     FullType(
//       BuiltMap,
//       [FullType(String), FullType(int)],
//     ),
//   ],
// );
// const sportsMapFullType = const FullType(
//   BuiltMap,
//   [FullType(String), FullType(SportModel)],
// );
// const partsMapFullType = const FullType(
//   BuiltMap,
//   [FullType(String), FullType(BlockBriefModel)],
// );
// const diffMessagesListFullType = const FullType(
//   BuiltList,
//   [FullType(DiffMessageModel)],
// );
// const scoresListFullType = const FullType(
//   BuiltList,
//   [FullType(ScoreModel)],
// );
// const countersListFullType = const FullType(
//   BuiltList,
//   [FullType(Counters)],
// );
// const marketWithOutcomesMapFullType = const FullType(
//   BuiltMap,
//   [FullType(String), FullType(MarketWithOutcomesModel)],
// );
// const listOfUsers = const FullType(
//   BuiltList,
//   [
//     FullType(
//       BuiltMap,
//       [FullType(String), FullType(String)],
//     ),
//   ],
// );
