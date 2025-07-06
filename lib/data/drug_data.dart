import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/models/drug_model.dart';

List<DrugModel> drugs = [
  DrugModel(
    displayDrugName: "Penyakit\nKepala",
    drugCategory: "Sakit Kepala",
    icon: Mdi.head_outline,
  ),
  DrugModel(
    displayDrugName: "Penyakit\nTelinga",
    drugCategory: "Sakit Telinga",
    icon: "",
  ),
  DrugModel(
    displayDrugName: "Penyakit\nMata",
    drugCategory: "Sakit Mata",
    icon: Fa.eye,
  ),
  DrugModel(
    displayDrugName: "Penyakit\nPernapasan",
    drugCategory: "Sakit Pernafasan",
    icon: MedicalIcon.i_respiratory,
  ),
  DrugModel(
    displayDrugName: "Penyakit\nJantung",
    drugCategory: "Sakit Jantung",
    icon: Healthicons.heart_cardiogram,
  ),
  DrugModel(
    displayDrugName: "Penyakit\nPencernaan",
    drugCategory: "Sakit Perut",
    icon: Mdi.stomach,
  ),
];
