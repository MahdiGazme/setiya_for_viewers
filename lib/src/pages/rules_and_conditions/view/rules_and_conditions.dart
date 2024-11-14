import 'package:flutter/material.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../infrastructures/utils/utils.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';

class RulesAndConditions extends StatelessWidget {
  const RulesAndConditions({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  ScaffoldBodyContainer _body(final BuildContext context) =>
      ScaffoldBodyContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _setiyaLogo(),
              Utils.mediumVerticalSpacer,
              _setiyaTitle(context),
              Utils.giantVerticalSpacer,
              _document()
            ],
          ),
        ),
      );

  Card _document() => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mainTitle(),
              Utils.largeVerticalSpacer,
              _mainDescription(),
              Utils.mediumVerticalSpacer,
              _agreement(),
              Utils.largeVerticalSpacer,
              _conditionsOfUsing(),
              Utils.mediumVerticalSpacer,
              memberOfSetiya(),
              Utils.mediumVerticalSpacer,
              _ageLimit(),
              Utils.mediumVerticalSpacer,
              _moders(),
              Utils.largeVerticalSpacer,
              _personalInformation(),
              Utils.mediumVerticalSpacer,
              _personalInformationSharingInformation(),
              Utils.mediumVerticalSpacer,
              _personalInformationSharingWithManager(),
              Utils.largeVerticalSpacer,
              _personalInformationTypes(),
              Utils.mediumVerticalSpacer,
              _name(),
              Utils.mediumVerticalSpacer,
              _nationalCode(),
              Utils.mediumVerticalSpacer,
              _mobile(),
              Utils.mediumVerticalSpacer,
              _birthday(),
              Utils.mediumVerticalSpacer,
              _marriage(),
              Utils.mediumVerticalSpacer,
              _fatherName(),
              Utils.mediumVerticalSpacer,
              _motherName(),
              Utils.mediumVerticalSpacer,
              _fatherJob(),
              Utils.mediumVerticalSpacer,
              _motherMobile(),
              Utils.mediumVerticalSpacer,
              _children(),
              Utils.mediumVerticalSpacer,
              _address(),
              Utils.mediumVerticalSpacer,
              _telephone(),
              Utils.largeVerticalSpacer,
              _acount(),
              Utils.mediumVerticalSpacer,
              _authorize(),
              Utils.mediumVerticalSpacer,
              _usernameAndPass(),
              Utils.largeVerticalSpacer,
              _documentChanges(),
              Utils.mediumVerticalSpacer,
              _changeDescription(),
              Utils.mediumVerticalSpacer,
              _ownership(),
              Utils.mediumVerticalSpacer,
              _ownershipDescription(),
              Utils.mediumVerticalSpacer,
              _milkyLogo(),
            ],
          ),
        ),
      );

  Align _milkyLogo() => Align(
        alignment: AlignmentDirectional.center,
        child: Image.asset(
          'lib/assets/images/milky_logo.png',
          package: 'setia_module',
          color: CustomMilkyTheme.accentColor,
          width: 250,
        ),
      );

  Text _ownershipDescription() => const Text(
        'مالکیت این برنامه متعلق به آقای محمد مهدی گزمه و '
        'تیم توسعه نرم افزار MiLKyV و در اجاره دائم '
        'ستیا می باشد. هر گونه کپی'
        ' برداری و استفاده از کد منبع و تلاش برای آسیب '
        'رسانی، نفوذ، سرقت اطلاعات، استفاده غیر قانونی '
        'و مجرمانه از این برنامه پیگرد قانونی دارد.',
      );

  Text _ownership() => const Text(
        'مالکیت نرم افزار',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _changeDescription() => const Text(
        'مطالب ذکر شده در این سند دائمی نیستند و ممکن است '
        'با تغییر سیاست ستیا دستخوش تغییر و تجدید '
        'نظر باشند.',
      );

  Text _documentChanges() => const Text(
        'تغییرات این سند',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _usernameAndPass() => const Text(
        'این برنامه ممکن است نام کاربری و کلمه عبور'
        ' شما را برای تجربه کاربری بهتر ذخیره و استفاده'
        ' نماید.',
      );

  Text _authorize() => const Text(
        'برای ساخت حساب کاربری و استفاده از امکانات این '
        'برنامه لازم است که فرآیند احراز هویت خود را '
        'تکمیل کنید.',
      );

  Text _acount() => const Text(
        'حساب کاربری',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _telephone() => const Text(
        '۱۲. تلفن محل سکونت',
      );

  Text _address() => const Text(
        '۱۱. آدرس',
      );

  Text _children() => const Text(
        '۱۰. اطلاعات فرزندان',
      );

  Text _motherMobile() => const Text(
        '۹. تلفن مادر',
      );

  Text _fatherJob() => const Text(
        '۸. شغل پدر',
      );

  Text _motherName() => const Text(
        '۷. نام مادر',
      );

  Text _fatherName() => const Text(
        '۶. نام پدر',
      );

  Text _marriage() => const Text(
        '۵. وضعیت تاهل',
      );

  Text _birthday() => const Text(
        '۴. تاریخ تولد',
      );

  Text _mobile() => const Text(
        '۳. شماره همراه',
      );

  Text _nationalCode() => const Text(
        '۲. کد ملی',
      );

  Text _name() => const Text(
        '۱. نام و نام خانوادگی',
      );

  Text _personalInformationTypes() => const Text(
        'اطلاعات شخصی شما شامل موارد زیر می باشد',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _personalInformationSharingWithManager() => const Text(
        'اطلاعات شما فقط با مدیر و کادر منتخب مدیر '
        'به اشتراک گذاشته می شود.',
      );

  Text _personalInformationSharingInformation() => const Text(
        'این برنامه از اطلاعات شخصی شما برای '
        'کمک به کادر مدیریتی ستیا و مدیریت بهتر این '
        'مجموعه استفاده می کند. '
        'ستیا موظف به حفظ و نگهداری و عدم افشای اطلاعات '
        'شما برای افراد ثالث می باشد.\n',
      );

  Text _personalInformation() => const Text(
        'اطلاعات شخصی کاربران',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _moders() => const Text(
        'مادران: در صورتی که به عنوان مادر از این برنامه '
        'استفاده می کنید، فرزند شما باید از قبل در '
        'این برنامه احراز هویت شده باشد.',
      );

  Text _ageLimit() => const Text(
        'محدودیت سنی اعضا: برای استفاده از امکانات این برنامه '
        'تاریخ تولد شما باید بعد از سال ۱۳۸۰ شمسی باشد '
        '، در غیر این صورت فقط با هماهنگی'
        ' مدیر ستیا از برنامه استفاده کنید.',
      );

  Text memberOfSetiya() => const Text(
        'عضویت در ستیا: این برنامه مخصوص مدیران، اعضا و '
        'مادران اعضای ستیا است، در صورتی که شما شامل '
        'گروه '
        'های ذکر شده نیستید از این برنامه استفاده نکنید.',
      );

  Text _conditionsOfUsing() => const Text(
        'شرایط لازم',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _agreement() => const Text(
        'استفاده از این نرم افزار به معنی موافقت شما با '
        'این شرایط و قوانین است. برای '
        'آشنایی '
        'با شرایط و قوانین لطفا متن را مطالعه کنید.',
      );

  Text _mainDescription() => const Text(
        'متن پیش رو توضیحاتی از شرایط و قوانین استفاده '
        'از برنامه ستبا متعلق به تشکل دخترانه ستیا '
        'مرودشت که از این پس با نام ستیا یاد میشود است.',
      );

  Text _mainTitle() => const Text(
        'شرایط و قوانین استفاده از خدمات ستیا',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Text _setiyaTitle(final BuildContext context) => Text(
        'تشکل دخترانه ستیا مرودشت',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: CustomMilkyTheme.primaryColor,
            ),
      );

  Image _setiyaLogo() => Image.asset(
        'lib/assets/images/logo_secondary.png',
        package: 'setia_module',
        color: CustomMilkyTheme.primaryColor,
        width: 170,
      );

  SecondaryAppBar _appBar() => const SecondaryAppBar(
        title: Text('شرایط و قوانین'),
      );
}
