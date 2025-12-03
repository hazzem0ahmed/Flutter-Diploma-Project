import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';
import 'package:movies/presentation/widgets/language/language_vm.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageViewModel, LocalizationState>(
      builder: (context, state) {
        return AnimatedToggleSwitch<String>.rolling(
          current: state.locale.languageCode,
          values: const ['en', 'ar'],
          onChanged: (value) {
            context
                .read<LanguageViewModel>()
                .add(ChangeLanguageEvent(Locale(value)));
          },
          indicatorIconScale: 1.5,
          padding: EdgeInsets.zero,
          borderWidth: 1,
          style: ToggleStyle(
            indicatorColor: AppColors.yellow,
            backgroundColor: AppColors.black,
            borderColor: AppColors.yellow,
          ),
          indicatorSize: const Size.fromWidth(50),
          iconBuilder: (value, selected) {
            if (value == 'en') {
              return Image.asset(AppAsset.americaImage);
            } else {
              return Image.asset(AppAsset.egyptImage);
            }
          },
        );
      },
    );
  }
}
