import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

part 'sections/product_section.dart';
part 'sections/empty_section.dart';
part 'sections/skeleton_section.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String routeName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(const GetCartsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Your Cart')),
          body: state.status == CartStateStatus.success
              ? (state.carts.isEmpty
                  ? _EmptySection(key: widget.key)
                  : ListView.separated(
                      padding: const EdgeInsets.all(Dimens.dp16),
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.dp16,
                          vertical: Dimens.dp10,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(Dimens.dp16),
                        ),
                        child: Column(
                          children: [
                            _ProductSection(
                              key: widget.key,
                              cart: state.carts[index],
                            ),
                            Dimens.dp12.height,
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(
                                      DeleteCartEvent(state.carts[index].id),
                                    );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 16,
                                    color: context.theme.colorScheme.error,
                                  ),
                                  RegularText(
                                    'Remove',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.theme.colorScheme.error,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => Dimens.dp16.height,
                      itemCount: state.carts.length,
                    ))
              : _SkeletonSection(key: widget.key),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(Dimens.dp16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RegularText('Subtotal'),
                    SubTitleText(
                      state.total.toIDR(),
                      style: TextStyle(color: context.theme.primaryColor),
                    ),
                  ],
                ),
                Dimens.dp32.height,
                ElevatedButton(
                  onPressed: state.total == 0
                      ? null
                      : () {
                          Navigator.pushNamed(context, CheckoutPage.routeName);
                        },
                  child: const Text('Continue to Checkout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
