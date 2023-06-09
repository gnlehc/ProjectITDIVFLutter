import 'package:flutter/material.dart';
import 'package:trainingassignment/fetch/model.dart';
import 'package:trainingassignment/fetch/product.dart';
import 'package:trainingassignment/footer.dart';
import '../navbar.dart';
import 'product_cart.dart';

class Home extends StatefulWidget {
  late String username = "";
  Home({Key? key, this.username = ""}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _HomeState extends State<Home> {
  late String username = "";
  List<Products> listProd = [];
  Product product = Product();
  bool isLoading = true;

  Future<void> getProd() async {
    listProd = await product.getProduct();
    setState(() {
      listProd = listProd;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProd();
    super.initState();
  }

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments == null
        ? ScreenArguments()
        : ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    if (args.username.isNotEmpty) username = args.username;
    print("username $username");
    return Material(
      child: Scaffold(
        backgroundColor: const Color(0xf1f1f1f1),
        appBar: PreferredSize(
          preferredSize: const Size(100, 50),
          child: Navbar(
            username: username,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              // padding: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        color: Colors.green),
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "30% OFF - Ramadhan Sale",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: Colors.green),
                    alignment: Alignment.topCenter,
                    // margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "*Promotion is valid for regular-priced items, except for special collections.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: Colors.green,
                    ),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 40, right: 40),
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "All Products",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  isLoading
                      ? LoadingIndicator()
                      : Container(
                          child: const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "20 Result",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final product = listProd[index];
                      return ProductCard(
                        product: product,
                      );
                    },
                    itemCount: listProd.length,
                  ),
                  Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
