import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        centerTitle: false,
        title: Text("Add Funds"),
      ),
      body: SizedBox(
        height: context.screenHeight * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(10),
            CircleAvatar(
                radius: 30,
                backgroundColor: context.secondaryColor,
                child: Icon(
                  Icons.house,
                  color: context.primaryColor,
                  size: 30,
                )),
            Text(
              "Wallet Account Number",
              style: context.textTheme.displayMedium,
            ),
            const Text(
              "Make a transfer to this account number and your wallet will be funded.",
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank Name"),
                  Text(
                    "GT Bank",
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account number"),
                      Text(
                        "07728468590",
                        style: context.textTheme.displaySmall,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.copy,
                        color: context.primaryColor,
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account name"),
                  Text(
                    "SoundMind inc",
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ],
        ).withSafeArea().withCustomPadding(),
      ),
    );
  }
}
