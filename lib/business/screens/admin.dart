import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/business/db/product.dart';
import 'package:flutter_ecom/business/screens/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.amber;
  MaterialColor notActive = Colors.red;
  TextEditingController productController = TextEditingController();
  // TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _productFormKey = GlobalKey();
  // GlobalKey<FormState> _brandFormKey = GlobalKey();
  ProductService _productService = ProductService();
  //TODO add this database models
  // BrandService _brandService = BrandService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() => _selectedPage = Page.dashboard);
                },
                icon: Icon(
                  Icons.dashboard,
                  color: _selectedPage == Page.dashboard ? active : notActive,
                ),
                label: Text('Dashboard'),
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() => _selectedPage = Page.manage);
                },
                icon: Icon(
                  Icons.sort,
                  color: _selectedPage == Page.dashboard ? active : notActive,
                ),
                label: Text('Manage`'),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: [
            ListTile(
              subtitle: FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                label: Text(
                  '12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.green),
                ),
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.category),
                          label: Expanded(child: Text('Categories')),
                        ),
                        subtitle: Text(
                          '23',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.track_changes),
                          label: Expanded(child: Text('Products')),
                        ),
                        subtitle: Text(
                          '120',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.tag_faces),
                          label: Text('Sold'),
                        ),
                        subtitle: Text(
                          '13',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart),
                          label: Text('Orders'),
                        ),
                        subtitle: Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.close),
                          label: Text('Return'),
                        ),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Add Product'),
              onTap: () {
                //TODO create _productAlert()
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Log Out'),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AdminSignUp()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _productAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _productFormKey,
        child: TextFormField(
          controller: productController,
          validator: (value) {
            if (value.isEmpty) {
              return 'product cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "add product"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // if (productController.text != null) {
              //   _productService.createProduct(productController.text);
              // }
              Fluttertoast.showToast(msg: 'product created');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  } //TODO create _productAlert()
}
