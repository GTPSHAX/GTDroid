# GTDroid
server enet sederhana untuk Growtopia private server yang dibuat dengan Android(termux)

Ini hanyalah projek iseng untuk mencoba mengembangkan batas kemampuan saya, saya sebelumnya memang selalu menggunakan smartphone dengan VPS untuk mengerjakan sebuah codingan, tetapi kali ini saya ingin mencoba langsung menggunakan smartphone tanpa vm ataupun cloud.

## Instalasi
1. Unduh package yang dibutuhkan
```bash
pkg install git clang make cmake
```
2. Clone repository ini
```bash
git clone https://github.com/GTPSHAX/GTDroid.git
```
3. Build project

Untuk pertamakalinya, harus diberi izin terlebih dahulu
```bash
chmod -x ./build.sh && chmod -x ./build.release.sh && chmod -x run.sh
```
Buid dengan debug mode
```bash
./build.sh
```
Build dengan release mode
```bash
./build.release.sh
```
4. Jalankan aplikasi
```bash
./run.sh #--release #tambahkan args release untuk menjalankan release mode
```
