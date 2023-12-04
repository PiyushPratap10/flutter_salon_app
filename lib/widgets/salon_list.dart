import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Salon {
  final String address;
  final String distance;
  final String name;
  final String rating;
  final String reviews;
  final String imageUrl;

  Salon({
    required this.address,
    required this.distance,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });
}

class SalonList extends StatelessWidget {
  const SalonList({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSalons(),
      builder: (context, AsyncSnapshot<List<Salon>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Salon> salons = snapshot.data!;
          return Column(
            children:
                salons.map((salon) => SalonCardWidget(salon: salon)).toList(),
          );
        }
      },
    );
  }

  Future<List<Salon>> fetchSalons() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('vendors').get();

    List<Salon> salons = [];
    querySnapshot.docs.forEach((doc) {
      salons.add(Salon(
        address: doc['Address'],
        distance: doc['Distance'],
        name: doc['Name'],
        rating: doc['Rating'],
        reviews: doc['Reviews'],
        imageUrl: doc['url'],
      ));
    });

    return salons;
  }
}

class SalonCardWidget extends StatelessWidget {
  final Salon salon;

  const SalonCardWidget({super.key, required this.salon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: FadeInImage(
                  height: 120,
                  width: 100,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(salon.imageUrl),
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salon.name,
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(salon.address),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(salon.distance)
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5.0),
                      Text('${salon.rating} (${salon.reviews})'),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border_outlined))
          ],
        ),
      ),
    );
  }
}
