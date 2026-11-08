# Squizhy App

## 👨‍🎓 Student Identity
- **Nama**: Najla Az Zahra Tanjung
- **NIM**: 241401136
- **Lab**: Lab Pemrograman Mobile

---

## 📱 Application Information
- **Nama Aplikasi**: Squizhy
- **Deskripsi Singkat**: Squizhy adalah aplikasi kuis pilihan ganda. Pengguna memasukkan nama, menjawab serangkaian pertanyaan dari kategori yang dipilih acak, lalu melihat skor akhir atas namanya beserta laporan jawaban.
- **Fitur-Fitur Utama**:
1. **Input nama dan kuis acak**: pengguna memasukkan nama, lalu mendapat kategori acak (Wawasan Umum, Matematika Dasar, atau Computer Science field).
2. **Quiz Answer Report**: laporan benar/salah per soal beserta penjelasan.
3. **Custom Quiz**: pengguna membuat kuis sendiri (judul, soal, empat opsi, kunci jawaban, penjelasan) dan mendapat kode kuis. Kuis dimainkan lewat menu *Enter Quiz Code*. Karena data disimpan lokal tanpa database, kode hanya berlaku selama aplikasi berjalan.
4. **State management dengan Provider**: progres jawaban tetap aman saat layar dirotasi atau berpindah halaman.
5. **Konfirmasi keluar kuis** saat tombol silang atau tombol back ditekan.
6. **Tampilan responsif**: ukuran elemen dihitung dari ukuran layar (bukan nilai tetap), dan konten dibatasi lebar maksimal 600 agar tetap rapi di tablet dan browser.
7. **Reusable widget**: `QuizOptionCard`, `ScoreCard`, dan dialog konfirmasi keluar dipisah ke folder `widgets`.

---

## 📚 Documentation

### 1. Credit Sumber Aset & Library
- **Font**: [Poppins](https://fonts.google.com/specimen/Poppins) oleh Indian Type Foundry, via Google Fonts (SIL Open Font License), dibundel lokal di `assets/fonts/`.
- **Logo & Ilustrasi**: Dibuat sendiri menggunakan generative AI ChatGPT, tersimpan di `assets/images/`.
- **Ikon**: [Material Icons](https://fonts.google.com/icons) bawaan Flutter.
- **State Management**: [`provider`](https://pub.dev/packages/provider) `^6.1.5`.

### 2. Screenshot Halaman Aplikasi
- [Google Drive](https://drive.google.com/drive/folders/1_jyscMFy5cv6wIyN2wnYvq-kFuOVXYzA).

### 3. Link Mockup / Prototype
- [Desain Figma Squizhy](https://www.figma.com/design/kiemYfzNP3LyOGoR8P1aKp/Squizhy_App?node-id=0-1)
