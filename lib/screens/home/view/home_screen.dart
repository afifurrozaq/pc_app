import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pc_app/screens/home/blocs/bloc/get_pizza_bloc.dart';
import 'package:pc_app/screens/home/view/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              'assets/8.png',
              scale: 14,
            ),
            const SizedBox(width: 8),
            const Text(
              'PIZZA',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
            builder: (context, state) {
              if (state is GetPizzaSuccess) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 9 / 16),
                    itemCount: state.pizzas.length,
                    itemBuilder: (context, int i) {
                      return Material(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                       DetailScreen(state.pizzas[i]),
                                ));
                          },
                          child: Column(
                            children: [
                              Image.network(state.pizzas[i].picture),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: state.pizzas[i].isVeg
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 4),
                                          child: Text(
                                            state.pizzas[i].isVeg
                                                ? "VEG"
                                                : "NON-VEG",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 4),
                                          child: Text(
                                            state.pizzas[i].spicy == 1
                                                ? "🌶️ BLAND"
                                                : state.pizzas[i].spicy == 2
                                                    ? "🌶️ BALANCE"
                                                    : "🌶️ SPICY",
                                            style: TextStyle(
                                                color: state.pizzas[i].spicy == 1
                                                ? Colors.green
                                                : state.pizzas[i].spicy == 2
                                                    ? Colors.orange
                                                    : Colors.redAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                               Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                 state.pizzas[i].name,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  state.pizzas[i].description,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade700),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Rp. ${state.pizzas[i].price},-",
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          Text(
                                            "Rp. ${state.pizzas[i].discount},-",
                                            style: TextStyle(
                                                fontSize: 6,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w700,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              CupertinoIcons.add_circled_solid))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (state is GetPizzaLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("An Error has accoured"),
                );
              }
            },
          )),
    );
  }
}
