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
  1. **Input Nama Pengguna**: Pengguna dapat memasukkan nama sebelum memulai kuis untuk personalisasi hasil.
  2. **Navigasi Multi-Halaman**: Perpindahan mulus antara *Welcome Screen*, *Quiz Screen*, *Result Screen*, dan *About Screen*.
  3. **Manajemen State Terpusat**: Menggunakan `Provider` (`QuizProvider`) untuk mengelola progres kuis, skor, jawaban yang dipilih, dan navigasi soal secara real-time.
  4. **Reusable Widgets**: Komponen UI berulang seperti pilihan jawaban (`QuizOptionCard`) dan kartu skor (`ScoreCard`) dipisahkan menjadi modular reusable widgets.
  5. **Responsif & Adaptif**: Desain UI menggunakan `SingleChildScrollView` dan `LayoutBuilder` untuk mencegah *overflow* pada berbagai ukuran layar.
  6. **Font & Kustomisasi Branding**: Menggunakan font kustom **Poppins** dan skema warna kustom (*Burgundy*, *Peach*, *Dusty Rose*, *Cream*).

---

## 📚 Documentation

### 1. Credit Sumber Aset & Library
- **Font**: Google Fonts (Poppins)
- **Ilustrasi & Logo**: Desain kustom Squizhy Branding & Illustration assets (`assets/images/`).
- **State Management**: `provider: ^6.1.5`

### 2. Screenshot Halaman Aplikasi
| Welcome Screen | Quiz Screen | Result Screen | About Screen |
| :---: | :---: | :---: | :---: |
| *(Masukkan screenshot Welcome Screen)* | *(Masukkan screenshot Quiz Screen)* | *(Masukkan screenshot Result Screen)* | *(Masukkan screenshot About Screen)* |

### 3. Link Mockup / Prototype
- [Link Figma / Mockup Design (Opsional/Sesuai Tugas)](https://figma.com)

---

## 🎯 Presentation Outline (5 Menit)
1. **Fungsionalitas Aplikasi**: Demonstrasi alur dari memasukkan nama, menjawab pertanyaan kuis, hingga melihat skor akhir di halaman hasil.
2. **Responsivitas**: Menunjukkan kemampuan aplikasi menyesuaikan layout pada berbagai orientasi dan ukuran layar.
3. **Alur & Implementasi Kode**: Menjelaskan struktur arsitektur proyek, penggunaan `StatelessWidget` dan `StatefulWidget`, pemisahan `reusable widgets`, serta penerapan `Provider` untuk state management.
