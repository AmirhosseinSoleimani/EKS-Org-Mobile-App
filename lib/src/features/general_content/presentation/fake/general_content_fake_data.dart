import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';

class GeneralContentFakeData {
  const GeneralContentFakeData._();

  static List<GeneralContentEntity> buildContents({
    required List<CurrentSessionEnumItemEntity> contentTypes,
    required List<CurrentSessionEnumItemEntity> receiverTypes,
  }) {
    const titles = <String>[
      'دستورالعمل ارائه خدمات نوروزی',
      'الزام ثبت تصاویر پیش از پایان خدمت',
      'بخشنامه نحوه پذیرش خودروهای امدادی',
      'اصلاح فرآیند ثبت کیلومتر خودرو',
      'اطلاعیه ساعات فعالیت نمایندگی‌ها',
      'دستورالعمل کنترل کیفیت خدمات در محل',
      'بخشنامه مدیریت درخواست‌های فوری',
      'الزام بروزرسانی اطلاعات امدادگران',
      'اطلاعیه تغییرات سامانه ارزیابی عملکرد',
      'راهنمای ثبت و پیگیری شکایات مشتریان',
      'ضوابط استفاده از تجهیزات امدادی',
      'بخشنامه نحوه گزارش‌گیری ماهانه',
    ];
    const fallbackTypeTitles = <String>[
      'بخشنامه',
      'اطلاعیه',
      'دستورالعمل',
    ];
    const users = <String>[
      'علی رضایی',
      'مریم احمدی',
      'حسین کریمی',
      'زهرا محمدی',
    ];

    return List<GeneralContentEntity>.generate(24, (index) {
      final type = contentTypes.isEmpty
          ? null
          : contentTypes[index % contentTypes.length];
      final receiver = receiverTypes.isEmpty
          ? null
          : receiverTypes[index % receiverTypes.length];
      final fallbackTypeIndex = index % fallbackTypeTitles.length;
      final day = ((index % 28) + 1).toString().padLeft(2, '0');
      final hour = ((index % 10) + 8).toString().padLeft(2, '0');
      final minute = index.isEven ? '15' : '45';

      return GeneralContentEntity(
        id: index + 1,
        title: titles[index % titles.length],
        description:
            'این متن فیک برای بررسی نمایش توضیحات، چیدمان کارت و رفتار رابط کاربری ایجاد شده است.',
        contentType: type?.value ?? fallbackTypeIndex + 1,
        contentTypeText: type?.title ??
            type?.name ??
            fallbackTypeTitles[fallbackTypeIndex],
        receiverType: receiver?.value ?? (index % 3) + 1,
        receiverTypeText: receiver?.title ??
            receiver?.name ??
            (index.isEven ? 'نمایندگی‌ها' : 'امدادگران'),
        applyDate: '2026-08-$day',
        applyDateJalali: '1405/05/$day',
        startDate: '2026-07-$day',
        startDateJalali: '1405/04/$day',
        insertUserFullName: users[index % users.length],
        updateUserFullName: users[(index + 1) % users.length],
        insertDateTime: '2026-07-${day}T$hour:$minute:00',
        insertDateTimeJalali: '1405/04/$day $hour:$minute',
        updateDateTime: '2026-08-${day}T$hour:$minute:00',
        updateDateTimeJalali: '1405/05/$day $hour:$minute',
        isActive: index % 4 != 3,
      );
    });
  }

