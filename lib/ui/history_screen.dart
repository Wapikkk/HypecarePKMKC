import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<DateTime> _historyDates = List.generate(
    7, // Menampilkan riwayat untuk 7 hari terakhir
    (index) => DateTime.now().subtract(Duration(days: index + 1)), // Mulai dari kemarin (Day 1)
  );
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
                  fontFamily: 'Nunito',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              const SizedBox(height: 20),
              ..._historyDates.map((date) => _buildDayHistoryCard(date)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayHistoryCard(DateTime date) {

     final String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(208, 227, 255, 1),
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
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Center(
              child: Text(
                'Placeholder Grafik Tekanan Darah',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeLabel('06.00'),
              _buildTimeLabel('09.00'),
              _buildTimeLabel('12.00'),
              _buildTimeLabel('15.00'),
              _buildTimeLabel('18.00'),
              _buildTimeLabel('21.00'),
              _buildTimeLabel('00.00'),
              _buildTimeLabel('03.00'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Treatment:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Data treatment akan muncul di sini (dari data Anda)',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLabel(String time) {
    return Text(
      time,
      style: const TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
    );
  }
}