import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guideofcoc/Builderbase/attackstrategy.dart';
import 'package:guideofcoc/Builderbase/baselayouts.dart';
import 'package:guideofcoc/Homevillage/attackstrategy.dart';
import 'package:guideofcoc/Homevillage/baselayouts.dart';
import 'package:guideofcoc/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  CarouselSlider topSlider;
  var popupChoices = [
    "Share",
    "Rate Us",
    
    "Contact Us",
  ];
  var popupUrls = [
    "Hey Clashers i have an amzing app for you, Pls Download..  https://play.google.com/store/apps/details?id=guide.coc.guidecoc",
    "https://play.google.com/store/apps/details?id=com.tencent.iglite",
    
    "mailto:sunil98meena@gmail.com?subject= Help and Support",
  ];
  final Firestore db = Firestore.instance;

  @override
  void initState() {
    
    super.initState();
  }

  Future<String> getFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString("updates");
    return stringValue;
  }

  void handleClick(String value) {
    switch (value) {
      case 'Share':
        Share.share(popupUrls[popupChoices.indexOf(value)]);
        break;
      case "Contact Us":
        launch_url(popupUrls[popupChoices.indexOf(value)]);
        break;
      case "Rate Us":
        launch_url(popupUrls[popupChoices.indexOf(value)]);
        break;
    }
  }

  getSlider() {
    return CarouselSlider(
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              autoPlay: true,
              enlargeCenterPage: true,
              items: updatesList.map(
                (urls) {
                  
                  var imgUrl, pageUrl;
                  imgUrl = urls.split(";")[0];
                  pageUrl = urls.split(";")[1];
                  return GestureDetector(
                    onTap: () {
                      launch_url(pageUrl);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff5f4),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text(
          'COC Guide',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return popupChoices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          getSlider(),
          // updates.length==0?Text("Loading..."):Container(margin: EdgeInsets.only(top: 10), child: topSlider),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 5, left: 10),
            child: Text(
              'Home Village',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 2.4187634785970054,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeBaseBaseLayouts()),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 178.0,
                        height: 176.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x1a7364f8),
                              offset:
                                  Offset(-2.723942995071411, 5.346039295196533),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        left: 5,
                        child: Container(
                          width: 150.0,
                          height: 40.0,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x0d7cb832),
                          ),
                          child: Text(
                            'Base Layouts',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: const Color(0xff0f0250),
                              letterSpacing: 0.24,
                              fontWeight: FontWeight.w600,
                              height: 1.875,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(12.0, 20.0),
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x1afdbc5a),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 29.0),
                        child: SvgPicture.string(
                          _svg_fjhovl,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeBaseAttackStrategy()),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 178.2,
                        height: 176.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffffffff),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(13.0, 20.0),
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x1a1e98d4),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 4,
                        child: Container(
                          width: 150.0,
                          height: 40.0,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x0d7cb832),
                          ),
                          child: Text(
                            'Attack Videos',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: const Color(0xff0f0250),
                              letterSpacing: 0.24,
                              fontWeight: FontWeight.w600,
                              height: 1.875,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 35.15),
                        child: SvgPicture.string(
                          _svg_u5or71,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 5, left: 10),
            child: Text(
              'Builder Base',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 2.4187634785970054,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuilderBaseBaseLayouts()),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 178.0,
                        height: 176.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x1a7364f8),
                              offset:
                                  Offset(-2.723942995071411, 5.346039295196533),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(12.0, 122.0),
                        child: Container(
                          width: 153.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x0dfdbc5a),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 4,
                        child: Container(
                          width: 150.0,
                          height: 40.0,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x0d7cb832),
                          ),
                          child: Text(
                            'Base Layouts',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: const Color(0xff0f0250),
                              letterSpacing: 0.24,
                              fontWeight: FontWeight.w600,
                              height: 1.875,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(12.0, 20.0),
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x1afdbc5a),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 29.0),
                        child: SvgPicture.string(
                          _svg_fjhovl,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuilderBaseAttackStrategy()),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 178.2,
                        height: 176.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffffffff),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(13.0, 20.0),
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x1a1e98d4),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 4,
                        child: Container(
                          width: 150.0,
                          height: 40.0,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0x0d7cb832),
                          ),
                          child: Text(
                            'Attack Videos',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: const Color(0xff0f0250),
                              letterSpacing: 0.24,
                              fontWeight: FontWeight.w600,
                              height: 1.875,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20.0, 35.15),
                        child: SvgPicture.string(
                          _svg_u5or71,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  launch_url(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

const String _svg_u5or71 =
    '<svg viewBox="20.0 35.2 33.0 31.0" ><path transform="translate(20.0, 35.15)" d="M 5.028951644897461 30.99486923217773 C 3.216575622558594 30.98766708374023 2.367089033126831 30.1476993560791 2.362572431564331 28.34984588623047 C 2.352684736251831 24.51487731933594 2.352684736251831 20.67905426025391 2.363426923751831 16.84311103820801 C 2.368798017501831 15.09213161468506 3.116722106933594 14.29452323913574 4.854391574859619 14.28732109069824 C 10.2502613067627 14.26388359069824 15.64698505401611 14.26571464538574 21.04285430908203 14.28463554382324 C 22.8230037689209 14.29183769226074 23.6607723236084 15.18575954437256 23.6652889251709 17.00326728820801 C 23.6742000579834 20.80234718322754 23.6768856048584 24.60044860839844 23.6643123626709 28.39842987060547 C 23.6580867767334 30.2241153717041 22.9011287689209 30.98583602905273 21.10681915283203 30.99389266967773 C 19.30603981018066 31.00109481811523 17.50623512268066 30.99926376342773 15.70545673370361 30.99840927124023 C 14.84522819519043 30.99755477905273 13.98316860198975 30.99657821655273 13.12269592285156 30.99755477905273 C 11.52406406402588 30.99755477905273 9.925188064575195 30.99999618530273 8.326435089111328 30.99999618530273 C 7.227313995361328 30.99999618530273 6.128193855285645 30.99889755249023 5.028951644897461 30.99486923217773 Z M 31.92724418640137 29.9569034576416 C 30.15087890625 28.44982147216797 28.36548042297363 26.9517707824707 26.62854194641113 25.39891242980957 C 26.31909370422363 25.12254524230957 26.07251358032227 24.60935974121094 26.05542373657227 24.19432067871094 C 25.90149307250977 20.45566558837891 25.91772842407227 20.45481109619141 28.74169921875 18.05929946899414 C 30.0843505859375 16.91867256164551 31.42773246765137 15.77890110015869 33 14.44576835632324 C 33 19.99118804931641 33 25.22703742980957 33 30.71837997436523 C 32.53564453125 30.3917179107666 32.211669921875 30.1981143951416 31.92724418640137 29.9569034576416 Z M 0.0002696083975024521 6.016920566558838 C -0.03037001378834248 2.710395812988281 2.554222583770752 0.06000052765011787 5.860494136810303 0.006045352201908827 C 9.090350151062012 -0.04620083421468735 11.81703281402588 2.638252258300781 11.85743808746338 5.91145133972168 C 11.89711093902588 9.146076202392578 9.221697807312012 11.88912296295166 5.966695308685303 11.95113468170166 C 5.931783199310303 11.95186710357666 5.896504878997803 11.95211124420166 5.861836910247803 11.95211124420166 C 2.699974536895752 11.95247745513916 0.03054301999509335 9.261676788330078 0.0002696083975024521 6.016920566558838 Z M 14.17127895355225 5.98274040222168 C 14.16676235198975 2.657173156738281 16.8906364440918 -0.04436977580189705 20.20056915283203 0.0005521783605217934 C 23.4240779876709 0.04474171251058578 26.02844619750977 2.704048156738281 26.02392959594727 5.94477653503418 C 26.01843643188477 9.249713897705078 23.3772029876709 11.94039249420166 20.12866973876953 11.95211124420166 C 20.12232208251953 11.95211124420166 20.11585235595703 11.95211124420166 20.10962677001953 11.95211124420166 C 16.8978385925293 11.95223331451416 14.17481899261475 9.217975616455078 14.17127895355225 5.98274040222168 Z" fill="#25d695" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fjhovl =
    '<svg viewBox="20.0 29.0 40.0 40.0" ><path transform="translate(20.0, 29.0)" d="M 0.5963993668556213 27.73668098449707 C -1.823280096054077 18.54477691650391 3.314785242080688 9.578094482421875 12.47433757781982 7.027432918548584 C 13.11240005493164 6.849210262298584 13.77103042602539 6.729458808898926 14.42795276641846 6.634976387023926 C 15.57700157165527 6.469449043273926 16.52097129821777 7.349576950073242 16.52457237243652 8.562834739685059 C 16.52908897399902 10.33139038085938 16.52548789978027 12.10080146789551 16.52548789978027 13.86935806274414 C 16.52365684509277 13.86935806274414 16.52097129821777 13.86935806274414 16.51914024353027 13.86935806274414 C 16.51914024353027 15.49203968048096 16.51645469665527 17.11472320556641 16.51914024353027 18.73838043212891 C 16.52457237243652 21.40415573120117 18.39890289306641 23.2942943572998 21.07505226135254 23.3060131072998 C 22.45542335510254 23.3113842010498 23.83671188354492 23.3104076385498 25.21793746948242 23.3095531463623 C 27.1049633026123 23.3086986541748 28.99186706542969 23.3068675994873 30.87889289855957 23.3231029510498 C 31.38182258605957 23.3274974822998 31.92271614074707 23.4301586151123 32.37535095214844 23.6407299041748 C 33.10691833496094 23.9809398651123 33.47850036621094 24.8558177947998 33.33543395996094 25.63963317871094 C 32.12602233886719 32.28258514404297 28.37638854980469 36.84569931030273 22.00730323791504 39.0975341796875 C 20.27225685119629 39.7110595703125 18.49069976806641 39.9998779296875 16.73062705993652 40 C 9.453827857971191 40.00048828125 2.52675986289978 35.06567001342773 0.5963993668556213 27.73668098449707 Z M 27.8859691619873 19.96677589416504 C 25.90812492370605 19.96677589416504 23.93119430541992 19.96958351135254 21.95328712463379 19.96592140197754 C 20.64402198791504 19.96409034729004 20.01236915588379 19.32688331604004 20.01145362854004 18.00839996337891 C 20.00968360900879 15.36606311798096 20.01145362854004 12.72360515594482 20.01145362854004 10.08126831054688 C 20.01145362854004 7.437833786010742 20.01597023010254 4.795375347137451 20.00785255432129 2.153038740158081 C 20.00608253479004 1.495933532714844 20.16172218322754 0.883994460105896 20.67826271057129 0.478110283613205 C 20.99497413635254 0.229696974158287 21.43680763244629 0.01363230776041746 21.82822608947754 0.003744603600353003 C 25.4203929901123 -0.08353575319051743 28.51860046386719 1.364585757255554 31.37101936340332 3.339196920394897 C 35.9764289855957 6.528775215148926 38.7966194152832 10.93087863922119 39.8441047668457 16.44687461853027 C 39.9214973449707 16.85458946228027 39.9753303527832 17.26950836181641 39.9960823059082 17.68357086181641 C 40.06444549560547 19.09287452697754 39.2339973449707 19.96238136291504 37.8139533996582 19.96506690979004 C 36.4511604309082 19.96763038635254 35.0883674621582 19.96836280822754 33.72593688964844 19.96836280822754 C 31.77928352355957 19.96836280822754 29.83287048339844 19.96677589416504 27.8859691619873 19.96677589416504 Z" fill="#fdbc5a" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
