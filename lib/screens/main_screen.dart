import 'package:flutter/material.dart';
import 'package:salon_app/resources/category.dart';
import 'package:salon_app/widgets/filters_list.dart';
import 'package:salon_app/widgets/salon_list.dart';
import 'package:salon_app/widgets/secondary_card.dart';
import 'package:salon_app/widgets/service_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  final List<String> _filterList = [
    "All",
    "Haircuts",
    "Make up",
    "Manicure",
    "Beard Trimming"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.account_circle,
          size: 40,
        ),
        title: const Column(
          children: [
            Text(
              "Good Morning!",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color.fromARGB(255, 61, 55, 55),
                size: 30,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.bookmark_border_outlined,
                color: Color.fromARGB(255, 61, 55, 55),
                size: 30,
              ),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 40,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                Text(
                  'Search',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert_outlined,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(214, 0, 0, 0),
                  image: const DecorationImage(
                      opacity: 0.5,
                      image: AssetImage('assets/images/banner1.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                left: 25,
                top: 50,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child: const Text(
                          "30% Off",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Today's Special",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Get a discount on every order!',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text('Only valid for today!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Featured Services',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5,),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ServicesList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'category');
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 21, 48),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 25, 21, 48),
                    ),
                  ))
            ],
          ),
          Container(
            height: 220,
            child: FutureBuilder<List<Category>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Category> categories = snapshot.data!;
                  List<Category> displayedCategories =
                      categories.take(6).toList();
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 20.0,
                      children: displayedCategories.map((category) {
                        return SecondaryCategoryCard(
                          title: category.title,
                          imageUrl: category.imageUrl,
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Most Popular Services',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Filters(
              filters: _filterList,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SalonList(),
        ]),
      ),
    );
  }
}
