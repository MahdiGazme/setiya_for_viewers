import 'package:flutter/material.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/dialogs/setiya_alert_dialog.dart';

class DeveloperNoteDialog extends StatelessWidget {
  const DeveloperNoteDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        surfaceTintColor: CustomMilkyTheme.secondaryColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _inTheNameOfGod(context),
            Utils.mediumVerticalSpacer,
            _quran(context),
            Utils.largeVerticalSpacer,
            _milkyLogo(),
            Utils.largeVerticalSpacer,
            _note(context),
            Utils.mediumVerticalSpacer,
            _nameAndDate()
          ],
        ),
      );

  Widget _nameAndDate() => const Text('محمد مهدی گزمه ۸/خرداد/۱۴۰۲');

  Widget _note(final BuildContext context) => Expanded(
        child: DecoratedBox(
          decoration: _noteDecoration(),
          child: Padding(
            padding: Utils.smallPadding,
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      child: _noteText(),
                    ),
                    Utils.mediumVerticalSpacer,
                    _hafez(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  BoxDecoration _noteDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _noteText() => const Text(
        'اول از همه خدارو شکر میکنم که من رو به اینجا'
        ' رسوند و با اینکه فکرش رو هم نمیکردم که روزی موفق'
        ' بشم الآن اینجا هستم.\n'
        ' و شکر گزار رحمت بی کرانش هستم ما قادر'
        ' به انتخاب رویا هامون نیستیم، اونا فقط اتفاق میوفتن'
        ' و یه زمان متوجه میشیم که کل خواسته ما هستن، بزرگی'
        ' میگفت که رویا دال بر تواناییست پس رویایی به وجود'
        ' نمیاد که انسان از انجام آن ناتوان '
        'باشد، زمانی که درک این مساله اتفاق افتاد دیدگاه ما '
        'نسبت به خواسته هامون عوض میشه و دیگه فقط یه خواسته '
        'نیستن بلکه به یک فرصت تبديل می شن و کسانی که فرصت رو '
        'جدی میگیرن و اون رو تبديل به هدف میکنند برد واقعي رو بدست '
        'آوردند و برا همشه زندگی جدیدی رو تجربه خواهند کرد.'
        ' برای من ۳ سال پیش اتفاق افتاد، و با تمام زیبایی '
        'هاش من رو به اینحا رسوند ولی چند مدت اخیر به '
        'خاطر اشتباهات خودم و اتفاقاتی که افتاد '
        'من از مسیر فاصله گرفتم و بعضی از فرصت ها رو سوزوندم،'
        ' تمام نلاشم رو میکنم که بتونم دوباره فرصت هام رو بدست '
        'بیارم و توی مسیر رویاهام قدم بردارم، ولی این بدون'
        ' لطف و راهنمایی و کمک خدا ممکن نیست و من بدون اون '
        'هیچ کاری نمتونم بکنم، پس همینجا از خدای عزیزم میخوام '
        'که من رو به مسیرم برگردونه و این شرایط فعلی و گذر '
        'ازش رو برام ساده کنه و مثل همیشه که من رو راهنمایی '
        'کرده بازهم من رو مورد لطف خودش قرار بده و همراهی کنه',
      );

  Widget _inTheNameOfGod(final BuildContext context) => Text(
        'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
        style: Theme.of(context).textTheme.titleLarge,
      );

  Widget _quran(final BuildContext context) => Text(
        'وَالضُّحَى﴿۱﴾ وَاللَّيْلِ إِذَا سَجَى﴿۲﴾ مَا وَدَّعَكَ رَبُّكَ وَمَا قَلَى﴿۳﴾',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      );

  Widget _milkyLogo() => Image.asset(
        'lib/assets/images/milky_logo.png',
        fit: BoxFit.fitWidth,
        package: 'setia_module',
        width: 230,
        color: CustomMilkyTheme.accentColor,
      );

  Widget _hafez(final BuildContext context) => Column(
        children: [
          _firstBeyt(context),
          Utils.smallVerticalSpacer,
          _secondBeyt(context),
          Utils.smallVerticalSpacer,
          _thirdBeyt(context),
        ],
      );

  Widget _thirdBeyt(final BuildContext context) => Text(
        'نذر کردم گر از این غم به درآیم روزی\nتا درِ میکده شادان و غزل‌خوان بروم',
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      );

  Widget _secondBeyt(final BuildContext context) => Text(
        'چون صبا با تنِ بیمار و دلِ بی‌طاقت\nبه هواداریِ آن سروِ خرامان بروم',
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      );

  Widget _firstBeyt(final BuildContext context) => Text(
        'خُرَّم آن روز کز این منزلِ ویران بروم\nراحتِ جان طلبم و از پِیِ جانان بروم',
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      );
}
