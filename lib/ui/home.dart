import 'package:flutter/material.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/bloc/contact_bloc.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/bloc/contact_event.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/bloc/contact_state.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/ui/detail.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends StatefulWidget {

  List<String> gender = ["male", "female"];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ContactBloc _contactBloc = ContactBloc();

  String genderFilter = "";
  String nameFilter = "";
  late TextEditingController _controller;


  @override
  void initState() {
    genderFilter = widget.gender.first;
    _controller = TextEditingController();

    _contactBloc.add(GetContactList(genderFilter, nameFilter));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [

              Container(height: 30,),

              DropdownButton<String>(value: genderFilter, items: widget.gender.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(), onChanged: (String? value) {
                setState(() {
                  genderFilter = value!;
                  _contactBloc.add(GetContactList(genderFilter, nameFilter));
                });
              }),

              Container(
                margin: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                  onSubmitted: (String value) async {
                    setState(() {
                      print(value);
                      nameFilter = value;
                      _contactBloc.add(GetContactList("", nameFilter));
                    });
                  },
                ),
              ),

              BlocProvider(
                create: (_) => _contactBloc,
                child: BlocListener<ContactBloc, ContactState>(
                  listener: (context, state) {
                    if (state is ContactError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message!),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, state) {
                      if (state is ContactInitial) {
                        return _buildLoading();
                      } else if (state is ContactLoading) {
                        return _buildLoading();
                      } else if (state is ContactLoaded) {
                        return _buildCard(context, state.list);
                      } else if (state is ContactError) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );

  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, List<Contact> model) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Detail(contact: model[index] );
              }));
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(model[index].avatar!),
                        backgroundColor: Colors.transparent,
                      ),
                      Text("Name: ${model[index].name }"),
                      Text("Phone: ${model[index].phone }"),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _contactBloc.close();
    super.dispose();
  }

}