import 'package:flutter/material.dart';

class TelaEmpresa extends StatefulWidget {
  const TelaEmpresa({Key? key}) : super(key: key);

  @override
  State<TelaEmpresa> createState() => _TelaEmpresaState();
}

class _TelaEmpresaState extends State<TelaEmpresa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Empresa"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("images/detalhe_empresa.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Sobre a empresa",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc maximus est quis velit malesuada dictum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin et metus ultrices dui feugiat gravida. Nulla id auctor urna. Quisque pulvinar feugiat dapibus. Donec sed pellentesque felis. Aliquam ultrices ultricies neque sit amet aliquam. Sed facilisis sem neque, quis lobortis nulla euismod venenatis. Suspendisse varius nibh eget dolor maximus pretium. Sed sit amet felis ac orci efficitur rhoncus. Fusce ac venenatis sem. Etiam bibendum nec lectus ut vulputate.Pellentesque varius at urna nec laoreet. Sed volutpat ligula velit, at facilisis turpis elementum et. Donec scelerisque feugiat nibh, sed semper lacus eleifend eu. Praesent ligula magna, varius id arcu sed, aliquam fringilla orci. Sed vitae nisi dui. Mauris pulvinar maximus diam, ac eleifend lacus maximus vel. Suspendisse placerat auctor hendrerit. Phasellus pulvinar vel justo ut imperdiet. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi convallis blandit nibh, at hendrerit ipsum convallis a.Curabitur rhoncus auctor nulla, quis luctus metus ornare non. Ut velit nisi, vulputate eget nulla eu, porttitor ultricies elit. Maecenas vitae sollicitudin augue. Duis eu ex nunc. Integer eget mauris et mauris tempor faucibus sed at metus. Vivamus luctus quis ipsum maximus tempus. Sed semper nisl varius tortor imperdiet finibus. In convallis velit eros, at congue enim luctus nec. Duis lobortis metus tellus, sed sodales lacus pulvinar sed. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent feugiat nibh vitae lacus vehicula malesuada. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus laoreet auctor justo. Quisque quis tellus dignissim, sagittis nulla at, tempus nulla. Suspendisse potenti. Aenean efficitur dapibus diam sit amet fringilla.Sed viverra aliquet mauris. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis vulputate erat tincidunt risus volutpat tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod orci hendrerit, tempus nibh et, porta nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum interdum non augue at facilisis. Vivamus id nisi sed ligula accumsan efficitur et eget odio. Integer velit odio, bibendum at dolor non, interdum volutpat augue. Aliquam rhoncus felis id arcu maximus, nec accumsan ligula volutpat. Nunc augue libero, semper a libero eu, dapibus iaculis lectus. Suspendisse et velit id ipsum consequat semper vel quis mi. Vestibulum rhoncus, eros in ornare gravida, purus lacus accumsan sem, quis ultrices erat nibh ut neque.Suspendisse cursus pretium urna, at tincidunt sem rutrum ac. Sed posuere, nisl sit amet hendrerit sollicitudin, arcu sapien efficitur ante, nec facilisis arcu ipsum eu diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed consectetur felis non tristique sollicitudin. Vivamus pharetra eros a diam lacinia vestibulum. Phasellus in erat eget mi viverra commodo. Cras eget malesuada lacus. Nulla posuere nec elit vel imperdiet. Integer imperdiet nibh vitae dolor efficitur, vel facilisis arcu efficitur. Etiam placerat a turpis ac pulvinar. Vivamus tristique, felis at eleifend tincidunt, leo nibh ultrices leo, sollicitudin cursus est tortor eu urna. Suspendisse dui sem, dapibus in ultrices congue, sollicitudin eget est."
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
