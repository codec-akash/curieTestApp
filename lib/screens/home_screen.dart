import 'package:curie_pay/bloc/bank_bloc.dart';
import 'package:curie_pay/model/bank.dart';
import 'package:curie_pay/utils/path.dart';
import 'package:curie_pay/widgets/payment_card.dart';
import 'package:curie_pay/widgets/profile_card.dart';
import 'package:curie_pay/widgets/ringing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  late AnimationController ringingController;

  @override
  void initState() {
    _amountController.addListener(() {
      setState(() {});
    });
    ringingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ProfileIcon(),
                      SizedBox(width: 5),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      ProfileIcon(
                        iconPath: UriPath.redBusPath,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "payment to red Bus",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "(redbus@axis)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  RingingAnimator(
                    animation: ringingController,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₹",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: IntrinsicWidth(
                            child: TextFormField(
                              controller: _amountController,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "0",
                                hintStyle: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.white38),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Payment via Billdesk",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(flex: 2),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        PaymentCard(
                          amount: _amountController.text,
                          animationController: ringingController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    ringingController.dispose();
    super.dispose();
  }
}
