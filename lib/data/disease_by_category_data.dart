import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/models/disease_category_model.dart';

List<DiseaseByCategoryModel> diseaseCategory = [
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nKepala",
    diseaseCategory: "Penyakit Kepala",
    icon: Mdi.head_outline,
  ),
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nTelinga",
    diseaseCategory: "Penyakit Telinga",
    icon: '',
  ),
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nMata",
    diseaseCategory: "Penyakit Mata",
    icon: Fa.eye,
  ),
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nPernapasan",
    diseaseCategory: "Penyakit Pernafasan",
    icon: MedicalIcon.i_respiratory,
  ),
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nJantung",
    diseaseCategory: "Penyakit Jantung",
    icon: Healthicons.heart_cardiogram,
  ),
  DiseaseByCategoryModel(
    displayDiseaseName: "Penyakit\nPencernaan",
    diseaseCategory: "Penyakit Perut",
    icon: Mdi.stomach,
  ),
];
