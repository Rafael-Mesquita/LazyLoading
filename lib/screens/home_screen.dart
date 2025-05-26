import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int pageSize = 10;
  int currentPage = 0;
  List<Country> allCountries = [];
  List<Country> visibleCountries = [];
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    try {
      allCountries = await ApiService.fetchCountries();
      _loadNextPage();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    }
  }

  void _loadNextPage() {
    if (currentPage * pageSize >= allCountries.length) {
      setState(() => hasMore = false);
      return;
    }

    final nextItems = allCountries.skip(currentPage * pageSize).take(pageSize).toList();
    setState(() {
      visibleCountries.addAll(nextItems);
      currentPage++;
      isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        hasMore) {
      _loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bandeiras dos Países')),
      body: isLoading && visibleCountries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: visibleCountries.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= visibleCountries.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final country = visibleCountries[index];
                return ListTile(
                  leading: Image.network(country.flagUrl, width: 50),
                  title: Text(country.name),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(country: country),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
