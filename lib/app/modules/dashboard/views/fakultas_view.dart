import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FakultasView extends GetView {
  const FakultasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FakultasView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FakultasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