  static List<GeneralContentTargetEntity> buildTargets({
    required int contentId,
  }) {
    return <GeneralContentTargetEntity>[
      GeneralContentTargetEntity(
        id: contentId * 10 + 1,
        targetType: 1,
        operatorType: 1,
        operatorText: 'برابر است با',
        targetTitle: 'استان محل فعالیت',
        targetCategoryTitle: 'تهران',
        targetBoundaryType: 1,
        targetBoundaryTypeText: 'شامل شود',
        targetCategoryId: 1,
      ),
      GeneralContentTargetEntity(
        id: contentId * 10 + 2,
        targetType: 2,
        operatorType: 2,
        operatorText: 'شامل می‌شود',
        targetTitle: 'نوع مرکز خدمت‌رسانی',
        targetCategoryTitle: 'نمایندگی و امداد خودرو',
        targetBoundaryType: 1,
        targetBoundaryTypeText: 'شامل شود',
        targetCategoryId: 2,
      ),
      GeneralContentTargetEntity(
        id: contentId * 10 + 3,
        targetType: 3,
        operatorType: 1,
        operatorText: 'برابر است با',
        targetTitle: 'وضعیت همکاری',
        targetCategoryTitle: 'غیرفعال',
        targetBoundaryType: 2,
        targetBoundaryTypeText: 'مستثنی شود',
        targetCategoryId: 3,
      ),
      GeneralContentTargetEntity(
        id: contentId * 10 + 4,
        targetType: 4,
        operatorType: 2,
        operatorText: 'شامل می‌شود',
        targetTitle: 'سمت سازمانی',
        targetCategoryTitle: 'مدیر نمایندگی، کارشناس فنی و امدادگر',
        targetBoundaryType: 1,
        targetBoundaryTypeText: 'شامل شود',
        targetCategoryId: 4,
      ),
    ];
  }

  static List<CurrentSessionEnumItemEntity> targetCategories(int? targetType) {
    switch (targetType) {
      case 1:
        return provinceCategories;
      case 2:
        return serviceCenterCategories;
      case 3:
        return cooperationStatusCategories;
      case 4:
        return jobPositionCategories;
      default:
        return genericCategories;
    }
  }

  static const contentTypes = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, name: 'Circular', title: 'بخشنامه'),
    CurrentSessionEnumItemEntity(value: 2, name: 'Notice', title: 'اطلاعیه'),
    CurrentSessionEnumItemEntity(
      value: 3,
      name: 'Instruction',
      title: 'دستورالعمل',
    ),
  ];

  static const receiverTypes = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'همه کاربران'),
    CurrentSessionEnumItemEntity(value: 2, title: 'نمایندگی‌ها'),
    CurrentSessionEnumItemEntity(value: 3, title: 'امدادگران'),
  ];

  static const targetTypes = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'استان محل فعالیت'),
    CurrentSessionEnumItemEntity(value: 2, title: 'نوع مرکز خدمت‌رسانی'),
    CurrentSessionEnumItemEntity(value: 3, title: 'وضعیت همکاری'),
    CurrentSessionEnumItemEntity(value: 4, title: 'سمت سازمانی'),
  ];

  static const boundaryTypes = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'شامل می‌شود'),
    CurrentSessionEnumItemEntity(value: 2, title: 'شامل نمی‌شود'),
  ];

  static const operatorTypes = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'و'),
    CurrentSessionEnumItemEntity(value: 2, title: 'یا'),
  ];

  static const provinceCategories = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'تهران'),
    CurrentSessionEnumItemEntity(value: 2, title: 'البرز'),
    CurrentSessionEnumItemEntity(value: 3, title: 'اصفهان'),
    CurrentSessionEnumItemEntity(value: 4, title: 'فارس'),
  ];

  static const serviceCenterCategories = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 101, title: 'نمایندگی'),
    CurrentSessionEnumItemEntity(value: 102, title: 'امداد خودرو'),
    CurrentSessionEnumItemEntity(value: 103, title: 'مرکز خدمات در محل'),
  ];

  static const cooperationStatusCategories =
      <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 201, title: 'فعال'),
    CurrentSessionEnumItemEntity(value: 202, title: 'غیرفعال'),
    CurrentSessionEnumItemEntity(value: 203, title: 'تعلیق شده'),
  ];

  static const jobPositionCategories = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 301, title: 'مدیر نمایندگی'),
    CurrentSessionEnumItemEntity(value: 302, title: 'کارشناس فنی'),
    CurrentSessionEnumItemEntity(value: 303, title: 'امدادگر'),
  ];

  static const genericCategories = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'مقدار اول'),
    CurrentSessionEnumItemEntity(value: 2, title: 'مقدار دوم'),
  ];
}
