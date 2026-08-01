import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/utils/general_content_date_converter.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_description_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_file_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_main_info_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_schedule_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_submit_controller.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';

class GeneralContentForm extends StatefulWidget {
  const GeneralContentForm({
    super.key,
    required this.state,
    required this.submitController,
    required this.onSubmit,
    required this.onSuccess,
    this.initialContent,
  });

  final GeneralContentState state;
  final GeneralContentSubmitController submitController;
  final GeneralContentEntity? initialContent;
  final Future<bool> Function(GeneralContentFormParamEntity param) onSubmit;
  final VoidCallback onSuccess;

  @override
  State<GeneralContentForm> createState() => _GeneralContentFormState();
}

class _GeneralContentFormState extends State<GeneralContentForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _applyDateController;
  late final TextEditingController _descriptionController;

  int? _selectedContentType;
  int? _selectedReceiverType;
  int? _selectedStatus;
  UploadedFileEntity? _selectedFile;

  bool get _isEditMode => widget.initialContent?.id != null;

  @override
  void initState() {
    super.initState();
    final content = widget.initialContent;
    _titleController = TextEditingController(text: content?.title ?? '');
    _startDateController = TextEditingController(
      text: GeneralContentDateConverter.initialJalaliText(
        jalaliValue: content?.startDateJalali,
        gregorianValue: content?.startDate,
      ),
    );
    _applyDateController = TextEditingController(
      text: GeneralContentDateConverter.initialJalaliText(
        jalaliValue: content?.applyDateJalali,
        gregorianValue: content?.applyDate,
      ),
    );
    _descriptionController =
        TextEditingController(text: content?.description ?? '');
    _selectedContentType = content?.contentType;
    _selectedReceiverType = content?.receiverType;
    _selectedStatus = content?.isActive == false ? 0 : 1;
    widget.submitController.attach(_submit);
  }

  @override
  void didUpdateWidget(covariant GeneralContentForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.submitController != widget.submitController) {
      oldWidget.submitController.detach(_submit);
      widget.submitController.attach(_submit);
    }
  }

  @override
  void dispose() {
    widget.submitController.detach(_submit);
    _titleController.dispose();
    _startDateController.dispose();
    _applyDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p24,
          AppPadding.p16,
          AppPadding.p32,
        ),
        children: [
          GeneralContentMainInfoSection(
            titleController: _titleController,
            contentTypes: widget.state.contentTypeOptions,
            receiverTypes: widget.state.receiverTypeOptions,
            selectedContentType: _selectedContentType,
            selectedReceiverType: _selectedReceiverType,
            selectedStatus: _selectedStatus,
            onContentTypeChanged: (value) {
              setState(() => _selectedContentType = value);
            },
            onReceiverTypeChanged: (value) {
              setState(() => _selectedReceiverType = value);
            },
            onStatusChanged: (value) {
              setState(() => _selectedStatus = value);
            },
          ),
          GeneralContentScheduleSection(
            startDateController: _startDateController,
            applyDateController: _applyDateController,
          ),
          GeneralContentFileSection(
            isEditMode: _isEditMode,
            onFileChanged: (file) => _selectedFile = file,
          ),
          GeneralContentDescriptionSection(
            controller: _descriptionController,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    if (GeneralContentDateConverter.isApplyDateBeforeStartDate(
      startDate: _startDateController.text,
      applyDate: _applyDateController.text,
    )) {
      SnakeBarWidget.showError(
        context: context,
        message: 'تاریخ اجرا نمی‌تواند قبل از تاریخ ابلاغ باشد.',
      );
      return;
    }

    final startDate = GeneralContentDateConverter.toGregorianString(
      _startDateController.text,
    );
    final applyDate = GeneralContentDateConverter.toGregorianString(
      _applyDateController.text,
    );
    if (startDate == null || applyDate == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'فرمت تاریخ‌های واردشده معتبر نیست.',
      );
      return;
    }

    final contentType = _selectedContentType;
    final receiverType = _selectedReceiverType;
    if (contentType == null || receiverType == null) return;

    final selectedFile = _selectedFile;
    final success = await widget.onSubmit(
      GeneralContentFormParamEntity(
        id: widget.initialContent?.id,
        title: _titleController.text.trim(),
        startDate: startDate,
        applyDate: applyDate,
        description: _descriptionController.text.trim(),
        contentType: contentType,
        receiverType: receiverType,
        isActive: _selectedStatus != 0,
        filePath: selectedFile?.path,
        fileBytes: selectedFile?.bytes,
        fileName: selectedFile?.name,
      ),
    );

    if (success && mounted) {
      widget.onSuccess();
    }
  }
}
