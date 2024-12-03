import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task_2/task2/PDFViewerScreen.dart';
import 'package:task_2/task3/locationApp.dart';
import 'package:task_2/task1/notificationPage.dart';

class PortfolioPDF extends StatelessWidget {
  const PortfolioPDF({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text("Task 1", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationHomePage(),
                  ),
                );
              },
              child: const Text(
                'Notifications Page',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            const Divider(),
            const SizedBox(height: 15,),
            const Text("Task 2", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: () async {
                final pdfFile = await _generatePDF();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PDFViewerScreen(pdfpath: pdfFile.path),
                  ),
                );
              },
              child: const Text(
                'Generate and View PDF',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
              ),
              onPressed: () async {
                final pdfFile = await _generatePDF();
                await _saveAndSharePDF(context, pdfFile);
              },
              child: const Text(
                'Share with Saving PDF',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            const Divider(),
            const SizedBox(height: 15,),
            const Text("Task 3", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        LocationApp(),
                  ),
                );
              },
              child: const Text(
                'Location Page',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> _generatePDF() async {
    final pdf = pw.Document();

    final arabicFont = await rootBundle.load("assets/fonts/Amiri-Regular.ttf");
    final arabicTextStyle = pw.TextStyle(
      font: pw.Font.ttf(arabicFont),
      fontSize: 14,
      color: PdfColors.black,
    );

  
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        // textDirection:  pw.TextDirection.rtl,

        build: (context) => [
          // English Section

          pw.Text('Portfolio', style: const pw.TextStyle(fontSize: 24,),),
          pw.Divider(),
          pw.Text(
            'Personal Information',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,),
          ),
          pw.Bullet(
            text: 'Name: Mohamed Ebrahem',
          ),
          pw.Bullet(
            text: 'Contact: mohamedebrahem472001@gmail.com',
          ),
          pw.Bullet(
            text: 'Phone: +201210335687',
          ),
          pw.Divider(),
          pw.Text("Languages",
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Bullet(
            text: 'English: professional',
          ),
          pw.Bullet(
            text: 'Arabic: fluent',
          ),
          pw.Divider(),

          pw.Text("Personal Skills",
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          // pw.Row(
          //   mainAxisSize: pw.MainAxisSize.min,
          //   children: [
          pw.Bullet(
            text: 'Teamwork and Collaboration',
          ),
          pw.Bullet(
            text: 'Quick Learner',
          ),
          pw.Bullet(
            text: 'Problem-Solving',
          ),

          pw.SizedBox(height: 20),

          
          // Arabic Section

          pw.Align(
            alignment: pw.Alignment.center,
            child:pw.Text(
            '=========== المعلومات الشخصية ===========',
            style: arabicTextStyle.copyWith(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
            textDirection: pw.TextDirection.rtl,
          ),),
          pw.Text(
            'الاسم: محمد ابراهيم -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
            
          ),
          pw.Text(
            'البريد الإلكتروني: mohamedebrahem472001@gmail.com -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            'رقم الهاتف: 20+ 1210335687 -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Divider(),
          pw.Align(
            alignment: pw.Alignment.center,
            child:pw.Text(
            " =========== اللغات =========== ",
            style: arabicTextStyle.copyWith(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
            textDirection: pw.TextDirection.rtl,
          ),),
          pw.Text(
            'الانجليزية : محترف -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            'العربية : فصيح -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Divider(),

          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
            " =========== المهارات الشخصية =========== ",
            style: arabicTextStyle.copyWith(
              
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
          ),

          pw.Text(
            'العمل الجماعي والتعاون -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            'سريع التعلم -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.Text(
            'حل المشكلات -',
            style: arabicTextStyle,
            textDirection: pw.TextDirection.rtl,
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/portfolio.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> _saveAndSharePDF(BuildContext context, File pdfFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final savedFile = File("${directory.path}/portfolio.pdf");
    await savedFile.writeAsBytes(await pdfFile.readAsBytes());

    Share.shareXFiles([XFile(savedFile.path)], text: 'Check out my portfolio!');
  }
}
