import 'package:flutter/material.dart';
import 'widgets/hourly_timeline.dart';
import 'package:hypecare_pkmkc/models/home_data.dart';
import 'package:hypecare_pkmkc/services/home_service.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAktifClicked = false;
  bool isNonaktifClicked = false;
  late Future<HomeData> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = HomeService().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final historyBoxWidth = screenWidth * 0.5 - (16.0 * 2);
    final bool isHistoryTreatmentEmpty = true;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center (
              child: const Text(
                'Kondisi Hari Ini',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<HomeData>(
              future: _homeDataFuture,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if(snapshot.hasError) {
                  return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
                }

                if(snapshot.hasData){
                  final homeData = snapshot.data!;

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(208, 227, 255, 1),
                          borderRadius: BorderRadius.circular(13.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estimasi Tekanan Darah',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            const SizedBox(height: 10),
                            HourlyTimeline(data: homeData.estimationData),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(208, 227, 255, 1),
                          borderRadius: BorderRadius.circular(13.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Prediksi Tekanan Darah',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            const SizedBox(height: 10),
                            HourlyTimeline(data: homeData.predictionData),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('Tidak ada data tersedia'));
              }
            ),
            SizedBox(height: 16),
            Row (
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(208, 227, 255, 1),
                      borderRadius: BorderRadius.circular(13.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tekanan Darah',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Sistolik: ', 
                              style: TextStyle(
                                fontFamily: 'Nunito', 
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                            ),
                            Text(
                              'mmHg',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(90, 157, 255, 1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Diastolik: ',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                            ),
                            Text(
                              'mmHg',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(90, 157, 255, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(208, 227, 255, 1),
                      borderRadius: BorderRadius.circular(13.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prediksi 1 jam',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Sistolik: ',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                            ),
                            Text(
                              'mmHg',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(90, 157, 255, 1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Diastolik: ',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'mmHg',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(90, 157, 255, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                'Koneksi Treatment',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isNonaktifClicked = false;
                      isAktifClicked = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states){
                        if (states.contains(MaterialState.pressed) || isAktifClicked) {
                          return Color.fromRGBO(188, 207, 235, 1);
                        }
                        return Color.fromRGBO(208, 227, 255, 1);
                      },
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                  ),
                  child: const Text(
                    'Aktifkan',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color.fromRGBO(90, 157, 255, 1),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isNonaktifClicked = true;
                      isAktifClicked = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states){
                        if (states.contains(MaterialState.pressed) || isNonaktifClicked) {
                          return Color.fromRGBO(188, 207, 235, 1);
                        }
                        return Color.fromRGBO(208, 227, 255, 1);
                      },
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                  ),
                  child: const Text(
                    'Nonaktif',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color.fromRGBO(90, 157, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Riwayat Treatment',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: historyBoxWidth,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(208, 227, 255, 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: isHistoryTreatmentEmpty
                  ? const Center(
                      child: Text(
                        'Tidak Ada Riwayat Treatment',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(90, 157, 255, 1),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Riwayat Treatment Tersedia',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Color.fromRGBO(90, 157, 255, 1),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}