import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_rich_with_me/apis/exchange_rate_api.dart';
import 'package:get_rich_with_me/models/exchange_rate.dart';
import 'package:google_fonts/google_fonts.dart';

final exchangeRateNotifier = Provider((ref) => ExchangeRateAPI());
final responseProvider = FutureProvider<ExchangeRate>((ref) async {
  final httpClient = ref.read(exchangeRateNotifier);
  return httpClient.getExchangeRate("BTC");
});

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("build scaffold");
    return Scaffold(
      backgroundColor: Color(0xFF00000),
      appBar: appBar(),
      body: buildBody(),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "WALLET",
        style: GoogleFonts.josefinSans(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: null,
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14),
          buildCard(),
          SizedBox(height: 14),
          titleAndRefreshWidget(),
          SizedBox(height: 14),
          Consumer(builder: (context, watch, child) {
            final responseAsync = watch(responseProvider);
            return responseAsync.map(
              data: (data) {
                return Expanded(
                  child: ListView(
                    children: [
                      buildContainer(
                        "assets/images/Bitcoin.svg",
                        data.value.rate,
                        data.value.lastRefreshed,
                      )
                    ],
                  ),
                );
              },
              loading: (_) => Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white10,
                ),
              ),
              error: (e) => Text(e.error),
            );
          }),
        ],
      ),
    );
  }

  Widget buildCard() {
    return Material(
      elevation: 6,
      color: Colors.transparent,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$5 430.60",
              style: GoogleFonts.josefinSans(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.black87,
                  ),
                  Text(
                    " \$128.30 (34.2%) ",
                    style: GoogleFonts.josefinSans(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    size: 18,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleAndRefreshWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Crypto Currency Today",
          style: GoogleFonts.josefinSans(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.white70),
          onPressed: () {},
        )
      ],
    );
  }

  Widget buildContainer(
      String asset, String exchangeRate, String lastRefreshed) {
    return Material(
      elevation: 6,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFF2b2c34),
            // color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SizedBox(width: 15),
              SvgPicture.asset(
                asset,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$ $exchangeRate",
                    style: GoogleFonts.josefinSans(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Last Refreshed: $lastRefreshed",
                    style: GoogleFonts.josefinSans(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
