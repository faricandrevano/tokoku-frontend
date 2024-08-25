import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';
import 'package:shamo_mobile/features/home/home.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> pages = [
    const HomePage(),
    const ChatPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    context
      ..read<CategoryBloc>().add(GetCategoryEvent())
      ..read<ProductBloc>().add(GetPopularProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, int>(
      builder: (context, index) {
        return Scaffold(
          body: pages[index],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, CartPage.routeName);
            },
            child: const Icon(Icons.shopping_bag_rounded),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimens.dp16),
            ),
            child: BottomAppBar(
              notchMargin: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: BottomNavigationBar(
                currentIndex: index,
                onTap: (v) {
                  context.read<BottomNavBloc>().add(BottomNavChanged(v));
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_rounded),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
