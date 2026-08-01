import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/utils/general_content_date_converter.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_description_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_file_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_main_info_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_schedule_section.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_submit_controller.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:file_picker/file_picker.dart';
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
  static const _maxFileSize = 5 * 1024 * 1024;
  static const _allowedExtensions = <String>[
    'jpeg',
    'jpg',
    'png',
    'zip',
    'pdf',
  ];

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _applyDateController;
  late final TextEditingController _descriptionController;

  int? _selectedContentType;
  int? _selectedReceiverType;
  int? _selectedStatus;
  String? _filePath;
  String? _fileName;
  Uint8List? _fileBytes;
  bool _isImage = false;
  bool _showFileRequiredError = false;

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
            fileName: _fileName,
            previewBytes: _fileBytes,
            isImage: _isImage,
            isEditMode: _isEditMode,
            showRequiredError: _showFileRequiredError,
            onPickFile: _pickFile,
            onRemoveFile: _removeFile,
          ),
          GeneralContentDescriptionSection(
            controller: _descriptionController,
          ),
        ],
      ),
    );
  }
  Future<void> _pickFile() async {
    FocusScope.of(context).unfocus();

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: false,
        withData: true,
      );

      final file = result?.files.single;
      if (file == null) return;

      if (file.size > _maxFileSize) {
        if (!mounted) return;

        SnakeBarWidget.showError(
          context: context,
          message: 'حجم فایل انتخاب‌شده نباید بیشتر از ۵ مگابایت باشد.',
        );
        return;
      }

      final bytes = file.bytes ?? await file.xFile.readAsBytes();

      if (!mounted) return;

      if (bytes.isEmpty) {
        SnakeBarWidget.showError(
          context: context,
          message: 'امکان خواندن فایل انتخاب‌شده وجود ندارد.',
        );
        return;
      }

      final extension = file.extension?.toLowerCase() ?? '';

      setState(() {
        _filePath = file.path;
        _fileName = file.name;
        _fileBytes = bytes;
        _isImage = extension == 'jpg' ||
            extension == 'jpeg' ||
            extension == 'png';

        _showFileRequiredError = false;
      });
    } catch (_) {
      if (!mounted) return;

      SnakeBarWidget.showError(
        context: context,
        message: 'خطایی هنگام انتخاب فایل رخ داده است.',
      );
    }
  }

  void _removeFile() {
    setState(() {
      _filePath = null;
      _fileName = null;
      _fileBytes = null;
      _isImage = false;
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isFormValid = _formKey.currentState?.validate() ?? false;
    final isFileValid = _isEditMode || _fileName?.trim().isNotEmpty == true;
    setState(() => _showFileRequiredError = !isFileValid);

    if (!isFormValid || !isFileValid) return;

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
        filePath: _filePath,
        fileBytes: _fileBytes,
        fileName: _fileName,
      ),
    );

    if (success && mounted) {
      widget.onSuccess();
    }
  }
}
