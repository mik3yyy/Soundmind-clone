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
import 'package:sound_mind/core/widgets/custom_shimmer.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank_transactions/get_bank_transactions_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';
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
    return BlocListener<TopUpCubit, TopUpState>(
      listener: (context, state) {
        if (state is TopUpConfirmed) {
          context.read<WalletBloc>().add(FetchWalletDetailsEvent());
          context.read<GetBankTransactionsCubit>().fetchBankTransactions();
        }
        // TODO: implement listener
      },
      child: Scaffold(
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

                  // Retrieve the token (this function could get the token from secure storage or elsewhere)
                  final box = Hive.box(
                      'userBox'); // Replace 'authBox' with your box name

                  // Retrieve the token from Hive using the 'token' key
                  var hide = box.get('hide', defaultValue: false);

                  bool isHidden = hide ?? false;
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
                            child:
                                Assets.application.assets.svgs.walletBg.svg(),
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
                                      "${Constants.Naira} ${isHidden ? "********" : MoneyFormatter.doubleToMoney(wallet['balance'])}",
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
                                        onPressed: () {
                                          setState(() {
                                            isHidden = !isHidden;
                                          });

                                          box.put('hide', isHidden);
                                        },
                                        icon: Icon(
                                          isHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
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
                                                    color:
                                                        context.colors.white),
                                          )
                                        ],
                                      ),
                                    ).withExpanded(),
                                    const Gap(20),
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
                                                    color:
                                                        context.colors.white),
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
                } else if (state is WalletLoading) {
                  return ComplexShimmer.cardShimmer(
                      itemCount: 1, useTitle: false);
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
                  print(state.transactions);
                  List<Map<String, dynamic>> transactions = state.transactions
                      .where((e) => e['status'] == 1)
                      .toList();
                  return ListView.builder(
                    // physics: Al(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> transaction = transactions[index];
                      bool isCredit = transaction['transactionType'] == 1;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(transaction['purpose']),
                        leading: CircleAvatar(
                          backgroundColor: isCredit
                              ? context.colors.green.withOpacity(0.4)
                              : context.colors.red.withOpacity(0.4),
                          // radius: 20,
                          child: isCredit
                              ? Assets.application.assets.svgs.creditArrow.svg()
                              : Assets.application.assets.svgs.debitArrow.svg(),
                        ),
                        trailing: Text(
                          "${isCredit ? "+" : "-"}${Constants.Naira}${transaction['amount']}",
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: isCredit
                                  ? context.colors.green
                                  : context.colors.red),
                        ),
                      );
                    },
                  ).withExpanded();
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
                } else if (state is GetBankTransactionsLoading) {
                  return ComplexShimmer.listShimmer(itemCount: 7)
                      .withExpanded();
                }
                return Container();
              },
            )
          ],
        ).withSafeArea().withCustomPadding(),
      ),
    );
  }
}
