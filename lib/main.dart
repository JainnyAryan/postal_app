import 'package:flutter/material.dart';
import 'package:postal_app/postal_helper.dart';

void main() => runApp(const MaterialApp(
      home: Postal(),
    ));

class Postal extends StatefulWidget {
  const Postal({super.key});

  @override
  State<Postal> createState() => _PostalState();
}

class _PostalState extends State<Postal> {
  final TextEditingController _controller = TextEditingController();
  List<Map> postOffices = [];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postal'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                var postOfficesFromApi =
                    await PostalHelper.getPostOffices(_controller.text);
                setState(() {
                  postOffices = postOfficesFromApi;
                  _isLoading = false;
                });
              },
              child: !_isLoading
                  ? const Text('Submit')
                  : const Center(child: CircularProgressIndicator()),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => ListTile(
                    leading: const Icon(Icons.local_post_office_sharp),
                    title: Text(postOffices[index]['Name']),
                    subtitle: Text(
                        '${postOffices[index]['BranchType']}\n${postOffices[index]['DeliveryStatus']}\n${postOffices[index]['Circle']}\n'),
                    trailing: IconButton(
                      icon: const Icon(Icons.pin_drop),
                      onPressed: () {},
                    ),
                  ),
                  itemCount: postOffices.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//name, branchtype, delviry status, circle