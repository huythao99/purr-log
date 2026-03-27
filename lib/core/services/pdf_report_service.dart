import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../../data/models/pet_model.dart';
import '../../data/models/health_record_model.dart';
import '../../data/models/weight_record_model.dart';
import '../../data/models/feeding_log_model.dart';

class PdfReportService {
  Future<String> generateHealthReport({
    required Pet pet,
    required List<WeightRecord> weightRecords,
    required List<HealthRecord> healthRecords,
    required List<FeedingLog> feedingLogs,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM d, yyyy');
    final now = DateTime.now();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(pet, dateFormat.format(now)),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildPetInfoSection(pet, dateFormat),
          pw.SizedBox(height: 20),
          _buildWeightSection(weightRecords, dateFormat),
          pw.SizedBox(height: 20),
          _buildVaccinationsSection(healthRecords, dateFormat),
          pw.SizedBox(height: 20),
          _buildVetVisitsSection(healthRecords, dateFormat),
          pw.SizedBox(height: 20),
          _buildFeedingSummary(feedingLogs, dateFormat),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        '${pet.name.replaceAll(' ', '_')}_health_report_${DateFormat('yyyyMMdd').format(now)}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  pw.Widget _buildHeader(Pet pet, String date) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Pet Health Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.indigo,
                ),
              ),
              pw.Text(
                pet.name,
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Generated: $date',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
              pw.Text(
                'PurrLog App',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
      ),
    );
  }

  pw.Widget _buildPetInfoSection(Pet pet, DateFormat dateFormat) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.indigo50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Pet Information',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.indigo,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Expanded(
                child: _buildInfoItem('Species', pet.species.displayName),
              ),
              pw.Expanded(
                child: _buildInfoItem('Breed', pet.breed ?? 'Not specified'),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            children: [
              pw.Expanded(
                child: _buildInfoItem('Age', pet.ageDisplay ?? 'Unknown'),
              ),
              pw.Expanded(
                child: _buildInfoItem(
                  'Weight',
                  pet.weight != null ? '${pet.weight} kg' : 'Not recorded',
                ),
              ),
            ],
          ),
          if (pet.dateOfBirth != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: _buildInfoItem(
                'Date of Birth',
                dateFormat.format(pet.dateOfBirth!),
              ),
            ),
        ],
      ),
    );
  }

  pw.Widget _buildInfoItem(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _buildWeightSection(
    List<WeightRecord> records,
    DateFormat dateFormat,
  ) {
    final recentRecords = records.take(10).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Weight History',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo,
          ),
        ),
        pw.SizedBox(height: 10),
        if (recentRecords.isEmpty)
          pw.Text(
            'No weight records available',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          )
        else
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                children: [
                  _buildTableHeader('Date'),
                  _buildTableHeader('Weight (kg)'),
                  _buildTableHeader('Notes'),
                ],
              ),
              ...recentRecords.map((record) => pw.TableRow(
                    children: [
                      _buildTableCell(dateFormat.format(record.recordDate)),
                      _buildTableCell(record.weight.toStringAsFixed(1)),
                      _buildTableCell(record.notes ?? '-'),
                    ],
                  )),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildVaccinationsSection(
    List<HealthRecord> records,
    DateFormat dateFormat,
  ) {
    final vaccinations = records
        .where((r) => r.type == HealthRecordType.vaccination)
        .take(10)
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Vaccinations',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo,
          ),
        ),
        pw.SizedBox(height: 10),
        if (vaccinations.isEmpty)
          pw.Text(
            'No vaccination records available',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          )
        else
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                children: [
                  _buildTableHeader('Vaccine'),
                  _buildTableHeader('Date Given'),
                  _buildTableHeader('Next Due'),
                ],
              ),
              ...vaccinations.map((record) => pw.TableRow(
                    children: [
                      _buildTableCell(record.title),
                      _buildTableCell(dateFormat.format(record.recordDate)),
                      _buildTableCell(
                        record.nextDueDate != null
                            ? dateFormat.format(record.nextDueDate!)
                            : '-',
                      ),
                    ],
                  )),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildVetVisitsSection(
    List<HealthRecord> records,
    DateFormat dateFormat,
  ) {
    final vetVisits = records
        .where((r) =>
            r.type == HealthRecordType.vetVisit ||
            r.type == HealthRecordType.checkup)
        .take(10)
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Vet Visits',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo,
          ),
        ),
        pw.SizedBox(height: 10),
        if (vetVisits.isEmpty)
          pw.Text(
            'No vet visit records available',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          )
        else
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                children: [
                  _buildTableHeader('Date'),
                  _buildTableHeader('Type'),
                  _buildTableHeader('Description'),
                  _buildTableHeader('Clinic'),
                ],
              ),
              ...vetVisits.map((record) => pw.TableRow(
                    children: [
                      _buildTableCell(dateFormat.format(record.recordDate)),
                      _buildTableCell(record.type.displayName),
                      _buildTableCell(record.title),
                      _buildTableCell(record.clinicName ?? '-'),
                    ],
                  )),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildFeedingSummary(
    List<FeedingLog> logs,
    DateFormat dateFormat,
  ) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final recentLogs = logs
        .where((l) => l.feedingTime.isAfter(sevenDaysAgo))
        .toList();

    final totalKcal = recentLogs.fold<double>(0, (sum, l) => sum + l.totalKcal);
    final avgKcal = recentLogs.isNotEmpty ? totalKcal / 7 : 0;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '7-Day Feeding Summary',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Container(
          padding: const pw.EdgeInsets.all(15),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    '${recentLogs.length}',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.indigo,
                    ),
                  ),
                  pw.Text(
                    'Meals Logged',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    '${totalKcal.toInt()}',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.indigo,
                    ),
                  ),
                  pw.Text(
                    'Total kcal',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    '${avgKcal.toInt()}',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.indigo,
                    ),
                  ),
                  pw.Text(
                    'Daily Avg kcal',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
      ),
    );
  }
}
