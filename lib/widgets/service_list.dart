import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Services {
  final String name;
  final String low;
  final String high;
  final String url;

  Services({
    required this.name,
    required this.low,
    required this.high,
    required this.url,
  });
}

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getServices(),
      builder: (context, AsyncSnapshot<List<Services>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Services> services = snapshot.data!;
          return Row(
            children: services
                .map((service) => ServicesCardList(service: service))
                .toList(),
          );
        }
      },
    );
  }

  Future<List<Services>> getServices() async {
    QuerySnapshot<Map<String, dynamic>> querySnap =
        await FirebaseFirestore.instance.collection('services').get();

    List<Services> services = [];
    querySnap.docs.forEach((element) {
      services.add(Services(
          name: element['Name'],
          low: element['Low'],
          high: element['High'],
          url: element['Url']));
    });
    return services;
  }
}

class ServicesCardList extends StatelessWidget {
  const ServicesCardList({super.key, required this.service});
  final Services service;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              height: 160,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(service.url), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              service.name,
              softWrap: true,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.low,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  service.high,
                  style: const TextStyle(
                      color: Colors.black12,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
