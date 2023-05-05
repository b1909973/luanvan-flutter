

import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/discover_screen/search_content.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget{
    const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
    late Future<void> _fetchProducts;
    void initState(){
      super.initState();
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      _fetchProducts = context.read<SearchManager>().fetchProductsSearch('',6);

    }


    @override
    Widget build(BuildContext context) {
      return FutureBuilder(
                  future: _fetchProducts,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   SearchContent();
                  
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                
                  return  const Center(
                  child: CircularProgressIndicator(),
                  );
                  
                  }
                  return const Center(
                  child: CircularProgressIndicator(),
                  );
                  },
                  ) ;


    }
}