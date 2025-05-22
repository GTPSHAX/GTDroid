// src/main.cpp
#include <iostream>
#include "enet/enet.h"

int main() {
    std::cout << "Aplikasi dimulai..." << std::endl;

    // Bagian kode yang hanya akan aktif di mode Debug
#ifdef DEBUG
    std::cout << "------------------------------------------" << std::endl;
    std::cout << "MODE DEBUG AKTIF: Menampilkan informasi tambahan dan melakukan operasi yang mungkin lambat." << std::endl;
    std::cout << "------------------------------------------" << std::endl;

    if (enet_initialize() != 0) {
        std::cerr << "Failed to initialize ENet.\n";
        return EXIT_FAILURE;
    }

    atexit(enet_deinitialize); // cleanup saat keluar

    ENetAddress address;
    address.host = ENET_HOST_ANY;
    address.port = 17091;

    ENetHost* server = enet_host_create(&address, 32, 2, 0, 0);
    if (!server) {
        std::cerr << "Failed to create ENet server.\n";
        return EXIT_FAILURE;
    }
    server->usingNewPacketForServer = true;
    server->checksum = enet_crc32;
    enet_host_compress_with_range_coder(server);

    std::cout << "ENet server listening on port 17091...\n";

    ENetEvent event;
    while (true) {
        while (enet_host_service(server, &event, 1000) > 0) {
            switch (event.type) {
                case ENET_EVENT_TYPE_CONNECT:
                    std::cout << "Client connected from "
                              << (event.peer->address.host & 0xFF) << "."
                              << ((event.peer->address.host >> 8) & 0xFF) << "."
                              << ((event.peer->address.host >> 16) & 0xFF) << "."
                              << ((event.peer->address.host >> 24) & 0xFF) << ":"
                              << event.peer->address.port << "\n";
                    break;

                case ENET_EVENT_TYPE_RECEIVE:
                    std::cout << "Packet received (" << event.packet->dataLength << " bytes)\n";
                    enet_packet_destroy(event.packet);
                    break;

                case ENET_EVENT_TYPE_DISCONNECT:
                    std::cout << "Client disconnected.\n";
                    break;

                default:
                    break;
            }
        }
    }

    enet_host_destroy(server);
#else
    // Bagian kode yang hanya akan aktif di mode Release
    std::cout << "------------------------------------------" << std::endl;
    std::cout << "MODE RELEASE AKTIF: Fokus pada performa dan ukuran, tanpa informasi debugging." << std::endl;
    std::cout << "------------------------------------------" << std::endl;

    // Contoh: Kode yang dioptimalkan atau tidak ada logging verbose
    // Tidak ada jeda waktu atau logging ekstra di sini untuk performa
    std::cout << "Release: Menjalankan operasi inti dengan cepat." << std::endl;

#endif

    std::cout << "Aplikasi selesai." << std::endl;
    return 0;
}

