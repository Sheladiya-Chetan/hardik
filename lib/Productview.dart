import 'package:apiloginproject/payment.dart';
import 'package:apiloginproject/photoview.dart';
import 'package:apiloginproject/viewproduct.dart';
import 'package:flutter/material.dart';

class productviewpage extends StatefulWidget {
  Productdata productdata;

  productviewpage(this.productdata);

  @override
  State<productviewpage> createState() => _productviewpageState();
}

class _productviewpageState extends State<productviewpage> {
  bool maxlines = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("product page"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Column(children: [
                      InkWell(onTap: () {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return photoview(widget.productdata.proimage);
                        },));
                      },
                        child: Container(
                          height: size.height * 0.4,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://chetansheladiya.000webhostapp.com/apicalling/"
                                      "${widget.productdata.proimage}"))),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,

                              ),IconButton(onPressed: () {

                              }, icon: Icon(Icons.share))
                            ],
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "  ${widget.productdata.productname}",
                              style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rs..${widget.productdata.productprice}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "About product :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(children: [
                                    Text(
                                      "${widget.productdata.desctription}",
                                      maxLines: maxlines ? 4 : null,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (maxlines) {
                                                maxlines = false;
                                              } else {
                                                maxlines = true;
                                              }
                                            });
                                          },
                                          child: Text(
                                            maxlines ? "more ..." : "less ...",
                                          )),
                                    )
                                  ]),
                                ),
                                Text(
                                  "Product Description :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ID\t\t\t\t\t:\t\t\t\t\t\t${widget.productdata.id}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Name\t\t:\t\t\t${widget.productdata.productname}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Price\t\t:\t\t\t${widget.productdata.productprice}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Product Description\t\t:\t\t\t${widget.productdata.desctription}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),

                  ],
                ),
              ),
            ), Row(
              children: [
                Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink,
                            offset: Offset(3.0, 3.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )),
                SizedBox(width: 8),
                Expanded(
                    child: InkWell(onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return payment();
                      },));
                    },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green,
                              offset: Offset(3.0, 3.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Buy Now",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ));
  }
}
