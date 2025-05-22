cmake_minimum_required(VERSION 3.10)  # Versi minimum CMake yang dibutuhkan
project(GTDroid)                   # Nama proyek

# Tambahkan baris ini untuk melihat nilai CMAKE_BUILD_TYPE saat konfigurasi
message(STATUS "Configuring for CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# Atur versi dan bahasa
set(CMAKE_CXX_STANDARD 20)

add_executable(server
	src/main.cpp)
# Menambahkan target executable dan file sumbernya

# Tambahkan direktori include eksternal
target_include_directories(server PRIVATE
	${CMAKE_SOURCE_DIR}/src/libs/enet_growtopia/include
)

# Tambahkan direktori tempat .lib berada
link_directories(
	${CMAKE_SOURCE_DIR}/src/libs/enet_growtopia/lib
)

# Tambahkan file .lib ke target
target_link_directories(server PRIVATE
	${CMAKE_SOURCE_DIR}/src/libs/enet_growtopia/lib
)
target_link_libraries(server PRIVATE
	enet
)
# Khusus windows
if (WIN32)
	target_link_libraries(server PRIVATE
		ws2_32
	)
endif()

# Mendefinisikan makro preprocessor 'DEBUG' hanya untuk konfigurasi build Debug.
# Ini menggunakan "generator expression" yang modern dan robust.
target_compile_definitions(server PRIVATE
    $<$<CONFIG:Debug>:DEBUG> # Define DEBUG only for Debug configuration
)

# Menentukan direktori output untuk executable berdasarkan konfigurasi build
# CMAKE_BINARY_DIR adalah direktori tempat CMake dijalankan (misalnya build/debug atau build/release)
# Ini akan membuat executable di:
#   build/target/bin/
set_target_properties(server PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

# Jika Anda juga memiliki library, Anda bisa menggunakan properti yang serupa:
# ARCHIVE_OUTPUT_DIRECTORY untuk library statis (.a, .lib)
# LIBRARY_OUTPUT_DIRECTORY untuk library dinamis (.so, .dll)
# set_target_properties(my_library PROPERTIES
#     ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
#     LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
# )

