import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/validator/validations/iran_license_plate_validation.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_middle_character_modal.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LicensePlateTextFormFieldWidget extends StatefulWidget {
  const LicensePlateTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.mandatory,
  });

  final TextEditingController controller;
  final bool mandatory;

  @override
  State<LicensePlateTextFormFieldWidget> createState() =>
      _LicensePlateTextFormFieldWidgetState();
}

class _LicensePlateTextFormFieldWidgetState
    extends State<LicensePlateTextFormFieldWidget> {
  final ValueNotifier<String> _carTag = ValueNotifier<String>('ب');
  final _partOneController = TextEditingController();
  final _partTwoController = TextEditingController();
  final _partThreeController = TextEditingController();
  final _partOneNode = FocusNode();
  final _partTwoNode = FocusNode();
  final _partThreeNode = FocusNode();

  void _updateMainController() {
    final newCarTag =
        '${_partOneController.text} ${_carTag.value} ${_partTwoController.text} ${_partThreeController.text}';
    if (widget.controller.text != newCarTag) {
      widget.controller.text = newCarTag;
      Form.maybeOf(context)?.validate();
    }
  }

  void _parseInitialValue() {
    final parts = widget.controller.text.trim().split(' ');
    if (parts.length == 4) {
      _partOneController.text = parts[0];
      _carTag.value = parts[1];
      _partTwoController.text = parts[2];
      _partThreeController.text = parts[3];
    }
  }

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
    _partOneController.addListener(_updateMainController);
    _partTwoController.addListener(_updateMainController);
    _partThreeController.addListener(_updateMainController);
    _carTag.addListener(_updateMainController);
  }

  @override
  void dispose() {
    _partOneController.dispose();
    _partTwoController.dispose();
    _partThreeController.dispose();
    _partOneNode.dispose();
    _partTwoNode.dispose();
    _partThreeNode.dispose();
    _carTag.dispose();
    _partOneController.removeListener(_updateMainController);
    _partTwoController.removeListener(_updateMainController);
    _partThreeController.removeListener(_updateMainController);
    _carTag.removeListener(_updateMainController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) {
        if (!widget.mandatory) return null;
        return const IranLicensePlateValidation(
          fieldName: 'شماره پلاک',
        ).validate(widget.controller.text);
      },
      builder: (field) {
        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: AppSize.s60,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  border: Border.all(
                    width: AppSize.s2,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s6),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                'ایران',
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(fontSize: AppSize.s14),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s6),
                              child: TextFormFieldWidget(
                                focusNode: _partThreeNode,
                                controller: _partThreeController,
                                textAlign: TextAlign.center,
                                hintText: '--',
                                border: InputBorder.none,
                                focusBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                textInputFormatter: [
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                      signed: true,
                                    ),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).unfocus(),
                                onChanged: (String? value) {
                                  if (value!.length == 2) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.onSurface,
                      thickness: AppSize.s2,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s6),
                        child: TextFormFieldWidget(
                          borderRadius: 16,
                          focusNode: _partTwoNode,
                          controller: _partTwoController,
                          hintText: '---',
                          textAlign: TextAlign.center,
                          border: InputBorder.none,
                          focusBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          onChanged: (String? value) {
                            if (_partTwoController.text.length == 3) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_partThreeNode);
                            }
                          },
                        ),
                      ),
                    ),
                    ValueListenableBuilder<String>(
                      valueListenable: _carTag,
                      builder: (BuildContext context, value, Widget? child) {
                        return Expanded(
                          child: Container(
                            height: AppSize.s48,
                            margin: const EdgeInsets.only(right: AppPadding.p4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSize.s6),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppSize.s6),
                              onTap: () {
                                CarMiddleCharacterModal(
                                  context: context,
                                  carTag: _carTag,
                                ).show().then((_) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_partTwoNode);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (value == 'ژ')
                                    Icon(
                                      Icons.wheelchair_pickup_outlined,
                                      size: AppSize.s20,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    )
                                  else
                                    Text(
                                      value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: AppSize.s16),
                                    ),
                                  Space.w4,
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    size: AppSize.s16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p4,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s6),
                          child: TextFormFieldWidget(
                            textAlign: TextAlign.center,
                            focusNode: _partOneNode,
                            controller: _partOneController,
                            hintText: '--',
                            border: InputBorder.none,
                            focusBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textInputType:
                                const TextInputType.numberWithOptions(
                                  signed: true,
                                ),
                            onChanged: (String? value) {
                              if (_partOneController.text.length == 2) {
                                CarMiddleCharacterModal(
                                  context: context,
                                  carTag: _carTag,
                                ).show().then((_) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_partTwoNode);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s6),
                        bottomLeft: Radius.circular(AppSize.s6),
                      ),
                      child: Image.asset(
                        ImageManager.iranFlag,
                        width: AppSize.s32,
                        height: AppSize.s60,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: AppSize.s24,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (hasError) ...[
              Space.h6,
              BodySmallText(
                text: field.errorText ?? '',
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ],
        );
      },
    );
  }
}
