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
function import(path);local f = io.open("storage/emulated/0/Android/media/launcher.powerkuy.growlauncher/scriptLua/"..path..".lua","r");local code = f:read("*a");f:close();return load(code)();end

local UI = import("LucUI") -- require sama dofile ga bisa

--- @param config table {Name: string, Title: string, Icon: number, DefaultColor: string, BorderColor: string|table, BG: string|table, UseEleIcon: boolean, EleID: number}
local myMenu = UI:New({
    Name = "shop_menu",
    Title = "`wDiamond Shop",
    Icon = 242,
    DefaultColor = "`o",
    BG = {255,255,255,255}, -- Warna custom RGBA
    BorderColor = "success"   -- Menggunakan preset
})

--- @param size string "small" or "big"
--- function Library:Spacer(size)
      :Spacer("small")
      
--- @param text string The text to display
--- @param size string "big" or "small"
--- @param icon number Item ID
--- @param eleId number Element ID/Extra ID
      :LabelEle("`#Limited Edition Item", "big",1430, 0)
      
--- @param text string The text content
--- @param size string "small" or "big"
--- @param color string Format "r,g,b,a" (e.g., "255,255,0,255")
--- function Library:CustomText(text, size, color)
      :CustomText("Promo berakhir dalam 2 jam!", "small", "255,0,0,255")
      
--- @param size string "small" or "big"
--- function Library:Spacer(size)
      :Spacer("small")
      
--- @param text string The text content
--- @param alignment string "left", "center", or "right"
--- function Library:Text(text, alignment)      
      :Text("Beli Blue Gem Lock dengan harga spesial hari ini saja!")
      
--- @param data table {Name: string, Text: string, UseIcon: boolean, Scaling: string, Frame: number, Icon: number, Amount: number, EndList: boolean}
--- function Library:Button(data)
      :Button({
          Name = "buy_dl", 
          Icon = 1796,
          UseIcon = true, 
          Text = "Beli Sekarang", 
          Scaling = "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
          Amount = 1,
      })
      
--- @param data table {Name: string, Text: string, UseIcon: boolean, Scaling: string, Frame: number, Icon: number, Amount: number, EndList: boolean}      
--- function Library:Button(data)
      :Button({
          Name = "buy_bgl",
          Text = "Beli Sekarang",
          UseIcon = true,
          Icon = 7188,
          Scaling = "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
          EndList = true
      })
      
--- @param size string "small" or "big"
--- function Library:Spacer(size)
      :Spacer("small")
      
--- @param text string The text content
--- function Library:SmallText(text)      
      :SmallText("`4*Penyalahgunaan sistem dapat terkena ban.")

--- @param cancelText string Text for the left button (optional)
--- @param confirmText string Text for the right button (default: "OK")
--- @param quickExit boolean If true, adds a close 'X' button at the bottom
--- function Library:Build(cancelText, confirmText, quickExit)
myMenu:Build("Close", "Proceed") 
