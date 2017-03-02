program Aplikasi_Array_Statis_Data_Warga;
{I.S. : User memilih menu pilihan }
{F.S. : Memproses data sesuai menu pilihan user }
uses crt;

const
     // MAKS_DATA menyimpan jumlah maksimal data yang bisa disimpan
     MAKS_DATA = 50;
type
     // Deklarasi tipe data Warga berupa record
     Warga = record
           Nama, Agama, Status : string;
           NIK, Umur : integer;
     end;
     // Deklarasi tipe data ArrayWarga berupa array of record yang menyimpan
     // data dari record Warga
     ArrayWarga = array [1..MAKS_DATA] of Warga;
var                       
     // DataWarga array yang menyimpan semua data dari record Warga
     DataWarga : ArrayWarga;
     // NamaWarga menyimpan nama yang ingin dicari user
     NamaWarga : string;
     // JumlahData menyimpan banyaknya data yang akan diolah
     JumlahData : integer;
     // Menu menyimpan pilihan menu user
     Menu : integer;

procedure BuatArrayWarga(var DataWarga : ArrayWarga);
{I.S. : Setiap field pada array DataWarga, diberi harga awal agar siap digunakan}
{F.S. : Menghasilkan array DataWarga yang siap digunakan}
var
   i : integer;
begin
     // Melakukan perulangan untuk mengakses tiap baris dari array DataWarga
     for i :=  1 to MAKS_DATA do
     begin
          // Memberi harga awal untuk setiap field pada array DataWarga
          DataWarga[i].Nama := '/';
          DataWarga[i].Agama := '/';
          DataWarga[i].Status := '/';
          DataWarga[i].Umur := 0;  
          DataWarga[i].NIK := 0;
     end;
end;

procedure HancurkanArrayWarga(var DataWarga : ArrayWarga; JumlahData : integer);
{I.S. : Mengembalikan nilai field tiap array ke nilai awal }
{F.S. : Menghasilkan array DataWarga dengan nilai awal }
var
   i : integer;
begin
     // Melakukan perulangan untuk mengakses tiap baris dari array DataWarga
     for i :=  1 to JumlahData do
     begin
          // Memberi harga awal untuk setiap field pada array DataWarga
          DataWarga[i].Nama := '/';
          DataWarga[i].Agama := '/';
          DataWarga[i].Status := '/';
          DataWarga[i].Umur := 0; 
          DataWarga[i].NIK := 0;
     end;
end;

procedure MenuPilihan (var Menu : integer);
{I.S. : User memilih salah satu menu }
{F.S. : Menghasilkan menu yang dipilih }
begin
     // Menampilkan pilihan-pilihan menu yang tersedia dalam aplikasi
     gotoxy(25,8);write ('            MENU PILIHAN           ');
     gotoxy(25,9);write ('===================================');
     gotoxy(25,11);write('1. Isi Data Warga');
     gotoxy(25,12);write('2. Cari Data Berdasarkan Nama Warga');
     gotoxy(25,13);write('3. Tampil Data Warga');
     gotoxy(25,14);write('0. Keluar');

     // Meminta user memasukkan menu yang dipilih
     gotoxy(25,16);write('MENU YANG ANDA PILIH : ');
     readln(Menu);

     // Melakukan validasi menu
     while (Menu < 0) or (Menu > 3) do
     begin
          gotoxy(25,17);textcolor(4);
          write('MENU TIDAK DITEMUKAN!');
          readln;textcolor(7);
          gotoxy(25,17);clreol;
          gotoxy(48,16);clreol;
          readln(Menu);
     end;
end;

procedure IsiDataWarga(var DataWarga : ArrayWarga; var JumlahData : integer);
{I.S. : User memasukkan jumlah data warga yang ingin dimasukkan }
{F.S. : Menghasilkan array DataWarga[1..JumlahData]] }
var
   i : integer;
