import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(target: carro.latLng(), zoom: 17),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId(carro.id.toString()),
        position: carro.latLng(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: "Fábrica do modelo ${carro.nome}",
          onTap: () {
            print("Clicou na janela!!");
          },
        ),
        onTap: () {
          print("clicou no marcador!!");
        },
      ),
    ];
  }
}