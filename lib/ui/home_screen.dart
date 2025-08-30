import 'package:flutter/material.dart';

class TimeLinePainter extends CustomPainter{
  final int numbOfTicks;

  TimeLinePainter({required this.numbOfTicks});

  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, 1)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2), 
      Offset(size.width, size.height / 2), 
      paint
    );
  
    final double tickInterval = size.width / (numbOfTicks - 1);
    const double tickHeight = 10.0;

    for (int i = 0; i < numbOfTicks; i++) {
      final double x = i * tickInterval;
      canvas.drawLine(
        Offset(x, size.height / 2 - tickHeight / 2),
        Offset(x, size.height / 2 + tickHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAktifClicked = false;
  bool isNonaktifClicked = false;

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
                    'Grafik Tekanan Darah',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    color: Color.fromRGBO(208, 227, 255, 1),
                    child: Center(
                      child: Text(
                        'Placeholder Grafik Tekanan Darah',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const[
                      Text('06.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('09.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('12.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('15.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('18.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('21.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('00.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                      Text('03.00', style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 9)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
                          'Prediksi 30 Menit',
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