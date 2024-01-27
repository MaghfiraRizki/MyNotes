// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:uas_maghfira/screen/login_screen.dart';
import 'package:uas_maghfira/services/firebase_auth_services.dart';
import 'package:uas_maghfira/services/firebase_db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController judulController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21899C),
      appBar: AppBar(
        backgroundColor: Color(0xFFF56B3F),
        title: Text(
          'My Notes',
          style: GoogleFonts.nunito(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuthServices().logout().then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCatatan(context);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFFF56B3F),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?.docs.isEmpty ?? true) {
                return Center(
                    child: Text(
                  'no data',
                  style: GoogleFonts.nunito(),
                ));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (_, index) {
                    var data = snapshot.data;
                    return Dismissible(
                      key: Key('${data?.docs[index]}'),
                      background: Container(
                        color: Colors.red,
                      ),
                      confirmDismiss: (_) async {
                        deleteCatatan(context,
                            uidCatatn: '${data?.docs[index].id}');
                        return true;
                      },
                      child: Card(
                        color: HexColor("#DBEDF3"),
                        child: ListTile(
                            title: Text(
                              '${data?.docs[index]['judul']}',
                              style: GoogleFonts.nunito(),
                            ),
                            subtitle: Text('${data?.docs[index]['isi']}',
                                style: GoogleFonts.nunito()),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    editCatatan(context,
                                        uidCatatn: '${data?.docs[index].id}',
                                        judul: '${data?.docs[index]['judul']}',
                                        isi: '${data?.docs[index]['isi']}');
                                  },
                                  icon: Icon(Icons.edit,
                                      color: HexColor("#0A91AB")),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteCatatan(context,
                                        uidCatatn: '${data?.docs[index].id}');
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(child: Text(''));
            }
          }),
    );
  }

  addCatatan(BuildContext context) async {
    var hasil = await showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              contentPadding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Add Notes',
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),
              children: [
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    labelText: 'title',
                    hintText: 'Enter your title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.nunito(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: isiController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'content',
                    hintText: 'Enter your content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.nunito(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SimpleDialogOption(
                      child: Text('Cancel', style: GoogleFonts.nunito()),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      padding: EdgeInsets.all(8),
                    ),
                    SimpleDialogOption(
                      child: Text('Save',
                          style: GoogleFonts.nunito(color: Color(0xFFF56B3F))),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ));
    if (hasil == true) {
      FirebaseDBServices()
          .addCatatan(
        judulCatatan: judulController.text,
        isiCatatan: isiController.text,
      )
          .then((value) {
        setState(() {});
      });
    }
    judulController.clear();
    isiController.clear();
  }

  editCatatan(BuildContext context,
      {required String? uidCatatn, String? judul, String? isi}) async {
    judulController.text = judul ?? '';
    isiController.text = isi ?? '';
    var hasil = await showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              contentPadding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text('Edit Notes',
                  style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
              children: [
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    labelText: 'title',
                    hintText: 'Enter your title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.nunito(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: isiController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'content',
                    hintText: 'Enter your content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.nunito(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SimpleDialogOption(
                      child: Text('Cancel', style: GoogleFonts.nunito()),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      padding: EdgeInsets.all(8),
                    ),
                    SimpleDialogOption(
                      child: Text('Save',
                          style: GoogleFonts.nunito(color: Color(0xFFF56B3F))),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ));
    if (hasil == true) {
      FirebaseDBServices()
          .editCatatan(
        uidCatatan: uidCatatn,
        judulCatatan: judulController.text,
        isiCatatan: isiController.text,
      )
          .then((value) {
        setState(() {});
      });
    }

    judulController.clear();
    isiController.clear();
  }

  deleteCatatan(BuildContext context, {required String? uidCatatn}) async {
    FirebaseDBServices().deleteCatatan(uidCatatn);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully deleted'),
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    var box = await Hive.openBox('userBox');
    var uid = await box.get('uid');
    var hasil = await FirebaseDBServices().getCatatan(uid);
    return hasil;
  }
}
