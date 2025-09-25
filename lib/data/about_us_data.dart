class AboutUsData {
  final String introduction =
      "Diagnocare merupakan sebuah aplikasi kesehatan yang dirancang sebagai asisten digital bagi masyarakat dalam mendapatkan berbagai informasi kesehatan dengan cepat, mudah, valid dan relevan. Aplikasi ini menyediakan berbagai fitur utama dan pendukung, seperti prediksi penyakit, rekomendasi obat, toko online, pendeteksi fasilitias kesehatan dan chatbot yang terintegrasi dengan Gemini AI yang dapat membantu pengguna dalam berkonsultasi. Aplikasi ini dapat digunakan sebagai penanganan awal terhadap penyakit yang memiliki gejala ringan hingga sedang. Namun, pengguna juga harus tetap melakukan konsultasi dengan dokter, jika penyakit tidak kunjung sembuh.";
  final String featureApps =
      """Diagnocare dibangun menggunakan teknologi kecerdasan buatan (AI) untuk menganalisis gejala yang sedang dialami oleh pengguna, memberikan prediksi penyakit, memberikan rekomendasi obat yang tepat, serta menawarkan fitur tambahan yang sangat berguna, seperti pembelian obat, pencarian fasilitas kesehatan terdekat, dan chatbot interaktif.
\n1. Prediksi Penyakit Berbasis Teks
Pengguna dapat memasukkan deskripsi gejala yang dirasakan. Sistem akan memproses teks tersebut menggunakan model Bidirectional LSTM (BiLSTM) yang memahami konteks kalimat dari dua arah.
\t\t\t\t\t> Memanfaatkan tokenisasi dan word embedding
\t\t\t\t\t> Prediksi penyakit berdasarkan konteks kata
\t\t\t\t\t> Data augmentation untuk variasi input

\n2. Rekomendasi dan Toko Obat
Setelah prediksi ditampilkan, aplikasi juga merekomendasikan obat yang relevan dan memungkinkan pengguna untuk membeli obat secara langsung. Rekomendasi obat pada aplikasi ini dikembangkan dengan menggunakan salah satu metode machine learning, yakni content-based filtering yang akan membandingkan satu obat dengan obat yang lainnya. Rekomendasi obat yang disajikan pada aplikasi ini didapatkan dari hasil diskusi dengan 10 dokter umum yang memiliki pengetahuan lebih mendalam terkait kesehatan. Fitur ini dapat diakses oleh pengguna menggunakan 2 cara berbeda, yakni dengan melakukan prediksi terhadap penyakit terlebih dahulu atau langsung mengakses salah satu jenis penyakit yang telah disediakan oleh aplikasi.
\t\t\t\t\t> Informasi lengkap obat seperti fungsi dan dosis
\t\t\t\t\t> Integrasi dengan toko atau apotek online

\n3. Lokasi Fasilitas Kesehatan Terdekat
Diagnocare menggunakan lokasi pengguna untuk menampilkan daftar fasilitas kesehatan terdekat.
\t\t\t\t\t> Rumah sakit, puskesmas, klinik, apotek
\t\t\t\t\t> Alamat, jarak, dan rute ke lokasi

\n4. Chatbot Medis (API Gemini)
Chatbot Diagnocare memanfaatkan Gemini API dari Google untuk menjawab pertanyaan seputar gejala, penyakit, dan tips kesehatan secara real-time.
\t\t\t\t\t> Respons cepat dan kontekstual
\t\t\t\t\t> Dapat diakses 24 jam sebagai asisten kesehatan pribadi""";

  final String coreTech =
      """Aplikasi ini dikembangkan dengan menggunakan beberapa teknologi, seperti:
\t1. Android Native atau Flutter
\t2. Natural Language Processing (NLP)
\t3. Bidirectional LSTM (BiLSTM)
\t4. Content-Based Filtering
\t5. Data Augmentation
\t6. Geolocation dan Maps API
\t7. Integrasi Gemini API
\t8. Token-based Authentication""";
}