begin
     clrscr;
     // Memberi harga awal untuk setiap field dalam DataWarga
     BuatArrayWarga(DataWarga);

     // Meminta user memasukkan jumlah data warga
     write('Banyaknya Data Warga : ');readln(JumlahData);

     // Melakukan validasi jumlah data warga
     while (JumlahData < 0) or (JumlahData > MAKS_DATA) do
     begin
          textcolor(4);
          write('JUMLAH DATA WARGA TIDAK BOLEH KURANG DARI 0 ATAU LEBIH DARI ', MAKS_DATA,'!');
          readln; textcolor(7);
          gotoxy(1,2); clreol;
          gotoxy(24,1); clreol; readln(JumlahData);
     end;

     clrscr;
     gotoxy(35,1);write('DATA WARGA');
     gotoxy(35,2);write('==========');
     gotoxy(1,4);
     writeln('--------------------------------------------------------------------------');
     writeln('|        NIK        |        NAMA        | UMUR |    AGAMA    |  STATUS  |');
     writeln('--------------------------------------------------------------------------');

     // Melakukan perulangan sampai dengan banyaknya JumlahData
     // untuk mengakses tiap baris dari array DataWarga
     for i := 1 to JumlahData do
     begin
          gotoxy(1,i+6);
          writeln('|                   |                    |      |             |          |');
          // Meminta user memasukkan data warga
          gotoxy(3,i+6); readln(DataWarga[i].NIK);
          gotoxy(23,i+6); readln(DataWarga[i].Nama);
          gotoxy(45,i+6); readln(DataWarga[i].Umur);
          gotoxy(51,i+6); readln(DataWarga[i].Agama);
          gotoxy(65,i+6); readln(DataWarga[i].Status);
     end;
     writeln('--------------------------------------------------------------------------');
     write('Tekan enter untuk melanjutkan!');
     readln;
end;

function CekString(NamaData, NamaDicari : string) : boolean;
{I.S. : Nama pada data dan Nama yang dicari sudah terdefenisi }
{F.S. : Menghasilkan nilai true apabila Nama yang dicari ditemukan di Nama pada data}
var
   // Ketemu meyimpan kondisi apakah yang dicari sudah ditemukan?
   Ketemu : boolean;
   // posawal posisi kursor awal untuk memotong string Nama Warga dari array
   posawal : integer;
begin
     posawal := 1;
     Ketemu := false;

     // Cek apa posawal kurang dari panjang Nama di data
     // dikurangi panjang Nama yang dicari + 1
     while(posawal <= (length(NamaData) - length(NamaDicari) + 1)) do
     begin
          // Cek apa Nama yang dicari sama dengan potongan Nama
          // pada data yang diawali dari posawal dan sebanyak
          // panjang (Nama yang dicari) karakter
          if((upcase(NamaDicari) = upcase(copy(NamaData,posawal,length(NamaDicari))))
                                and (length(NamaDicari) <> 0)) then
          begin
               // Paksa loop untuk berhenti jika kondisi diatas benar
               Ketemu := true;
               break;
          end
          else
              // Menambahkan posawal dengan 1
              inc(posawal);
     end;
     CekString := Ketemu;
end;

procedure CariNama(DataWarga : ArrayWarga; NamaWarga : string; JumlahData : integer);
{I.S. : Nama Warga yang dicari sudah terdefinisi }
{F.S. : Menampilkan data yang memiliki penggalan nama warga sama seperti yang
        dimasukkan user }
var
   // Baris merupakan posisi baris ke berapa data harus ditampilkan di layar
   Baris, i  : integer;
   // Ketemu menyimpan kondisi apakah nama yang dicari ada pada array?
   Ketemu    : boolean;
begin
     Ketemu := false;
     i := 1;

     // Cek apa data yang dicari belum ketemu dan i kurang dari
     // sama dengan JumlahData
     while(not Ketemu) and (i <= JumlahData) do
     begin
          // Cek apa nama yang dicari ketemu?
          if(CekString(DataWarga[i].Nama, NamaWarga)) then
          begin
               Ketemu := true;
               break;
          end
          else
               // Menambahkan i dengan 1
               inc(i);
     end;

     // Cek apa ketemu bernilai true?
     if(Ketemu) then
     begin
          clrscr;
          gotoxy(35,1);write('DATA WARGA');
          gotoxy(35,2);write('==========');
          gotoxy(1,4); write('Warga dengan nama ', NamaWarga, ' :');
          gotoxy(1,6);
          writeln('--------------------------------------------------------------------------');
          writeln('|        NIK        |        NAMA        | UMUR |    AGAMA    |  STATUS  |');
          writeln('--------------------------------------------------------------------------');
          Baris := 8;
          i := 1;
          // Cek apa i kurang dari sama dengan jumlah data?
          while (i <= JumlahData) do
          begin
               if(CekString(DataWarga[i].Nama, NamaWarga)) then
               begin
                    // Menampilkan data dengan Nama yang dicari
                    gotoxy(1,Baris+1);
                    write('|                   |                    |      |             |          |');
                    gotoxy(3,Baris+1); write(DataWarga[i].NIK);
                    gotoxy(23,Baris+1); write(DataWarga[i].Nama);
                    gotoxy(45,Baris+1); write(DataWarga[i].Umur);
                    gotoxy(51,Baris+1); write(DataWarga[i].Agama);
                    gotoxy(65,Baris+1); writeln(DataWarga[i].Status);
                    inc(Baris);
               end;
               inc(i);
          end;
          writeln('--------------------------------------------------------------------------');
     end
     else
     begin
          clrscr; textcolor(4);
          write('WARGA DENGAN NAMA ', NamaWarga, ' TIDAK DITEMUKAN!'); textcolor(7);
     end;
     write('Tekan enter untuk melanjutkan!');
     readln;
