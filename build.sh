#!/bin/bash

# Nama direktori build untuk debug
BUILD_DIR="build/debug"

echo "Memulai build mode Debug..."

# Cek apakah direktori CMakeCache.txt berbeda atau sumber tidak cocok
cmake_check=$(cmake ../.. -DCMAKE_BUILD_TYPE=Debug 2>&1)
if [[ "$cmake_check" =~ "CMake Error: The current CMakeCache.txt directory" || "$cmake_check" =~ "CMake Error: The current \"" ]]; then
    echo "Terdeteksi inkonsistensi cache CMake. Membersihkan dan mencoba lagi..."
    rm -rf "$BUILD_DIR"
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR" || { echo "Gagal masuk ke direktori $BUILD_DIR"; exit 1; }
    cmake ../.. -DCMAKE_BUILD_TYPE=Debug
else
    echo "Konfigurasi CMake berhasil atau tidak ada error cache yang terdeteksi."
fi

# Membuat direktori build jika belum ada
mkdir -p "$BUILD_DIR"

# Pindah ke direktori build
cd "$BUILD_DIR" || { echo "Gagal masuk ke direktori $BUILD_DIR"; exit 1; }

# Menjalankan CMake untuk mengkonfigurasi proyek dalam mode Debug
# '..' mengacu pada direktori 'build'
# '../..' mengacu pada direktori root proyek (my_cpp_project) tempat CMakeLists.txt berada
echo "Menjalankan CMake untuk konfigurasi Debug..."
cmake ../.. -DCMAKE_BUILD_TYPE=Debug

# Membangun proyek
echo "Membangun proyek..."
cmake --build .

# Kembali ke direktori root proyek
cd ../..

echo "Build mode Debug selesai. Executable dapat ditemukan di $BUILD_DIR"

