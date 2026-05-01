## 🛡️ Terminal Termux Login

Sistem keamanan akses terminal berbasis shell yang dirancang untuk memberikan lapisan perlindungan tambahan pada sesi terminal Anda. Dikembangkan oleh **123Tool**, alat ini memastikan bahwa hanya pengguna sah yang dapat mengakses lingkungan shell Anda.

![Developer](https://img.shields.io/badge/Developer-123Tool-blue)
![Environment](https://img.shields.io/badge/Env-Termux%20%7C%20Linux-orange)
![Security](https://img.shields.io/badge/Status-Active%20Vault-success)

## 📋 Fitur Utama
- **Automated Registration:** Sistem pendaftaran mandiri saat pertama kali dijalankan.
- **Encrypted Local Vault:** Menyimpan data kredensial secara lokal menggunakan file tersembunyi.
- **Recovery System:** Pemulihan akses melalui Security Key jika lupa password.
- **Uninstaller Management:** Fitur pencopotan sistem secara otomatis tanpa merusak shell environment.

## 🚀 Panduan Instalasi

Ikuti langkah-langkah di bawah ini untuk pemasangan di Termux atau Linux:

1. **Clone:**
   ```bash
   git clone https://github.com/123tool/Termux-Login-V1.git
   cd Termux-Login-V1
2. **Eksekusi**
   ```
   chmod +x login.sh
3. **Terminal**
   ```
   echo "bash $HOME/terminal-gatekeeper/login.sh" >> ~/.bashrc

## Penggunaan

1. Registrasi Akun
​Saat pertama kali dijalankan, sistem akan meminta Anda membuat Username, Password, dan Security Key. Pastikan Security Key disimpan di tempat yang aman untuk kebutuhan pemulihan

2. Menu Utama ​Sistem menyediakan tiga opsi navigasi :
​- Login : Masuk ke sesi terminal menggunakan kredensial Anda.
- Forgot : Memulihkan username/password menggunakan Security Key.
- Remove : Menghapus seluruh sistem kunci dari terminal Anda (membutuhkan password admin).

## ​🛡️ Catatan Keamanan

​Data otentikasi disimpan di file $HOME/.vault_db. Untuk perlindungan ekstra, sangat disarankan untuk mengatur izin akses file tersebut menjadi privat :
```
chmod 600 ~/.vault_db
```


## ⚠️ Disclaimer

**​Untuk tujuan keamanan terminal. Segala bentuk kehilangan akses akibat melupakan Password dan Security Key secara bersamaan berada di luar tanggung jawab pengembang.**
