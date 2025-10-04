import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hypecare_pkmkc/ui/widgets/hourly_timeline.dart';
import 'package:hypecare_pkmkc/services/history_service.dart';
import 'package:hypecare_pkmkc/models/daily_history.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<DailyHistory>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = HistoryService().fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Riwayat Tekanan Darah',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inika',
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<DailyHistory>>(
                future: _historyFuture,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(snapshot.hasError) {
                    return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
                  }

                  if(snapshot.hasData) {
                    final historyData = snapshot.data!;

                    if(historyData.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada riwayat pemantauan.'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        return _buildDayHistoryCard(historyData[index]);
                      },
                    );
                  }

                  return const Center(child: Text('Tidak ada data.'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDayHistoryCard(DailyHistory dayData) {
    final String formattedDate = DateFormat('dd/MM/yyyy').format(dayData.date);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 239, 255, 1),
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
          Text(
            formattedDate,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          const Text('Estimasi Tekanan Darah', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const HourlyTimeline(), // Menggunakan kembali widget timeline Anda
          ),
          const SizedBox(height: 20),

          // --- Grafik Prediksi (Placeholder) ---
          const Text('Prediksi Tekanan Darah', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const HourlyTimeline(), // Widget yang sama bisa digunakan lagi
          ),
          const SizedBox(height: 20),

          const Text(
            'Treatment:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          if (dayData.treatments.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Tidak Ada Riwayat Treatment',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dayData.treatments.map((treatment) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('• $treatment'),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}