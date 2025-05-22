#!/bin/bash

# Nama executable yang dihasilkan oleh CMake (sesuai add_executable(server ...))
EXECUTABLE_NAME="server"

# Path relatif ke direktori root proyek
# Sesuaikan ini jika struktur direktori Anda berbeda
# Misalnya, jika Anda menjalankan script ini dari direktori 'build',
# maka path-nya harus disesuaikan (misal: ../build/debug/bin)
RELEASE_PATH="build/release/bin"
DEBUG_PATH="build/debug/bin"

# Tentukan path executable default (Debug)
EXEC_DIR="$DEBUG_PATH"
BUILD_TYPE="Debug"

# Periksa argumen baris perintah
if [ "$1" == "--release" ]; then
    EXEC_DIR="$RELEASE_PATH"
    BUILD_TYPE="Release"
fi

FULL_EXECUTABLE_PATH="./$EXEC_DIR/$EXECUTABLE_NAME"

echo "Mencoba menjalankan executable $BUILD_TYPE: $FULL_EXECUTABLE_PATH"

# Periksa apakah executable ada
if [ -f "$FULL_EXECUTABLE_PATH" ]; then
    # Jalankan executable
    "$FULL_EXECUTABLE_PATH"
else
    echo "Error: Executable $BUILD_TYPE tidak ditemukan di $FULL_EXECUTABLE_PATH"
    echo "Pastikan Anda sudah menjalankan './build_debug.sh' atau './build_release.sh' terlebih dahulu."
    exit 1
fi

