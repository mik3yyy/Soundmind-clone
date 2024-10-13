import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/money_formatter.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_dropdown_widget.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/resolve_bank_account/resolve_bank_account_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/wallet_bloc.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<GetBanksCubit>().state is GetBanksLoaded) {
    } else {
      context.read<GetBanksCubit>().fetchBanks();
    }
  }

  check() {
    if (bank != null && _controller.text.isNotEmpty) {
      if (_controller.text.length == 10) {
        context
            .read<ResolveBankAccountCubit>()
            .resolveAccount(_controller.text, bank!['code']!);
      }
    }
  }

  Map<String, String>? bank;

  TextEditingController _controller = TextEditingController();
  Map<String, String> convertMapToString(Map<dynamic, dynamic> originalMap) {
    return originalMap
        .map((key, value) => MapEntry(key.toString(), value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
          centerTitle: false,
          title: Text("Withdraw funds"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                var balance = (state as WalletLoaded).wallet['balance'];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  height: 100,
                  width: context.screenWidth * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "SoundMind Inc",
                            style: context.textTheme.bodyLarge
                                ?.copyWith(color: context.colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: context.screenWidth * .3,
                            child: AutoSizeText(
                              "Available Balance",
                              style: context.textTheme.displayMedium
                                  ?.copyWith(color: context.colors.white),
                              maxLines: 1,
                              minFontSize: 5,
                              maxFontSize: 18,
                            ),
                          ),
                          Gap(15),
                          SizedBox(
                            width: context.screenWidth * .3,
                            child: AutoSizeText(
                              "${Constants.Naira}${MoneyFormatter.doubleToMoney(balance)}",
                              style: context.textTheme.displayMedium
                                  ?.copyWith(color: context.colors.white),
                              maxLines: 1,
                              minFontSize: 3,
                              maxFontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Gap(20),
            Text(
              "Enter the account details to withdraw funds to",
              style: context.textTheme.labelLarge?.copyWith(fontSize: 16),
            ),
            const Gap(10),
            BlocBuilder<GetBanksCubit, GetBanksState>(
              builder: (context, state) {
                if (state is GetBanksLoaded) {
                  return CustomDropdown(
                    items: state.banks.map((e) => e['name']).toList(),
                    hintText: "Select Bank",
                    title: "Bank",
                    useSearch: true,
                    itemToString: (value) => value,
                    onChanged: (value) {
                      setState(() {
                        bank = convertMapToString(
                            state.banks.where((e) => e['name'] == value).first);
                      });
                      check();
                      print(bank);
                    },
                  );
                } else {
                  return CustomDropdown(
                    items: [],
                    // useSearch: true,
                    hintText: "Select Bank",
                    title: "Bank",
                    itemToString: (value) => value,
                    onChanged: (value) {},
                  );
                }
              },
            ),
            const Gap(10),
            CustomTextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {});
                check();
              },
              hintText: "Enter your account number",
              titleText: "Account number",
            ),
            const Gap(10),
            BlocBuilder<ResolveBankAccountCubit, ResolveBankAccountState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: context.secondaryColor,
                      ),
                      child: Text(
                        (state is ResolveBankAccountSuccess)
                            ? state.accountDetails['accountName']
                            : (state is ResolveBankAccountError)
                                ? state.message
                                : "Account name shows up here",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                    const Gap(10),
                    if (state is ResolveBankAccountLoading) ...[
                      const CircularProgressIndicator()
                    ]
                  ],
                );
              },
            )
          ],
        ).withSafeArea().withCustomPadding(),
        bottomNavigationBar: SizedBox(
          height: 150,
          child: CustomButton(
            label: "withdraw",
            enable: bank != null &&
                _controller.text.isNotEmpty &&
                _controller.text.length == 10,
            onPressed: () {
              context.goNamed(
                Routes.add_amountName,
                extra: _controller.text,
                queryParameters: bank!,
              );
            },
          ).toCenter(),
        ),
      );
    });
  }
}
