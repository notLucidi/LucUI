# 🛠 LucUI - Dialog Builder

**LucUI** atau Lucifer UI adalah library growlauncher dirancang khusus untuk membuat dialog di dalam game growtopia lebih mudah tanpa menulis string dialog yang banyak dan panjang. dengan LucUI ini code dialog kamu jadi lebih clean. 

## Feature:
- **Method Chaining**: Membuat dialog hanya dengan satu blok code bersambung
- **Preset Colors**: Preset warna untuk dialog menjadi berwarna, {"primary","success","danger"}

## Documents:
### 1. UI:New(config)
Fungsi konstruktor untuk menginisialisasi dialog baru.
* **@param config (table)**:
    * `Name` (string): ID unik dialog untuk identifikasi respon.
    * `Title` (string): Teks judul utama dialog.
    * `Icon` (number): ID Item sebagai ikon utama di header.
    * `DefaultColor` (string): Kode warna teks default (misal: `o`).
    * `BorderColor` (string/table): Warna tepi dialog (nama preset atau `{R,G,B,A}`).
    * `BG` (string/table): Warna latar belakang (nama preset atau `{R,G,B,A}`).
    * `UseEleIcon` (boolean): Menggunakan `add_label_with_ele_icon` jika bernilai true.
  ```lua
local menu = UI:New({
    Name = "my_dialog",
    Title = "Admin Panel",
    Icon = 242,
    DefaultColor = "`w"
})
  ```

### 2. Checkbox(id, text, state)
Menambahkan elemen pilihan biner (centang).
* **@param id (string)**: ID unik untuk mengambil data state checkbox.
* **@param text (string)**: Label deskripsi di samping kotak.
* **@param state (number)**: Kondisi awal (`0` untuk kosong, `1` untuk tercentang).

### 3. Input(id, text, length, maxLength)
Menambahkan kolom input teks untuk interaksi pengguna.
* **@param id (string)**: ID unik untuk mengambil hasil input teks.
* **@param text (string)**: Teks instruksi di depan kolom input.
* **@param length (number)**: Panjang visual kotak input (skala 1-3).
* **@param maxLength (number)**: Batas maksimal karakter yang dapat diinput.

### 4. Button(data)
Menambahkan tombol interaktif, mendukung penggunaan ikon item.
* **@param data (table)**:
    * `Name` (string): ID tombol saat diklik.
    * `Text` (string): Tulisan di dalam tombol.
    * `UseIcon` (boolean): Aktifkan untuk menampilkan ikon item.
    * `Icon` (number): ID item untuk ikon tombol.
    * `Amount` (string): Angka jumlah pada ikon.
    * `Scaling` (string): Ukuran skala ikon/teks.
    * `EndList` (boolean): Jika true, akan menambahkan penutup baris ikon (`END_LIST`).

### 5. CustomText(text, size, color)
Menampilkan teks dengan format warna dan ukuran spesifik.
* **@param text (string)**: Konten teks yang ditampilkan.
* **@param size (string)**: Ukuran font (contoh: "small").
* **@param color (string)**: String warna RGBA (contoh: "255,255,0,255").

### 6. Build(cancelText, confirmText, quickExit)
Menyusun seluruh elemen menjadi paket data final dan mengirimkannya melalui `SendVariant`.
* **@param cancelText (string)**: Teks tombol batal (kiri).
* **@param confirmText (string)**: Teks tombol konfirmasi (kanan).
* **@param quickExit (boolean)**: Jika true, menambahkan tombol silang (X) untuk menutup dialog.

---

## Contoh Implementasi

Berikut adalah contoh pembuatan dialog pengaturan dunia menggunakan Method Chaining:

```lua
local UI = require("UILibrary")

UI:New({
    Name = "world_settings",
    Title = "World Configuration",
    Icon = 242,
    BorderColor = "primary"
})
:Spacer("small")
:Text("Silakan atur konfigurasi akses dunia di bawah ini:")
:Checkbox("public_access", "Izinkan akses publik", 0)
:Input("min_level", "Level Minimal: ", 1, 3)
:Spacer("small")
:Button({
    Name = "save_settings",
    Text = "Simpan Perubahan",
    UseIcon = true,
    Icon = 32,
    EndList = true
})
:Build("Batal", "Simpan", true)
