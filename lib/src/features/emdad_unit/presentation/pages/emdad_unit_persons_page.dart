import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadUnitPersonsPage extends StatelessWidget {
  static const path = '/emdad-unit-persons-page';
  static const name = 'emdad-unit-persons-page';

  const EmdadUnitPersonsPage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>()..loadPersons(item),
      child: const _EmdadUnitPersonsView(),
    );
  }
}

class _EmdadUnitPersonsView extends StatefulWidget {
  const _EmdadUnitPersonsView();

  @override
  State<_EmdadUnitPersonsView> createState() => _EmdadUnitPersonsViewState();
}

class _EmdadUnitPersonsViewState extends State<_EmdadUnitPersonsView> {
  int? _selectedPersonId;
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success && state.message != null) {
          _changed = true;
          SnakeBarWidget.showSuccess(context: context, message: state.message!);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.pop(_changed);
          return false;
        },
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'امدادرسان‌ها'),
          body: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
            builder: (context, state) {
              if (state.status == EmdadUnitViewStatus.loading && state.persons.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                padding: const EdgeInsets.all(AppPadding.p16),
                children: [
                  Text(state.selectedItem?.name ?? '', style: Theme.of(context).textTheme.titleSmall),
                  Space.h16,
                  DropdownButtonFormField<int>(
                    value: _selectedPersonId,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'امدادرسان'),
                    items: state.agencyPersons
                        .map((item) => DropdownMenuItem(
                              value: item.id,
                              child: Text(item.title, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedPersonId = value),
                  ),
                  Space.h12,
                  InkwellButtonWidget(
                    title: 'افزودن امدادرسان',
                    showLoading: state.status == EmdadUnitViewStatus.submitting,
                    onTap: () {
                      if (_selectedPersonId == null) {
                        SnakeBarWidget.showError(
                          context: context,
                          message: 'انتخاب امدادرسان اجباری می باشد',
                        );
                        return;
                      }
                      cubit.assignPerson(_selectedPersonId!);
                      setState(() => _selectedPersonId = null);
                    },
                  ),
                  Space.h24,
                  if (state.persons.isEmpty)
                    const Center(child: Text('رکوردی یافت نشد.'))
                  else
                    ...state.persons.map(
                      (person) => Card(
                        margin: const EdgeInsets.only(bottom: AppMargin.m12),
                        child: ListTile(
                          title: Text(person.fullName),
                          subtitle: Text([
                            person.nationalNumber,
                            person.mobile,
                            person.agencyInfoTitle,
                          ].where((item) => item?.trim().isNotEmpty == true).join(' | ')),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              EmdadUnitStatusBadge(isActive: person.isActive),
                              IconButton(
                                tooltip: 'حذف',
                                onPressed: person.id == null
                                    ? null
                                    : () => _confirmDelete(context, person.id!, person.fullName, cubit),
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    int id,
    String name,
    EmdadUnitCubit cubit,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('توجه'),
        content: Text('آیا امدادرسان $name حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await cubit.deletePerson(id);
    }
  }
}
