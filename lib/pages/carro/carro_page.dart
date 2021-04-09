import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                PopupMenuItem(value: "Share", child: Text("Share")),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carro.nome,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  carro.tipo,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 40,
                  ),
                  onPressed: _onClickShare,
                ),
              ],
            ),
          ],
        );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar!!!");
        break;
      case "Deletar":
        print("Deletar!!!");
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          carro.descricao,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ad eos igitur converte te, quaeso. Hic ambiguo ludimur. Quod cum ita sit, perspicuum est omnis rectas res atque laudabilis eo referri, ut cum voluptate vivatur. De vacuitate doloris eadem sententia erit. Idem iste, inquam, de voluptate quid sentit? Num igitur dubium est, quin, si in re ipsa nihil peccatur a superioribus, verbis illi commodius utantur? Duo Reges: constructio interrete. Ita prorsus, inquam; At iam decimum annum in spelunca iacet. Profectus in exilium Tubulus statim nec respondere ausus;Haeret in salebra. Ergo illi intellegunt quid Epicurus dicat, ego non intellego? Ex ea difficultate illae fallaciloquae, ut ait Accius, malitiae natae sunt. Quid autem habent admirationis, cum prope accesseris? Illum mallem levares, quo optimum atque humanissimum virum, Cn.Quae in controversiam veniunt, de iis, si placet, disseramus. Ne discipulum abducam, times. Addidisti ad extremum etiam indoctum fuisse. Sed quid attinet de rebus tam apertis plura requirere? Isto modo, ne si avia quidem eius nata non esset. Odium autem et invidiam facile vitabis. Itaque contra est, ac dicitis; Illud dico, ea, quae dicat, praeclare inter se cohaerere. Propter nos enim illam, non propter eam nosmet ipsos diligimus. Memini vero, inquam; Portenta haec esse dicit, neque ea ratione ullo modo posse vivi;"),
      ],
    );
  }
}
