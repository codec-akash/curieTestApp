import 'dart:math';

import 'package:curie_pay/bloc/bank_bloc.dart';
import 'package:curie_pay/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessScreen extends StatefulWidget {
  final String amount;
  const SuccessScreen({super.key, required this.amount});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool isSuccess = false;

  late AnimationController controller;

  Widget flipTransition(Widget child, Animation<double> animation, Key key) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (child?.key != null && child!.key == key) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY((1 - animation.value) * -pi),
            child: animation.value >= 0.5 ? child : Container(),
          );
        } else {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(pi * (1 - animation.value)),
            child: animation.value >= 0.5 ? child : Container(),
          );
        }
      },
      child: child,
    );
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    controller.repeat(min: 0.0, max: 1.0, period: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BankBloc>().add(InitiatePayment());
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        color: isLoading
            ? Colors.grey[350]
            : isSuccess
                ? Colors.blue[800]
                : Colors.red[200],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<BankBloc, BankState>(
              listener: (context, state) {
                if (state is PaymentComplete) {
                  setState(() {
                    isLoading = false;
                    isSuccess = state.isSuccess;
                  });
                  if (isSuccess == false) {}
                }
              },
              child: Container(),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 700),
              child: SizedBox(
                height: 140,
                width: 140,
                child: Center(
                  child: Stack(
                    children: [
                      if (controller != null && isLoading == true)
                        Positioned.fill(
                          child: RotationTransition(
                            turns: controller,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.blueGrey, width: 1)),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) =>
                                flipTransition(child, animation,
                                    Key(isLoading ? "loadingKey" : "finalKey")),
                            child: Image.asset(
                              isLoading
                                  ? "assets/image/awaiting_image.webp"
                                  : isSuccess == false
                                      ? "assets/image/failed_image.webp"
                                      : "assets/image/done_image.webp",
                              key: Key(isLoading ? "loadingKey" : "finalKey"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSize(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isLoading == true
                  ? Container()
                  : Column(
                      children: [
                        Text(
                          "₹ ${widget.amount} ${isSuccess ? "paid" : "failed"}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Max Life Pharma",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "mlp19230@upi",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 80),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text("Done"),
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
}
