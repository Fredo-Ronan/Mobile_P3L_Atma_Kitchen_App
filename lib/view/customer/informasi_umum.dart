import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/customer_client.dart';
import 'package:mobile_app_atma_kitchen/entity/customer.dart';
import 'package:mobile_app_atma_kitchen/view/customer/hampers_page.dart';
import 'package:mobile_app_atma_kitchen/view/customer/home.dart';
import 'package:mobile_app_atma_kitchen/view/customer/preorder_page.dart';
import 'package:mobile_app_atma_kitchen/view/customer/produk_ready_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformasiUmum extends StatefulWidget {
  const InformasiUmum({super.key});

  @override
  State<InformasiUmum> createState() => _InformasiUmumState();
}

class _InformasiUmumState extends State<InformasiUmum> {
  Customer customer = Customer();

  bool isLoading = false;

  void getCustomerData() async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Customer data =
          await CustomerClient.getCustomerData(prefs.getString('id_customer')!);

      setState(() {
        customer = data;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal Mengambil Data Customer!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const _BottomBar(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Text(
                    'Welcome ${customer.namaCustomer}!',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Atma Kitchen adalah toko kue yang menyediakan berbagai macam kue dengan kualitas terbaik dan harga terjangkau. Kami juga menyediakan berbagai macam kue untuk acara spesial Anda.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const SizedBox(height: 20.0),
                  const Text('Kue Terbaru',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    width: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const Image(
                            image: AssetImage('assets/images/cake-6.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const Image(
                            image: AssetImage('assets/images/cake1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const Image(
                            image: AssetImage('assets/images/cale2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Informasi Produk",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 380,
                    child: (GridView.count(
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      crossAxisCount: 2,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Go to Hampers Page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HampersPage(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.only(top: 10.0),
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/cake-3.jpg'),
                                  height: 135,
                                ),
                                Text(
                                  'Hampers',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Go to Pre order page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PreOrderPage(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.only(top: 10.0),
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/cake-2.jpg'),
                                  height: 135,
                                ),
                                Text(
                                  'Preorder',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Go to Ready Stock page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProdukReadyPage(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.only(top: 10.0),
                            child: const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/cake-4.jpg'),
                                  height: 135,
                                ),
                                Text(
                                  'Ready Stock',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Column(
                            children: [
                              Image(
                                image: AssetImage('assets/images/cake-5.jpg'),
                                height: 135,
                              ),
                              Text(
                                'Promo',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.blue,
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InformasiUmum()));
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InformasiUmum()));
            },
            icon: const Icon(
              Icons.cake,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
