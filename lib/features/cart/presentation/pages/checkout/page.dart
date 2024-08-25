import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

part 'sections/summary_section.dart';
part 'sections/item_section.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/cart/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is CheckoutFailure) {
          EasyLoading.showError(state.failure.message);
        } else if (state is CheckoutSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
            context,
            SuccessCheckoutPage.routeName,
            (route) => false,
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, cart) {
          return Scaffold(
            appBar: AppBar(title: const Text('Checkout Details')),
            body: ListView(
              padding: const EdgeInsets.all(Dimens.dp16),
              children: [
                _ItemSection(key: widget.key, carts: cart.carts),
                Dimens.dp16.height,
                RegularInput(
                  controller: addressController,
                  prefixIcon: Icons.location_on_rounded,
                  label: 'Address Details',
                  hintText: 'Your Address',
                  onChange: (v) {
                    setState(() {});
                  },
                ),
                Dimens.dp32.height,
                _SummarySection(key: widget.key),
                Dimens.dp32.height,
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(Dimens.dp16),
              child: ElevatedButton(
                onPressed: addressController.text.isNotEmpty
                    ? () {
                        context.read<CheckoutBloc>().add(
                              CreateCheckoutEvent(
                                  addressController.text, cart.total),
                            );
                      }
                    : null,
                child: const Text('Checkout Now'),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
