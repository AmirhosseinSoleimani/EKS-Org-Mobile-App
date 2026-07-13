import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_details_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';

class LeaveState {
  const LeaveState({
    this.items = const [],
    this.filteredItems = const [],
    this.reasons = const [],
    this.secondaryReasons = const [],
    this.details,
    this.selectedStatus = LeaveStatus.all,
    this.selectedType = LeaveType.all,
    this.selectedMainReason,
    this.selectedSecondaryReason,
    this.agencyCode = '',
    this.emdadgarFullName = '',
    this.searchText = '',
    this.isListLoading = false,
    this.isReasonsLoading = false,
    this.isDetailsLoading = false,
    this.isActionLoading = false,
    this.lastMessage,
    this.actionCompleted = false,
    this.hasConnectionError = false,
  });

  final List<LeaveListItemEntity> items;
  final List<LeaveListItemEntity> filteredItems;
  final List<LeaveReasonEntity> reasons;
  final List<LeaveReasonEntity> secondaryReasons;
  final LeaveDetailsEntity? details;
  final LeaveStatus selectedStatus;
  final LeaveType selectedType;
  final LeaveReasonEntity? selectedMainReason;
  final LeaveReasonEntity? selectedSecondaryReason;
  final String agencyCode;
  final String emdadgarFullName;
  final String searchText;
  final bool isListLoading;
  final bool isReasonsLoading;
  final bool isDetailsLoading;
  final bool isActionLoading;
  final BottomSheetMessageModel? lastMessage;
  final bool actionCompleted;
  final bool hasConnectionError;

  LeaveState copyWith({
    List<LeaveListItemEntity>? items,
    List<LeaveListItemEntity>? filteredItems,
    List<LeaveReasonEntity>? reasons,
    List<LeaveReasonEntity>? secondaryReasons,
    LeaveDetailsEntity? details,
    bool clearDetails = false,
    LeaveStatus? selectedStatus,
    LeaveType? selectedType,
    LeaveReasonEntity? selectedMainReason,
    bool clearSelectedMainReason = false,
    LeaveReasonEntity? selectedSecondaryReason,
    bool clearSelectedSecondaryReason = false,
    String? agencyCode,
    String? emdadgarFullName,
    String? searchText,
    bool? isListLoading,
    bool? isReasonsLoading,
    bool? isDetailsLoading,
    bool? isActionLoading,
    BottomSheetMessageModel? lastMessage,
    bool clearLastMessage = false,
    bool? actionCompleted,
    bool? hasConnectionError,
  }) {
    return LeaveState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      reasons: reasons ?? this.reasons,
      secondaryReasons: secondaryReasons ?? this.secondaryReasons,
      details: clearDetails ? null : details ?? this.details,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedType: selectedType ?? this.selectedType,
      selectedMainReason: clearSelectedMainReason
          ? null
          : selectedMainReason ?? this.selectedMainReason,
      selectedSecondaryReason: clearSelectedSecondaryReason
          ? null
          : selectedSecondaryReason ?? this.selectedSecondaryReason,
      agencyCode: agencyCode ?? this.agencyCode,
      emdadgarFullName: emdadgarFullName ?? this.emdadgarFullName,
      searchText: searchText ?? this.searchText,
      isListLoading: isListLoading ?? this.isListLoading,
      isReasonsLoading: isReasonsLoading ?? this.isReasonsLoading,
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      lastMessage: clearLastMessage ? null : lastMessage ?? this.lastMessage,
      actionCompleted: actionCompleted ?? this.actionCompleted,
      hasConnectionError: hasConnectionError ?? this.hasConnectionError,
    );
  }
}