end;

procedure InsertionSort(var DataWarga : ArrayWarga; JumlahData : integer);
{I.S. : Array DataWarga sudah terdefinisi }
{F.S. : Menghasilkan array DataWarga yang sudah diurut secara descending berdasarkan NIK }
var
   // Temp variabel bantuan untuk melakukan pertukaran elemen array
   Temp : Warga;
   i, j : integer;
begin
     // Melakukan perulangan untuk mengakses tiap baris
     // array dimulai dari indeks 2
     for i := 2 to JumlahData do
     begin
          Temp := DataWarga[i];
          j := i;
          // Melakukan perulangan pengecekan, apakah
          // DataWarga[i-1] < DataWarga[i], jika benar maka dilakukan
          // pertukaran elemen array
          while(j > 1) and (DataWarga[j-1].NIK < Temp.NIK) do
          begin
               DataWarga[j] := DataWarga[j-1];
               dec(j);
          end;
          DataWarga[j] := Temp;
     end;
end;

procedure TampilData(DataWarga : ArrayWarga; JumlahData : integer);
{I.S. : Array data warga sudah terdefinisi }
{F.S. : Menampilkan data warga yang sudah terurut secara descending berdasarkan NIK }
var
    i : integer;
begin
     InsertionSort(DataWarga,JumlahData);
     clrscr;
     gotoxy(35,1);write('DATA WARGA');
     gotoxy(35,2);write('==========');
     gotoxy(1,4);
     writeln('--------------------------------------------------------------------------');
     writeln('|        NIK        |        NAMA        | UMUR |    AGAMA    |  STATUS  |');
     writeln('--------------------------------------------------------------------------');
     // Melakukan loop untuk mengakses setiap baris dari array DataWarga
     for i := 1 to JumlahData do
     begin
          // Menampilkan semua data warga yang tersimpan pada array DataWarga
          gotoxy(1,i+6);
          write('|                   |                    |      |             |          |');
          gotoxy(3,i+6); write(DataWarga[i].NIK);
          gotoxy(23,i+6); write(DataWarga[i].Nama);
          gotoxy(45,i+6); write(DataWarga[i].Umur);
          gotoxy(51,i+6); write(DataWarga[i].Agama);
          gotoxy(65,i+6); writeln(DataWarga[i].Status);
     end;
     writeln('--------------------------------------------------------------------------');
     write('Tekan enter untuk melanjutkan!');
     readln;
end;

// Program utama
begin
     // Memberikan nilai 0 pada JumlahData sebagai tanda data masih kosong
     JumlahData := 0;

     // Melakukan perulangan menampilkan menu pilihan hingga user
     // memasukkan menu 0
     repeat
           clrscr;
           MenuPilihan(Menu);

           // Memproses pilihan user sesuai dengan menu yang dipilih
           case (Menu) of
                1 : IsiDataWarga(DataWarga, JumlahData);
                2 : if not (JumlahData = 0) then
                    begin
                         clrscr;
                         write('Nama warga yang dicari : ');readln(NamaWarga);
                         CariNama(DataWarga,NamaWarga,JumlahData);
                    end
                    else
                    begin
                         clrscr; textcolor(4); gotoxy(10,12);
                         write('DATA BELUM DITEMUKAN, SILAKAN MENGISI DATA TERLEBIH DAHULU!');
                         textcolor(7);readln;
                    end;
                3 : if not (JumlahData = 0) then
                         TampilData(DataWarga,JumlahData)
                    else
                    begin
                         clrscr; textcolor(4); gotoxy(10,12);
                         write('DATA BELUM DITEMUKAN, SILAKAN MENGISI DATA TERLEBIH DAHULU!');
                         textcolor(7);readln;
                    end;
           end;
     until(Menu=0);
     // Menghancurkan array DataWarga karena sudah tidak terpakai
     HancurkanArrayWarga(DataWarga, JumlahData);
end.
