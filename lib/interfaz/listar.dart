// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/controlador/controladorGeneral.dart';
import 'package:reto4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
  controladorGeneral Control = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Control.CargarTodaBD();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Control.ListaPosiciones?.isEmpty == false
              ? ListView.builder(
                  itemCount: Control.ListaPosiciones!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      leading: Icon(Icons.location_searching_rounded),
                      trailing: IconButton(
                          onPressed: () {
                            Alert(
                                    type: AlertType.warning,
                                    context: context,
                                    title: "Alerta!!!",
                                    buttons: [
                                      DialogButton(
                                          color:
                                              Color.fromARGB(181, 241, 76, 76),
                                          child: Text("Si"),
                                          onPressed: () {
                                            PeticionesDB.EliminarUnaPosicion(
                                                Control.ListaPosiciones![index]
                                                    ["id"]);
                                            Control.CargarTodaBD();
                                            Navigator.pop(context);
                                          }),
                                      DialogButton(
                                          color: Color.fromARGB(
                                              202, 161, 255, 137),
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                    desc: "Desea eliminar esta posicion?")
                                .show();
                          },
                          icon: Icon(Icons.delete_outlined)),
                      title:
                          Text(Control.ListaPosiciones![index]["coordenadas"]),
                      subtitle: Text(Control.ListaPosiciones![index]["fecha"]),
                    ));
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
