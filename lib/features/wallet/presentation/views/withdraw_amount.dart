import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/money_formatter.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_dropdown_widget.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/wallet_bloc.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/withdraw_to_bank/withdraw_to_bank_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/widgets/succesful.dart';

class AddAmountPage extends StatefulWidget {
  const AddAmountPage({super.key, required this.bank, required this.number});
  final Map<String, String> bank;
  final String number;
  @override
  State<AddAmountPage> createState() => _AddAmountPageState();
}

class _AddAmountPageState extends State<AddAmountPage> {
  Map? bank;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawToBankCubit, WithdrawToBankState>(
      listener: (context, state) {
        if (state is WithdrawToBankSuccess) {
          showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) => SuccessfulWithdawWidget());
        } else if (state is WithdrawToBankError) {
          context.showSnackBar(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
          centerTitle: false,
          title: const Text("Withdraw funds"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                var balance = (state as WalletLoaded).wallet['balance'];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                          const Gap(15),
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
            CustomTextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {});
              },
              hintText: "Enter amount",
              titleText: "Amount",
            ),
          ],
        ).withSafeArea().withCustomPadding(),
        bottomNavigationBar:
            BlocBuilder<WithdrawToBankCubit, WithdrawToBankState>(
          builder: (context, state) {
            return SizedBox(
              height: 150,
              child: CustomButton(
                label: "withdraw",
                notifier: ValueNotifier(state is WithdrawToBankLoading),
                enable: _controller.text.isNotEmpty,
                onPressed: () {
                  context.read<WithdrawToBankCubit>().withdrawToBankHandler(
                        double.parse(_controller.text),
                        widget.number,
                        widget.bank['code']!,
                      );
                },
              ).toCenter(),
            );
          },
        ),
      ),
    );
  }
}
