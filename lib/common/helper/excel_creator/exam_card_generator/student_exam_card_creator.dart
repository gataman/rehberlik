import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../locator.dart';
import '../../../../models/student.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;

import '../../../../models/student_with_class.dart';
import '../../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'exam_hall_builder.dart';
import '../student_detail_excel_builder/student_detail_excel_helper.dart';

class StudentExamCardCreator {
  final ValueNotifier<bool> notifier = ValueNotifier(false);

  late StudentDetailExcelHelper _helper;

  StudentExamCardCreator() {
    _helper = locator<StudentDetailExcelHelper>();
  }

  Future<void> build(List<Student> studentList) async {
    notifier.value = true;
    final logoData = await _readImageData('meb_logo.png');
    final String logo = base64.encode(logoData!);
    final Workbook workbook = Workbook(1);

    final Worksheet sheet = workbook.worksheets[0];
    _pageSetup(sheet);

    var row = 0;
    for (var student in studentList) {
      /*  http.Response response = await http.get(
          Uri.parse(student.photoUrl!),
        );
        final image = resizeImage(response.bodyBytes, .59); */
      //Resize işlemleri:
      //final image = resizeImage(response.bodyBytes, .7);

      /*  if (image != null) {
          _addStudent(sheet: sheet, student: student, imageData: studentFoto, row: row, logo: logo);
        } */

      List<int>? photoData = await _readImageData('${student.studentNumber}.jpg');

      String? studentPhoto;

      if (photoData != null) {
        studentPhoto = base64.encode(photoData);
      }

      _addStudent(sheet: sheet, student: student, imageData: studentPhoto, row: row, logo: logo);

      row++;
    }

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'sinav_giris_belgeleri.xlsx');
    notifier.value = false;
    workbook.dispose();
  }

  void _pageSetup(Worksheet sheet) {
    sheet.name = 'Sınav Giriş Belgeleri';
    var pageSetup = sheet.pageSetup;

    pageSetup.leftMargin = .25;
    pageSetup.rightMargin = .25;
    pageSetup.topMargin = .25;
    pageSetup.bottomMargin = .20;
    pageSetup.orientation = ExcelPageOrientation.portrait;

    sheet.getRangeByIndex(1, 1, 1, 35).columnWidth = 2.17;
    sheet.getRangeByName('C1').columnWidth = 0.62;
    //sheet.getRangeByName('G1').columnWidth = 0.62;
  }

  Uint8List? resizeImage(Uint8List data, double percentage) {
    Uint8List resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    if (img != null) {
      IMG.Image? resized =
          IMG.copyResize(img, width: (img.width * percentage).toInt(), height: (img.height * percentage).toInt());
      return Uint8List.fromList(IMG.encodeJpg(resized));
    }
    return null;
  }

  void _addStudent({
    required Worksheet sheet,
    required Student student,
    //required Uint8List? imageData,
    required String? imageData,
    required int row,
    required String logo,
  }) {
    var mainStartRow = row == 0 ? 1 : (row * 29);
    var mainEndRow = row == 0 ? 27 : mainStartRow + 26;
    var mainStartColumn = 1;
    var mainEndColumn = mainStartColumn + 34;
    sheet.getRangeByIndex(mainStartRow, 1, mainEndRow, 1).rowHeight = 15.5;
    sheet.getRangeByIndex(mainEndRow + 1, 1).rowHeight = row == 0 ? 48 : 28;

    sheet.getRangeByIndex(mainStartRow + 2, 1).rowHeight = 5;
    sheet.getRangeByIndex(mainStartRow + 6, 1).rowHeight = 5;
    sheet.getRangeByIndex(mainStartRow + 3, 1).rowHeight = 18;
    sheet.getRangeByIndex(mainEndRow - 3, 1).rowHeight = 28;
/* 
    sheet.getRangeByIndex(startRow, 2).setNumber(double.parse(student.studentNumber!));
    sheet.getRangeByIndex(startRow, 33).setNumber(double.parse(student.studentNumber!));
    sheet.getRangeByIndex(endRow, 2).setNumber(double.parse(student.studentNumber!));
    sheet.getRangeByIndex(endRow, 33).setNumber(double.parse(student.studentNumber!)); */

    int startRow = mainStartRow + 1;
    int endRow = mainEndRow - 1;
    int startColumn = mainStartColumn + 1;
    int endColumn = mainEndColumn - 1;

    //Borders:

    //Main Border:
    _setAllBorder(sheet, startRow, startColumn, endColumn, endRow);

    // Logo
    final logoStartRow = startRow + 1;
    final logoEndRow = logoStartRow + 3;
    const logoStartColumn = 3;
    const logoEndColumn = logoStartColumn + 4;
    sheet.getRangeByIndex(logoStartRow, logoStartColumn, logoEndRow, logoEndColumn).merge();
    sheet.pictures.addBase64(logoStartRow + 1, logoStartColumn + 1, logo);

    // Main Title: SINAV GİRİŞ BELGESİ
    final mainTitleStartRow = logoStartRow;
    final mainTitleEndRow = mainTitleStartRow + 1;
    const mainTitleStartColumn = logoEndColumn + 1;
    const mainTitleEndColumn = mainTitleStartColumn + 25;
    final mainTitleCell =
        sheet.getRangeByIndex(mainTitleStartRow, mainTitleStartColumn, mainTitleEndRow, mainTitleEndColumn);
    mainTitleCell.merge();
    mainTitleCell.setText('SINAV GİRİŞ BELGESİ');
    _helper.setStyle(
      style: mainTitleCell.cellStyle,
      isBold: true,
    );
    mainTitleCell.cellStyle.fontColor = '#FF0000';

    // SubTitle :
    final subTitleStartRow = mainTitleEndRow + 1;
    final subTitleEndRow = subTitleStartRow + 1;
    const subTitleStartColumn = mainTitleStartColumn;
    const subTitleEndColumn = mainTitleEndColumn;
    final subTitleCell =
        sheet.getRangeByIndex(subTitleStartRow, subTitleStartColumn, subTitleEndRow, subTitleEndColumn);
    subTitleCell.merge();
    subTitleCell.setText('2023 - BİLGE PROJESİ LGS BAŞARI İZLEME SINAVI  (2 Nisan - Pazar)');
    _helper.setStyle(style: subTitleCell.cellStyle, isBold: true, fontSize: 14);

    //Student Photo:
    final photoStartRow = logoEndRow + 1;
    final photoEndRow = photoStartRow + 5;
    const photoStartColumn = logoStartColumn;
    const photoEndColumn = logoEndColumn;
    sheet.getRangeByIndex(photoStartRow, photoStartColumn, photoEndRow, photoEndColumn).merge();
    //sheet.pictures.addStream(photoStartRow + 1, photoStartColumn + 1, imageData!);
    if (imageData != null) {
      sheet.pictures.addBase64(photoStartRow + 1, photoStartColumn + 1, imageData);
    }

    sheet.getRangeByIndex(photoStartRow, photoStartColumn).cellStyle.hAlign = HAlignType.center;

    // Student Info:
    final tcLabelRow = subTitleEndRow + 2;
    final nameLabelRow = tcLabelRow + 1;
    final fatherLabelRow = nameLabelRow + 1;
    final birthdayLabelRow = fatherLabelRow + 1;
    final langLabelRow = birthdayLabelRow + 1;
    const labelStartColumn = subTitleStartColumn + 1;
    const labelEndColumn = labelStartColumn + 4;

    final tcLabelCell = sheet.getRangeByIndex(tcLabelRow, labelStartColumn, tcLabelRow, labelEndColumn);
    final nameLabelCell = sheet.getRangeByIndex(nameLabelRow, labelStartColumn, nameLabelRow, labelEndColumn);
    final fatherLabelCell = sheet.getRangeByIndex(fatherLabelRow, labelStartColumn, fatherLabelRow, labelEndColumn);
    final birthdayLabelCell =
        sheet.getRangeByIndex(birthdayLabelRow, labelStartColumn, birthdayLabelRow, labelEndColumn);
    final langLabelCell = sheet.getRangeByIndex(langLabelRow, labelStartColumn, langLabelRow, labelEndColumn);

    tcLabelCell.merge();
    nameLabelCell.merge();
    fatherLabelCell.merge();
    birthdayLabelCell.merge();
    langLabelCell.merge();

    tcLabelCell.setText('T.C. KİMLİK NO');
    nameLabelCell.setText('ADI SOYADI');
    fatherLabelCell.setText('BABA ADI');
    birthdayLabelCell.setText('DOĞUM TARİHİ');
    langLabelCell.setText('YABANCI DİL');

    _setTitle(cellStyle: tcLabelCell.cellStyle);
    _setTitle(cellStyle: nameLabelCell.cellStyle);
    _setTitle(cellStyle: fatherLabelCell.cellStyle);
    _setTitle(cellStyle: birthdayLabelCell.cellStyle);
    _setTitle(cellStyle: langLabelCell.cellStyle);

    final colonLabelCell = sheet.getRangeByIndex(tcLabelRow, labelEndColumn + 1, tcLabelRow + 4, labelEndColumn + 1);
    colonLabelCell.setText(':');
    _setTitle(cellStyle: colonLabelCell.cellStyle);

    final tcCell = sheet.getRangeByIndex(tcLabelRow, labelEndColumn + 2, tcLabelRow, endColumn - 1);
    final nameCell = sheet.getRangeByIndex(tcLabelRow + 1, labelEndColumn + 2, tcLabelRow + 1, endColumn - 1);
    final fatherCell = sheet.getRangeByIndex(tcLabelRow + 2, labelEndColumn + 2, tcLabelRow + 2, endColumn - 1);
    final birthCell = sheet.getRangeByIndex(tcLabelRow + 3, labelEndColumn + 2, tcLabelRow + 3, endColumn - 1);
    final langCell = sheet.getRangeByIndex(tcLabelRow + 4, labelEndColumn + 2, tcLabelRow + 4, endColumn - 1);
    tcCell.merge();
    nameCell.merge();
    fatherCell.merge();
    birthCell.merge();
    langCell.merge();

    tcCell.setText(student.tcKimlik ?? '');
    nameCell.setText(student.studentName ?? '');
    fatherCell.setText(student.fatherName ?? '');
    birthCell.setText(student.birthDay ?? '');
    langCell.setText('İNGİLİZCE');

    // Sınav Yeri Bilgileri:
    final sinavYeriRow = photoEndRow + 2;
    final sinavYeriStartColumn = startColumn + 1;
    final sinavYeriEndColumn = endColumn - 1;

    final sinavYeriCell = sheet.getRangeByIndex(sinavYeriRow, sinavYeriStartColumn, sinavYeriRow, sinavYeriEndColumn);
    sinavYeriCell.merge();
    sinavYeriCell.setText('SINAVA GİRECEĞİ YER');

    _setTitle(cellStyle: sinavYeriCell.cellStyle);

    final iliLabelRow = sinavYeriCell.row + 1;
    final binaAdiLabelRow = iliLabelRow + 1;
    final binaAdresiLabelRow = binaAdiLabelRow + 1;
    final iliLabelStartColumn = sinavYeriStartColumn;
    final iliLabelEndColumn = sinavYeriStartColumn + 4;
    final sinavYeriInfoTwoDotColumn = iliLabelEndColumn + 1;

    final ilStartColumn = sinavYeriInfoTwoDotColumn + 1;
    final ilEndColumn = ilStartColumn + 8;

    final ilceLabelStartColumn = ilEndColumn + 1;
    final ilceLabelEndColumn = ilceLabelStartColumn + 2;

    final iliLabelCell = sheet.getRangeByIndex(iliLabelRow, iliLabelStartColumn, iliLabelRow, iliLabelEndColumn);
    final binaAdiLabelCell =
        sheet.getRangeByIndex(binaAdiLabelRow, iliLabelStartColumn, binaAdiLabelRow, iliLabelEndColumn);
    final binaAdresiLabelCell =
        sheet.getRangeByIndex(binaAdresiLabelRow, iliLabelStartColumn, binaAdresiLabelRow, iliLabelEndColumn);

    final sinavYeriInfoTwoDotCell =
        sheet.getRangeByIndex(iliLabelRow, sinavYeriInfoTwoDotColumn, binaAdresiLabelRow, sinavYeriInfoTwoDotColumn);

    final ilceLabelCell = sheet.getRangeByIndex(iliLabelRow, ilceLabelStartColumn, iliLabelRow, ilceLabelEndColumn);
    final ilceLabelTwoDotCell = sheet.getRangeByIndex(iliLabelRow, ilceLabelEndColumn + 1);
    iliLabelCell.merge();
    binaAdiLabelCell.merge();
    binaAdresiLabelCell.merge();
    ilceLabelCell.merge();

    iliLabelCell.setText('İLİ');
    binaAdiLabelCell.setText('BİNA ADI');
    binaAdresiLabelCell.setText('BİNA ADRESİ');
    ilceLabelCell.setText('İLÇESİ');
    ilceLabelTwoDotCell.setText(':');

    sinavYeriInfoTwoDotCell.setText(':');

    _setTitle(cellStyle: iliLabelCell.cellStyle);
    _setTitle(cellStyle: binaAdiLabelCell.cellStyle);
    _setTitle(cellStyle: binaAdresiLabelCell.cellStyle);
    _setTitle(cellStyle: ilceLabelCell.cellStyle);
    _setTitle(cellStyle: ilceLabelTwoDotCell.cellStyle);
    _setTitle(cellStyle: sinavYeriInfoTwoDotCell.cellStyle);

    final iliCell = sheet.getRangeByIndex(iliLabelRow, ilStartColumn, iliLabelRow, ilEndColumn);
    final binaAdiCell = sheet.getRangeByIndex(binaAdiLabelRow, ilStartColumn, binaAdiLabelRow, endColumn - 1);
    final binaAdresiCell = sheet.getRangeByIndex(binaAdresiLabelRow, ilStartColumn, binaAdresiLabelRow, endColumn - 1);
    final ilceCell = sheet.getRangeByIndex(iliLabelRow, ilceLabelEndColumn + 2, iliLabelRow, endColumn - 1);

    iliCell.merge();
    binaAdiCell.merge();
    binaAdresiCell.merge();
    ilceCell.merge();

    iliCell.setText('ARTVİN');
    binaAdiCell.setText('YAVUZ SELİM ORTAOKULU');
    binaAdresiCell.setText('ORTAHOPA MAHALLESİ 160/A');
    ilceCell.setText('HOPA');

    // Table:
    final table1Row = binaAdresiLabelRow + 2;
    final table2Row = table1Row + 1;
    final table3Row = table2Row + 1;

    final oturumTitleStrColumn = startColumn + 1;
    final oturumTitleEndColumn = oturumTitleStrColumn + 3;
    final oturumTitleCell = sheet.getRangeByIndex(table1Row, oturumTitleStrColumn, table1Row, oturumTitleEndColumn);
    final oturum1Cell = sheet.getRangeByIndex(table2Row, oturumTitleStrColumn, table2Row, oturumTitleEndColumn);
    final oturum2Cell = sheet.getRangeByIndex(table3Row, oturumTitleStrColumn, table3Row, oturumTitleEndColumn);
    oturumTitleCell.merge();
    oturum1Cell.merge();
    oturum2Cell.merge();
    oturumTitleCell.setText('Oturum');
    oturum1Cell.setText('1');
    oturum2Cell.setText('2');
    _setTitle(cellStyle: oturumTitleCell.cellStyle);

    final saatTitleStrColumn = oturumTitleEndColumn + 1;
    final saatTitleEndColumn = saatTitleStrColumn + 3;
    final saatTitleCell = sheet.getRangeByIndex(table1Row, saatTitleStrColumn, table1Row, saatTitleEndColumn);
    final saat1Cell = sheet.getRangeByIndex(table2Row, saatTitleStrColumn, table2Row, saatTitleEndColumn);
    final saat2Cell = sheet.getRangeByIndex(table3Row, saatTitleStrColumn, table3Row, saatTitleEndColumn);
    saatTitleCell.merge();
    saat1Cell.merge();
    saat2Cell.merge();
    saatTitleCell.setText('Sınav Saati');
    saat1Cell.setText('09.30');
    saat2Cell.setText('11.30');
    _setTitle(cellStyle: saatTitleCell.cellStyle);

    final salonTitleStrColumn = saatTitleEndColumn + 1;
    final salonTitleEndColumn = salonTitleStrColumn + 3;
    final salonTitleCell = sheet.getRangeByIndex(table1Row, salonTitleStrColumn, table1Row, salonTitleEndColumn);
    final salon1Cell = sheet.getRangeByIndex(table2Row, salonTitleStrColumn, table2Row, salonTitleEndColumn);
    final salon2Cell = sheet.getRangeByIndex(table3Row, salonTitleStrColumn, table3Row, salonTitleEndColumn);
    salonTitleCell.merge();
    salon1Cell.merge();
    salon2Cell.merge();
    salonTitleCell.setText('Salon No');
    salon1Cell.setNumber(double.parse(student.salonNo!));
    salon2Cell.setNumber(double.parse(student.salonNo!));
    _setTitle(cellStyle: salonTitleCell.cellStyle);

    final siraTitleStrColumn = salonTitleEndColumn + 1;
    final siraTitleEndColumn = siraTitleStrColumn + 3;
    final siraTitleCell = sheet.getRangeByIndex(table1Row, siraTitleStrColumn, table1Row, siraTitleEndColumn);
    final sira1Cell = sheet.getRangeByIndex(table2Row, siraTitleStrColumn, table2Row, siraTitleEndColumn);
    final sira2Cell = sheet.getRangeByIndex(table3Row, siraTitleStrColumn, table3Row, siraTitleEndColumn);
    siraTitleCell.merge();
    sira1Cell.merge();
    sira2Cell.merge();
    siraTitleCell.setText('Sıra No');
    sira1Cell.setNumber(double.parse(student.siraNo!));
    sira2Cell.setNumber(double.parse(student.siraNo!));
    _setTitle(cellStyle: siraTitleCell.cellStyle);

    final sinavSuresiTitleStrColumn = siraTitleEndColumn + 1;
    final sinavSuresiTitleEndColumn = sinavSuresiTitleStrColumn + 3;
    final sinavSuresiTitleCell =
        sheet.getRangeByIndex(table1Row, sinavSuresiTitleStrColumn, table1Row, sinavSuresiTitleEndColumn);

    final sinavSuresi1Cell =
        sheet.getRangeByIndex(table2Row, sinavSuresiTitleStrColumn, table2Row, sinavSuresiTitleEndColumn);
    final sinavSuresi2Cell =
        sheet.getRangeByIndex(table3Row, sinavSuresiTitleStrColumn, table3Row, sinavSuresiTitleEndColumn);
    sinavSuresiTitleCell.merge();
    sinavSuresi1Cell.merge();
    sinavSuresi2Cell.merge();
    sinavSuresiTitleCell.setText('Sınav Süresi');
    sinavSuresi1Cell.setText('75 dk.');
    sinavSuresi2Cell.setText('80 dk.');
    _setTitle(cellStyle: sinavSuresiTitleCell.cellStyle);

    //Onay:
    final onayStartRow = table1Row;
    final onayEndRow = table2Row + 1;
    final onayStartColumn = sinavSuresiTitleEndColumn + 1;
    final onayEndColumn = endColumn - 1;

    final onayCell = sheet.getRangeByIndex(onayStartRow, onayStartColumn, onayEndRow, onayEndColumn);
    onayCell.merge();
    onayCell.setText('ONAY');
    onayCell.cellStyle.fontColor = '#FF0000';
    final mudurCell = sheet.getRangeByIndex(onayEndRow + 1, onayStartColumn, onayEndRow + 1, onayEndColumn);
    mudurCell.merge();
    mudurCell.setText('Okul Müdürü');

    _helper.setStyle(style: onayCell.cellStyle, fontSize: 16, isBold: true);
    _helper.setStyle(style: mudurCell.cellStyle, fontSize: 11);

    final thirdAreaCell = sheet.getRangeByIndex(table1Row, startColumn + 1, table3Row, endColumn - 1);
    thirdAreaCell.cellStyle.hAlign = HAlignType.center;

    // Açıklamalar
    final uyariRow = sinavSuresi2Cell.row + 1;
    final uyariCell = sheet.getRangeByIndex(uyariRow, startColumn + 1, uyariRow, sinavSuresiTitleEndColumn);
    uyariCell.merge();
    uyariCell.setText('UYARILAR');
    _setTitle(cellStyle: uyariCell.cellStyle);

    final aciklamaStartRow = uyariRow + 1;
    final aciklamaEndRow = aciklamaStartRow + 2;
    final aciklamaCell = sheet.getRangeByIndex(aciklamaStartRow, startColumn + 1, aciklamaEndRow, endColumn - 1);

    aciklamaCell.setText(
        'Not: Kimlik kontrolleri ve salonlara yerleştirmenin zamanında yapılabilmesi için öğrenciler en geç 09.00\'da sınava girecekleri binada hazır bulunacaktır.Öğrenciler sınava gelirken yanlarında geçerli kimlik belgesi(T.C Kimlik numaralı nüfus cüzdanı veya T.C. kimlik kartı veya geçerlilik süresi devam eden pasaport, yabancı uyruklu öğrenciler için İçişleri Bakanlığı Göç İdaresi Genel Müdürlüğü tarafından verilen resimli, mühürlü kimlik belgesi) ile en az iki adet koyu siyah ve  yumuşak kurşun kalem, kalemtraş ve leke bırakmayan yumuşak silgi bulunduracaktır.');
    aciklamaCell.merge();

    _helper.setStyle(style: aciklamaCell.cellStyle, fontSize: 8, hAlign: HAlignType.left, vAlign: VAlignType.top);
    aciklamaCell.cellStyle.wrapText = true;
    /*   sheet.getRangeByIndex(studentRow, 1).rowHeight = 10;
    sheet.getRangeByIndex(studentRow + 1, 5).setNumber(double.parse(student.studentNumber!));
    sheet.getRangeByIndex(studentRow, 2, studentRow + 9, 4).merge(); */

    //sheet.pictures.addStream(studentRow + 1, 3, imageData);
  }

  void _setAllBorder(Worksheet sheet, int startRow, int startColumn, int endColumn, int endRow) {
    sheet.getRangeByIndex(startRow, startColumn, startRow, endColumn).cellStyle.borders.top.lineStyle =
        LineStyle.medium;
    sheet.getRangeByIndex(startRow, startColumn, endRow, startColumn).cellStyle.borders.left.lineStyle =
        LineStyle.medium;
    sheet.getRangeByIndex(startRow, endColumn, endRow, endColumn).cellStyle.borders.right.lineStyle = LineStyle.medium;
    sheet.getRangeByIndex(endRow, startColumn, endRow, endColumn).cellStyle.borders.bottom.lineStyle = LineStyle.medium;

    // FirstArea
    sheet.getRangeByIndex(startRow + 1, startColumn + 1, startRow + 1, endColumn - 1).cellStyle.borders.top.lineStyle =
        LineStyle.thin;
    sheet
        .getRangeByIndex(startRow + 10, startColumn + 1, startRow + 10, endColumn - 1)
        .cellStyle
        .borders
        .bottom
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 1, startColumn + 1, startRow + 10, startColumn + 1)
        .cellStyle
        .borders
        .left
        .lineStyle = LineStyle.thin;

    sheet.getRangeByIndex(startRow + 1, endColumn - 1, startRow + 10, endColumn - 1).cellStyle.borders.right.lineStyle =
        LineStyle.thin;
    sheet
        .getRangeByIndex(startRow + 4, startColumn + 1, startRow + 4, endColumn - 1)
        .cellStyle
        .borders
        .bottom
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 12, startColumn + 1, startRow + 12, endColumn - 1)
        .cellStyle
        .borders
        .top
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 15, startColumn + 1, startRow + 15, endColumn - 1)
        .cellStyle
        .borders
        .bottom
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 12, startColumn + 1, startRow + 15, startColumn + 1)
        .cellStyle
        .borders
        .left
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 12, endColumn - 1, startRow + 15, endColumn - 1)
        .cellStyle
        .borders
        .right
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 17, startColumn + 1, startRow + 20, endColumn - 12)
        .cellStyle
        .borders
        .all
        .lineStyle = LineStyle.thin;
    sheet
        .getRangeByIndex(startRow + 21, startColumn + 1, startRow + 23, endColumn - 1)
        .cellStyle
        .borders
        .all
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 17, startColumn + 21, startRow + 17, endColumn - 1)
        .cellStyle
        .borders
        .top
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 17, endColumn - 1, startRow + 20, endColumn - 1)
        .cellStyle
        .borders
        .right
        .lineStyle = LineStyle.thin;

    sheet
        .getRangeByIndex(startRow + 20, startColumn + 21, startRow + 20, endColumn - 1)
        .cellStyle
        .borders
        .bottom
        .lineStyle = LineStyle.thin;
  }

  void _setTitle({required Style cellStyle, bool isCenter = false}) {
    _helper.setStyle(
      style: cellStyle,
      fontSize: 11,
      isBold: true,
      hAlign: isCenter ? HAlignType.center : HAlignType.left,
    );
  }

  Future<List<int>?> _readImageData(String name) async {
    try {
      final ByteData data = await rootBundle.load('images/students/$name');
      return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    } catch (e) {
      return null;
    }
  }
}
