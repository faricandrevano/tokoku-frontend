part of '../page.dart';

class _FlexibleSpace extends StatefulWidget {
  const _FlexibleSpace({super.key});

  @override
  State<_FlexibleSpace> createState() => _FlexibleSpaceState();
}

class _FlexibleSpaceState extends State<_FlexibleSpace> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        return FlexibleSpaceBar(
          centerTitle: true,
          expandedTitleScale: 1,
          background: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: Dimens.height(context) / 2.6,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                context
                    .read<DetailProductBloc>()
                    .add(ChangeIndexDetailProductEvent(index));
              },
            ),
            items: (state.product?.galleries ?? []).map(
              (i) {
                return SmartNetworkImage(
                  i,
                  width: Dimens.width(context),
                  height: Dimens.height(context) / 2.6,
                  fit: BoxFit.cover,
                  radius: BorderRadius.zero,
                );
              },
            ).toList(),
          ),
          title: Column(
            children: [
              Dimens.dp32.height,
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, theme) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: theme.theme == AppTheme.dark
                              ? context.theme.scaffoldBackgroundColor
                              : null,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, CartPage.routeName);
                        },
                        icon: Icon(
                          Icons.shopping_bag_rounded,
                          color: theme.theme == AppTheme.dark
                              ? context.theme.scaffoldBackgroundColor
                              : null,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              if (state.product != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.product!.galleries
                      .asMap()
                      .entries
                      .map(
                        (e) => Container(
                          width:
                              state.index == e.key ? Dimens.dp16 : Dimens.dp4,
                          height: Dimens.dp4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimens.dp2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.dp4),
                            color: state.index == e.key
                                ? context.theme.primaryColor
                                : context.theme.disabledColor,
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}
