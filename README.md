# Squizhy - Multiple Choice Quiz Mobile App

A playful, engaging, and elegant multiple-choice quiz application built with Flutter as part of the Mobile Programming Lab UTS (Mid-Term Exam).

---

## 👨‍🎓 Student Identity
- **Nama**: [Nama Mahasiswa]
- **NIM**: [NIM Mahasiswa]
- **Lab**: [Lab Pemrograman Mobile]

---

## 📱 Application Information
- **Nama Aplikasi**: Squizhy
- **Deskripsi Singkat**: Squizhy adalah aplikasi kuis pilihan ganda interaktif yang dirancang untuk menguji pengetahuan pengguna dalam berbagai kategori (Sains, Geografi, Teknologi, Matematika, dan Pengetahuan Umum) dengan antarmuka yang modern, dinamis, dan ramah pengguna.
- **Fitur-Fitur Utama**:
  1. **Input Nama Pengguna & Random Quiz**: Pengguna memasukkan nama dan mendapatkan kategori kuis secara acak (Wawasan Umum, Matematika Dasar, atau Computer Science).
  2. **Craft & Share Custom Quiz**: Pengguna/Guru dapat merancang kuis sendiri dan membagikan kode unik (misal `SQZ-4821`) ke pengguna lain untuk dikerjakan.
  3. **Quiz Answer Report**: Laporan jawaban lengkap di akhir kuis dengan status benar/salah dan penjelasan (*explanation*).
  4. **Manajemen State Terpusat**: Menggunakan `Provider` (`QuizProvider`) untuk mengelola progres, skor, dan navigasi secara real-time.
  5. **Reusable Widgets**: Komponen pilihan jawaban (`QuizOptionCard`) dan kartu skor (`ScoreCard`) dipisahkan menjadi modular reusable widgets.
- **✨ Fitur Responsif & Adaptif**:
  - Desain UI dilengkapi *constrained container* (`max-width: 600px`), memastikan tampilan tetap rapi, proporsional, dan tidak meregang terlalu lebar saat dijalankan di perangkat tablet atau browser web.

---

## 📚 Documentation

### 1. Credit Sumber Aset & Library
- **Font**: Google Fonts (Poppins)
- **Ilustrasi & Logo**: Desain kustom Squizhy Branding & Illustration assets (`assets/images/`).
- **State Management**: `provider: ^6.1.5`

### 2. Screenshot Halaman Aplikasi
| Welcome Screen | Quiz & Report Screen | Craft Quiz & Share Code |
| :---: | :---: | :---: |
| *(Screenshot Welcome)* | *(Screenshot Report)* | *(Screenshot Craft Quiz)* |

### 3. Link Mockup / Prototype
- [Link Figma / Mockup Design](https://figma.com)

---

## 🎯 Presentation Outline (5 Menit)
1. **Fungsionalitas Aplikasi**: Demonstrasi alur kuis standar (random kategori), pembuatan kuis kustom dengan kode, serta laporan jawaban di akhir.
2. **Responsivitas**: Menunjukkan adaptivitas tampilan aplikasi pada berbagai ukuran layar (mobile & web/tablet view).
3. **Alur & Implementasi Kode**: Menjelaskan arsitektur `Provider`, penggunaan widget modular, dan struktur kode yang bersih.
