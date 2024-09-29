import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/money_formatter.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank_transactions/get_bank_transactions_cubit.dart';
import '../blocs/wallet_bloc.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<WalletBloc>().state is WalletLoaded ||
        context.read<WalletBloc>().state is WalletLoading) {
    } else {
      context.read<WalletBloc>().add(FetchWalletDetailsEvent());
    }
    if (context.read<GetBankTransactionsCubit>().state
            is GetBankTransactionsLoaded ||
        context.read<GetBankTransactionsCubit>().state
            is GetBankTransactionsLoading) {
    } else {
      context.read<GetBankTransactionsCubit>().fetchBankTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Wallet',
          style: context.textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state is WalletLoaded) {
                var wallet = state.wallet;
                return Container(
                  width: context.screenWidth * .9,
                  height: 188,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF9F71DB),
                        Color(0xFFC5AAE9),
                      ],
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Assets.application.assets.svgs.walletBg.svg(),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${Constants.Naira} ${MoneyFormatter.doubleToMoney(wallet['balance'])}",
                                    style: context.textTheme.displayMedium
                                        ?.copyWith(
                                      color: context.colors.white,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: context.colors.borderGrey
                                        .withOpacity(.3),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.visibility_off,
                                        color: context.colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  CustomButton(
                                    color: context.colors.borderGrey
                                        .withOpacity(.3),
                                    label: "",
                                    onPressed: () {
                                      context.goNamed(Routes.addFundName);
                                    },
                                    titleWidget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add,
                                            color: context.colors.white),
                                        Text(
                                          "Add funds",
                                          style: context.textTheme.labelLarge
                                              ?.copyWith(
                                                  color: context.colors.white),
                                        )
                                      ],
                                    ),
                                  ).withExpanded(),
                                  Gap(20),
                                  CustomButton(
                                    label: "",
                                    color: context.colors.borderGrey
                                        .withOpacity(.2),
                                    onPressed: () {
                                      context.goNamed(Routes.withdrawName);
                                    },
                                    titleWidget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_outward_rounded,
                                            color: context.colors.white),
                                        Text(
                                          "Withdraw",
                                          style: context.textTheme.labelLarge
                                              ?.copyWith(
                                                  color: context.colors.white),
                                        )
                                      ],
                                    ),
                                  ).withExpanded(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          Gap(20),
          Row(
            children: [
              Text(
                'Transactions',
                style: context.textTheme.displayMedium,
              )
            ],
          ),
          BlocBuilder<GetBankTransactionsCubit, GetBankTransactionsState>(
            builder: (context, state) {
              if (state is GetBankTransactionsLoaded) {
                // return
              } else if (state is GetBankTransactionsEmpty) {
                return Column(
                  children: [
                    const Icon(
                      Icons.not_interested_rounded,
                      size: 40,
                    ),
                    const Gap(20),
                    Text(state.message)
                  ],
                );
              }
              return Container();
            },
          )
        ],
      ).withSafeArea().withCustomPadding(),
    );
  }
}
