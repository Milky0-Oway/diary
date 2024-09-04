format PE GUI 4.0
entry WinMain

include 'win32a.inc'
include 'encoding\WIN1251.INC'
include 'api\riched32.inc'

section '.data' data readable writeable

define  LF_FACESIZE     32

struct CHARFORMAT
       cbSize           dd      ?
       dwMask           dd      ?
       dwEffects        dd      ?
       yHeight          dd      ?
       yOffset          dd      ?
       crTextColor      dd      ?
       bCharSet         db      ?
       bPitchAndFamily  db      ?
                        dw      ?     
       szFaceName       db      LF_FACESIZE dup(?)
       wWeight          dw      ?
       sSpacing         dw      ?
       crBackColor      dd      ?
       lcid             dd      ?
       dwReserved       dw      ?
       sStyle           dw      ?
       wKerning         dw      ?
       bUnderlineType   db      ?
       bAnimation       db      ?
       bRevAuthor       db      ?
       bReserved1       db      ?
                        dw      ?
ends

struct PARAFORMAT
       cbSize           dd      ?
       dwMask           dd      ?
       wNumbering       dw      ?
       wReserved        dw      ?
       dxStartIndent    dd      ?
       dxRightIndent    dd      ?
       bCharSet         dd      ?
       wAlignment       dw      ?
       cTabCount        dw      ?
       rgxTabs          dd      LF_FACESIZE dup(?)
       dySpaceBefore    dd      ?
       dySpaceAfter     dd      ?
       dyLineSpacing    dd      ?
       sStyle           dw      ?
       bLineSpacingRule db      ?
       bOutlineLevel    db      ?
       wShadingWeight   dw      ?
       wShadingStyle    dw      ?
       wNumberingStart  dw      ?
       wNumberingStyle  dw      ?
       wNumberingTab    dw      ?
       wBorderSpace     dw      ?
       wBorderWidth     dw      ?
       wBorders         dw      ?
ends

struct EDITSTREAM
       dwCookie         dd      ?
       dwError          dd      ?
       pfnCallback      dd      ?
ends

struct CHARRANGE
       cpMin            dd      ?
       cpMax            dd      ?
ends

struct FINDTEXT
       chrg           CHARRANGE ?
       lpstrText        dd      ?
       chrgText       CHARRANGE ?
ends

struct SETTEXTEX
       flags           dw      ?
                       dw      ?
       codepage        dd      ?
ends

define MIN_X  600
define MIN_Y 700

define ID_DE 1002
define ID_AD 1003
define IDC_BACKCOLORBOX 1000
define IDC_TEXTCOLORBOX 1001
define IDC_BOLD 1004
define IDC_ITALIC 1005
define IDC_UP 1006
define IDC_DOWN 1007
define IDC_ALIGNC 1008
define IDC_ALIGNL 1009
define IDC_ALIGNR 1010
define IDC_FONT 1011
define IDC_MARKER 1012
define IDC_UNDERLINE 1013
define IDC_DOWN 1014
define IDC_UP 1015
define IDC_MATCHCASE 1016
define IDC_WHOLEWORD 1017
define IDC_FINDEDIT 1018
define IDC_REPLACEEDIT 1019
define IDC_LINENO 1020

define IDM_MAIN 101
define IDA_MAIN 201
define IDI_MAIN 401

define IDD_FINDDLG 501
define IDD_REPLACEDLG 502
define IDD_GOTODLG 503

define IDM_NEW 1101
define IDM_OPEN 1102
define IDM_SAVE 1103
define IDM_SAVEAS 1104
define IDM_RECENT_FILE 1105
define IDM_EXIT 1111

define IDM_LNEW 1301
define IDM_LOPEN 1302
define IDM_LSAVE 1303

define IDM_UNDO 1201
define IDM_CUT 1202
define IDM_COPY 1203
define IDM_PASTE 1204
define IDM_DELETE 1205
define IDM_SELECTALL 1206

define IDM_FIND 1401
define IDM_REPLACE 1402
define IDM_GOTOLINE 1403

define buff_size 256

RichEditDLL db 'riched20.dll', 0

title db 'Ежедневник',0
class db 'FASMWIN32',0
untitled db 'Без имени',0
bmp1 db '1.bmp',0
bmp2 db '3.bmp',0
bmp3 db '7.bmp',0
bmp4 db '8.bmp',0
bmp5 db '9.bmp',0
bmp6 db '10.bmp',0
bmp7 db '11.bmp',0
bmp8 db '12.bmp',0
bmp9 db '5.bmp',0
recent db 'Last files.txt',0
_edit db 'RichEdit20A',0
_listbox db 'LISTBOX', 0
_button db 'BUTTON',0
_static db 'STATIC',0 
nofnc db 'Не работает',0
errtxt db 'Код ошибки: %u',0
errbuf rb $-errtxt+10
opentittle db 'Открытие файла',0
openfilter db 'Text',0,'*.rtf*',0,0
lopenfilter db 'Text',0,'*.txt*',0,0
savetittle db 'Сохранение',0
confirmmsg db 'Файл не сохранён, сохранить его?',0
displayname db 'Сохранение',0
curfont db 'Arial',0
bytesread dw 0
filename rb MAX_PATH
pfilename rb MAX_PATH
lfilename rb MAX_PATH
buf db 100 dup ?
bolds db 0
italics db 0
unders db 0
aligns db 1
index db ?
hwnd dd ?         
hmenu dd ?
hedit dd ?
hlist dd ?
heditadd dd ?
heditdel dd ?
hbutadd dd ?
hbutdel dd ?
hbutsort dd ?
hbackcolor dd ?
hback dd ?
htextcolor dd ?
htext dd ?
hacc dd ?
hrichedit dd ?
hfile dd ?
hbutbold dd ?
hbutitalic dd ?
hbutunderline dd ?
hbutup dd ?
hbutdown dd ?
hbutalignc dd ?
hbutalignl dd ?
hbutalignr dd ?
hbutmarker dd ?
htfont dd ?
hfont dd ?
hHeap dd ?
hHeapList dd ?
hsearch dd ?
colors dd 16 dup ?
backgroundcolor dd 0x00FFFFFF
textcolor dd 0
buff db buff_size dup ?
bufff rb 256
resent_files dd 7 dup 0
current_files db 0 
temp rb 2 
read dw ?
widechar_buffer rb 256
linefeed db 10, 0
findbuf db 256 dup ?
replacebuf db 256 dup ?
flag dd ?
empty db '',0

;picts db '{\rtf1{\pict\dibitmap ',0

_tdelbut db 'Удалить',0
_taddbut db 'Добавить',0
_tsortbut db 'Отсортировать',0
_tbackcolor db 'Цвет фона:',0
_ttextcolor db 'Цвет текста:',0
_tfont db 'Шрифт:',0


;marker

wc WNDCLASS 0,WindowProc,0,0,0,0,0,COLOR_BTNFACE+1,0,class
client RECT
menuinfo MENUITEMINFO sizeof.MENUITEMINFO,MIIM_STATE
color CHOOSECOLOR
font CHOOSEFONT
lf LOGFONT
charf CHARFORMAT
paraf PARAFORMAT
;charf CHARFORMAT sizeof.CHARFORMAT,CFM_COLOR or CFM_BOLD or CFM_ITALIC,0,10,0,0,0,0,0
editstream EDITSTREAM
ofn OPENFILENAME
findtext FINDTEXT
settext SETTEXTEX

section '.code' code readable executable

proc is_utf8, tstr
  push esi edi ebx
  mov esi,[tstr]
;По умолчанию строка соответствует формату
  mov ebx,1
.loc_scan:
  lodsb
;Окончание строки?
  test al,al
  jz .loc_ret

;Проверка символов [0x00-0x7F]
  cmp al,07Fh
  jbe .loc_scan

;Проверка двухсимвольной конструкции
;0xD0[0x81|0x90-0xBF]
  cmp al,0D0h
  jne @f
  lodsb
  cmp al,81h
  je .loc_scan
  cmp al,90h
  jb .loc_fail
  cmp al,0BFh
  ja .loc_fail
  jmp .loc_scan
@@:
;Проверка двухсимвольной конструкции
;0xD1[0x91|0x80-0x8F]
  cmp al,0D1h
  jne .loc_fail
  lodsb
  cmp al,91h
  je .loc_scan
  cmp al,80h
  jb .loc_fail
  cmp al,8Fh
  jbe .loc_scan

.loc_fail:
;Строка не соответствует формату
  xor ebx,ebx

.loc_ret:
  mov eax,ebx
  pop ebx edi esi
  ret
endp


proc ReadMenu
  lea edi,[resent_files]
  invoke CreateFile,recent,GENERIC_READ+GENERIC_WRITE,FILE_SHARE_READ+FILE_SHARE_WRITE,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  ;cmp eax, INVALID_HANDLE_VALUE
  ;je .err
  mov [hfile],eax
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi],eax
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi+4],eax
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi+8],eax
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi+12],eax 
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi+16],eax
  invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  mov [edi+20],eax
  xor ebx,ebx
.re:
  invoke RtlZeroMemory,buff,256
  lea esi,[buff]
  mov [read],0
.readd:
  invoke ReadFile,[hfile],temp,1,read,0
  test eax,eax
  je .fi
  cmp [read],0
  je .fi
  cmp [temp],10
  je .endoflinee
  movzx eax,[temp]
  mov [esi], al
  inc esi
  jmp .readd 
.endoflinee:
  ;dec esi
  inc ebx
  cmp ebx,6
  je .fi
  mov byte [esi],0 
  stdcall is_utf8,buff
  test eax,eax
  jz .ad
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  invoke lstrcpy,[edi],bufff
  add edi,4
  ;invoke MessageBox,0,bufff,0,MB_OK
  jmp .re
.ad:
  ;invoke MessageBox,0,buff,0,MB_OK
  ;invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  ;push eax
  invoke lstrcpy,[edi],buff
  ;pop dword [edi] 
  add edi,4
  jmp .re
.fi:
  mov byte [esi],0
  stdcall is_utf8,buff
  test eax,eax
  jz .addd
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  ;invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  ;push eax
  invoke lstrcpy,[edi],bufff
  ;pop dword [edi]  
  jmp .fin
.addd: 
  ;invoke MessageBox,0,buff,0,MB_OK
  ;invoke HeapAlloc, [hHeap], HEAP_GENERATE_EXCEPTIONS or HEAP_ZERO_MEMORY, 256
  ;push eax
  invoke lstrcpy,[edi],buff
  ;pop dword [edi] 
.fin:
  invoke CloseHandle,[hfile]
  ret
endp

proc FillMenu
  ;push edi
.fill:
  invoke GetMenu,[hwnd]
  mov esi,eax
  invoke GetSubMenu,esi,0
  mov ebx,eax
  invoke GetSubMenu,ebx,4  
  mov edi,eax
  invoke GetMenuItemCount,edi
  test eax,eax
  jz .no_items
  mov ebx,eax
.del: 
  dec ebx 
  invoke DeleteMenu,edi,ebx,MF_BYPOSITION
  test ebx,ebx
  jnz .del
.no_items:  
  lea esi,[resent_files]
  add esi,4
  mov ebx,IDM_RECENT_FILE
  inc ebx 
.addto:
  mov ecx,[esi]
  test ecx,ecx
  jz .finish 
  cmp byte [ecx],0
  je .finish
  invoke AppendMenu,edi,MF_STRING,ebx,ecx 
  add esi,4
  inc ebx
  jmp .addto 
.error_open:
  invoke GetLastError
  invoke wsprintf,errbuf,errtxt,eax
  invoke MessageBox,0,errbuf,0,MB_OK 
.finish:
  ;pop edi
  ret  
endp

;сохранение файла
proc SaveFile
  invoke lstrcmp,filename,empty
  test eax,eax
  jnz .saving
.o:  invoke RtlZeroMemory,ofn,sizeof.OPENFILENAME
  push edi
  pop [ofn.hwndOwner] 
  push [wc.hInstance]
  pop [ofn.hInstance]
  mov [ofn.lStructSize],sizeof.OPENFILENAME
  mov [ofn.lpstrFilter],openfilter 
  mov [ofn.nMaxFile],MAX_PATH
  mov [ofn.lpstrFile],filename
  mov [filename],0
  mov [ofn.Flags],OFN_FILEMUSTEXIST+OFN_HIDEREADONLY+OFN_PATHMUSTEXIST+OFN_NOCHANGEDIR
  invoke GetSaveFileName,ofn
  test eax,eax
  je .finish
.saving:  
  invoke CreateFile,filename,GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL
  cmp eax,INVALID_HANDLE_VALUE
  je .finish
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamOutProc
  invoke SendMessage,[hedit],EM_STREAMOUT,SF_RTF,editstream
;  cmp eax,0
;  je .h
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,filename
  jmp .finish
;  .h:
;   invoke GetLastError
;   invoke wsprintf,errbuf,errtxt,eax
;   invoke MessageBox,0,errbuf,0,MB_OK
.finish:
  ret
endp


proc StreamInProc hfile,pBuffer,NumBytes,pBytesRead
  invoke ReadFile,[hfile],[pBuffer],[NumBytes],[pBytesRead],0
  xor eax, 1                                             
  ret
endp



proc StreamOutProc hfile,pBuffer,NumBytes,pBytesWrite
  invoke WriteFile,[hfile],[pBuffer],[NumBytes],[pBytesWrite],0
  xor eax, 1                                             
  ret
endp


proc Confirmation
  invoke MessageBox,edi,confirmmsg,displayname,MB_YESNOCANCEL or MB_ICONQUESTION
  ret
endp


proc Search hwnd,wmsg,wparam,lparam
  mov esi,[hwnd]
  mov eax,[wmsg]
  cmp eax,WM_INITDIALOG
  je .wminitdialog
  cmp eax,WM_COMMAND
  je .wmcommand
  cmp eax,WM_CLOSE
  je .wmclose
  mov eax,FALSE
  ret
.wminitdialog:
  push esi
  pop [hsearch]
  invoke CheckRadioButton,esi,IDC_DOWN,IDC_UP,IDC_DOWN
  invoke SendDlgItemMessage,esi,IDC_FINDEDIT,WM_SETTEXT,0,findbuf
  jmp .finish
.wmcommand:
  mov eax,[wparam]
  shr eax,16
  cmp eax,BN_CLICKED
  jne .finish
  mov eax,[wparam]
  cmp ax,IDOK
  je .ok
  cmp ax,IDCANCEL
  je .cancel
  mov eax,FALSE
  ret
.ok:
  invoke SetFocus,[hedit]
  mov [flag],0
  invoke SendMessage,[hedit],EM_EXGETSEL,0,findtext.chrg
  invoke GetDlgItemText,esi,IDC_FINDEDIT,findbuf,256
  test eax,eax
  jz .finish
  invoke IsDlgButtonChecked,esi,IDC_DOWN
  cmp eax,BST_CHECKED
  jne .idcmatchcaseb
  or [flag],FR_DOWN
  mov eax,[findtext.chrg.cpMin]
  cmp eax,[findtext.chrg.cpMax]
  je .chrgmax
  push [findtext.chrg.cpMax]
	pop [findtext.chrg.cpMin]
.chrgmax:
  mov [findtext.chrg.cpMax],-1
  jmp .idcmatchcase
.idcmatchcaseb:
  mov [findtext.chrg.cpMax],0
.idcmatchcase:
  invoke IsDlgButtonChecked,esi,IDC_MATCHCASE
  cmp eax,BST_CHECKED
  jne .idcwholeword
  or [flag],FR_MATCHCASE
.idcwholeword:
  invoke IsDlgButtonChecked,esi,IDC_WHOLEWORD
  cmp eax,BST_CHECKED
  jne .find
  or [flag],FR_WHOLEWORD
.find:
  push findbuf 
  pop [findtext.lpstrText]
	invoke SendMessage,[hedit],EM_FINDTEXTEX,[flag],findtext
  cmp eax, -1
  je .finish
  invoke SendMessage,[hedit],EM_EXSETSEL,0,findtext.chrgText  
  jmp .finish
.cancel:
  invoke SendMessage,esi,WM_CLOSE,0,0
.wmclose:
  mov [hsearch],0
  invoke EndDialog,esi,0
  jmp .finish
.finish:
  mov eax,TRUE  
  ret
endp


proc Replace hwnd,wmsg,wparam,lparam
  mov esi,[hwnd]
  mov eax,[wmsg]
  cmp eax,WM_INITDIALOG
  je .wminitdialog
  cmp eax,WM_COMMAND
  je .wmcommand
  cmp eax,WM_CLOSE
  je .wmclose
  mov eax,FALSE
  ret
.wminitdialog:
  push esi
  pop [hsearch]
  ;invoke SetDlgItemText,esi,IDC_FINDEDIT,findbuf
  ;invoke SetDlgItemText,esi,IDC_REPLACEEDIT,cc,replacebuf
  jmp .finish
.wmcommand:
  mov eax,[wparam]
  shr eax,16
  cmp eax,BN_CLICKED
  jne .finish
  mov eax,[wparam]
  cmp ax,IDOK
  je .ok
  cmp ax,IDCANCEL
  je .cancel
  mov eax,FALSE
  ret
.ok:
  invoke SetFocus,[hedit]
  mov [flag],0
  invoke SendMessage,[hedit],EM_EXGETSEL,0,findtext.chrg
  invoke GetDlgItemText,esi,IDC_FINDEDIT,findbuf,256
  invoke GetDlgItemText,esi,IDC_REPLACEEDIT,replacebuf,256
  mov [findtext.chrg.cpMin],0
  mov [findtext.chrg.cpMax],-1
  push findbuf
	pop [findtext.lpstrText]
	mov [settext.flags],ST_SELECTION
	mov [settext.codepage],CP_ACP 
.replace:
  invoke SendMessage,[hedit],EM_FINDTEXTEX,FR_DOWN,findtext
  cmp eax,-1
  je .finish
  invoke SendMessage,[hedit],EM_EXSETSEL,0,findtext.chrgText
	invoke SendMessage,[hedit],EM_SETTEXTEX,settext,replacebuf
  jmp .replace 
.cancel:
  invoke SendMessage,esi,WM_CLOSE,0,0
.wmclose:
  mov [hsearch],0
  invoke EndDialog,esi,0
  jmp .finish
.finish:
  mov eax,TRUE  
  ret
endp


proc GoTo hwnd,wmsg,wparam,lparam
  mov esi,[hwnd]
  mov eax,[wmsg]
  cmp eax,WM_INITDIALOG
  je .wminitdialog
  cmp eax,WM_COMMAND
  je .wmcommand
  cmp eax,WM_CLOSE
  je .wmclose
  mov eax,FALSE
  ret
.wminitdialog:
  push esi
  pop [hsearch]
  jmp .finish
.wmcommand:
  mov eax,[wparam]
  shr eax,16
  cmp eax,BN_CLICKED
  jne .finish
  mov eax,[wparam]
  cmp ax,IDOK
  je .ok
  cmp ax,IDCANCEL
  je .cancel
  mov eax,FALSE
  ret
.ok:
  invoke GetDlgItemInt,esi,IDC_LINENO,NULL,FALSE
  dec eax
  mov ebx,eax
  invoke SendMessage,[hedit],EM_GETLINECOUNT,0,0
  cmp eax,ebx
  jle .finish
  invoke SendMessage,[hedit],EM_LINEINDEX,ebx,0
  invoke SendMessage,[hedit],EM_SETSEL,eax,eax
  invoke SetFocus,[hedit]
  jmp .finish 
.cancel:
  invoke SendMessage,esi,WM_CLOSE,0,0
.wmclose:
  mov [hsearch],0
  invoke EndDialog,esi,0
  jmp .finish
.finish:
  mov eax,TRUE  
  ret
endp


proc WinMain
  locals
    msg     MSG
  endl

  invoke GetModuleHandle,0
  mov [wc.hInstance],eax
  invoke LoadLibrary, RichEditDLL
  test eax,eax
  je error
  mov [hrichedit], eax
  invoke HeapCreate,HEAP_NO_SERIALIZE,0,0
  mov [hHeap], eax
  call ReadMenu
  invoke LoadIcon,[wc.hInstance],IDI_MAIN
  mov [wc.hIcon],eax 
  invoke LoadCursor,0,IDC_ARROW
  mov [wc.hCursor],eax
  invoke RegisterClass,wc
  test eax,eax
  je error
  invoke LoadAccelerators,[wc.hInstance],IDA_MAIN
  mov [hacc],eax   
  invoke LoadMenu,[wc.hInstance],IDM_MAIN
  mov [hmenu],eax
  invoke CreateWindowEx,0,class,title,WS_VISIBLE+WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,0,eax,[wc.hInstance],0
  test eax,eax
  je error
  mov [hwnd],eax
  call FillMenu
  invoke RegisterHotKey,[hwnd],IDM_NEW,MOD_CONTROL,'N'
  invoke RegisterHotKey,[hwnd],IDM_OPEN,MOD_CONTROL,'O'
  invoke RegisterHotKey,[hwnd],IDM_SAVE,MOD_CONTROL,'S'
  invoke RegisterHotKey,[hwnd],IDM_EXIT,MOD_CONTROL,'Q'
  invoke HeapCreate,HEAP_NO_SERIALIZE,0,0
  mov [hHeapList], eax
  lea edi, [msg]
msg_loop:
  invoke GetMessage,edi,0,0,0
  test eax,eax
  jz end_loop
  invoke TranslateAccelerator,[hwnd],hacc,edi
  test eax,eax
  jne msg_loop
  invoke TranslateMessage,edi
  invoke DispatchMessage,edi
  jmp msg_loop

error:
  invoke GetLastError
  invoke wsprintf,errbuf,errtxt,eax
  invoke MessageBox,0,errbuf,0,MB_OK

end_loop:
  invoke ExitProcess,[msg.wParam]
endp

proc WindowProc uses ebx esi edi, hwnd,wmsg,wparam,lparam
  mov eax,[wmsg]
  xor ebx,ebx
  mov edi,[hwnd]
  cmp eax,WM_GETMINMAXINFO
  je .wmgetminmaxinfo
  cmp eax,WM_COMMAND
  je .wmcommand
  cmp eax,WM_CREATE
  je .wmcreate
  cmp eax,WM_SIZE
  je .wmsize
  cmp eax,WM_SETFOCUS
  je .wmsetfocus
  cmp eax, WM_CTLCOLORSTATIC
  je .wmctlcolorstatic
  cmp eax,WM_CLOSE
  je .wmclose
  cmp eax,WM_DESTROY
  je .wmdestroy
  cmp eax,WM_NOTIFY
  je .wmnotify
  cmp eax,WM_HOTKEY
  je .wmhotkey

.defwndproc:
  invoke DefWindowProc,edi,[wmsg],[wparam],[lparam]
  jmp .finish

.wmgetminmaxinfo:
  mov esi, [lparam]
  mov [esi+MINMAXINFO.ptMinTrackSize.x],MIN_X
  mov [esi+MINMAXINFO.ptMinTrackSize.y],MIN_Y
  jmp .finish

.wmhotkey:
  mov eax,[wparam]
  cmp eax,IDM_NEW
  je .NEW
  cmp eax,IDM_OPEN
  je .OPEN
  cmp eax,IDM_SAVE
  je .SAVE
  cmp eax,IDM_EXIT
  je .wmclose
  jmp .finish

.wmcommand:
  mov eax,[wparam]
  cmp eax,IDM_NEW
  je .NEW
  cmp eax,IDM_OPEN
  je .OPEN
  cmp eax,IDM_SAVE
  je .SAVE
  cmp eax,IDM_SAVEAS
  je .SAVEAS
  cmp eax,IDM_RECENT_FILE+1
  je .RECENTFILE1
  cmp eax,IDM_RECENT_FILE+2
  je .RECENTFILE2
  cmp eax,IDM_RECENT_FILE+3
  je .RECENTFILE3
  cmp eax,IDM_RECENT_FILE+4
  je .RECENTFILE4
  cmp eax,IDM_RECENT_FILE+5
  je .RECENTFILE5
  cmp eax,IDM_EXIT
  je .wmclose
  cmp eax,IDM_LNEW
  je .LNEW
  cmp eax,IDM_LOPEN
  je .LOPEN
  cmp eax,IDM_LSAVE
  je .LSAVE
  cmp eax,IDM_UNDO
  je .UNDO
  cmp eax,IDM_CUT
  je .CUT
  cmp eax,IDM_COPY
  je .COPY
  cmp eax,IDM_PASTE
  je .PASTE
  cmp eax,IDM_DELETE
  je .DELETE
  cmp eax,IDM_SELECTALL
  je .SELECTALL
  cmp eax,IDM_FIND
  je .FIND
  cmp eax,IDM_REPLACE
  je .REPLACE
  cmp eax,IDM_GOTOLINE
  je .GOTOLINE
  cmp eax,IDC_BACKCOLORBOX
  je .backcolorbox
  cmp eax,IDC_TEXTCOLORBOX
  je .textcolorbox
  cmp eax,ID_AD
  je .ADDTASK
  cmp eax,ID_DE
  je .DELETETASK
  cmp eax,IDC_BOLD
  je .bold
  cmp eax,IDC_ITALIC
  je .italic
  cmp eax,IDC_UNDERLINE
  je .underline
  cmp eax,IDC_MARKER
  je .marker
  cmp eax,IDC_UP
  je .up
  cmp eax,IDC_DOWN
  je .down
  cmp eax,IDC_ALIGNC
  je .alignc
  cmp eax,IDC_ALIGNL
  je .alignl
  cmp eax,IDC_ALIGNR
  je .alignr
  cmp eax,IDC_FONT
  je .font
  cmp byte [wparam+2],LBN_DBLCLK
  je .EDITTASK
  jmp .finish

.NEW:
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .creating
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .creating  
  call SaveFile
.creating:
  invoke lstrcpy,pfilename,filename
  invoke SetWindowText,[hedit],0
  invoke SetWindowText,edi,untitled
  invoke lstrcpy,filename,empty
  jmp .rewrite

.OPEN:
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .opening
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .opening  
  call SaveFile
.opening:
  invoke lstrcpy,pfilename,filename
  invoke RtlZeroMemory,ofn,sizeof.OPENFILENAME
  push edi
  pop [ofn.hwndOwner] 
  push [wc.hInstance]
  pop [ofn.hInstance]
  mov [ofn.lStructSize],sizeof.OPENFILENAME
  mov [ofn.lpstrFilter],openfilter 
  mov [ofn.nMaxFile],MAX_PATH
  mov [ofn.lpstrFile],filename
  mov [filename],0
  mov [ofn.Flags],OFN_FILEMUSTEXIST+OFN_HIDEREADONLY+OFN_PATHMUSTEXIST+OFN_NOCHANGEDIR
  invoke GetOpenFileName,ofn
  test eax,eax
  je .finish
  invoke CreateFile,filename,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .finish
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,filename
.rewrite:
  mov esi,resent_files
  invoke lstrcmp,pfilename,empty
  test eax,eax
  jz .empt
  ;invoke MessageBox,0,filename,0,MB_OK
  invoke lstrcmp,filename,[esi+4]
  test eax,eax
  jz .shift1
  invoke lstrcmp,filename,[esi+8]
  test eax,eax
  jz .shift2
  invoke lstrcmp,filename,[esi+12]
  test eax,eax
  jz .shift3
  invoke lstrcmp,filename,[esi+16]
  test eax,eax
  jz .shift4
  jmp .shift5
.empt:
  invoke lstrcmp,filename,[esi+4]
  test eax,eax
  je .shiftn5
  invoke lstrcmp,filename,[esi+8]
  test eax,eax
  je .shiftn4
  invoke lstrcmp,filename,[esi+12]
  test eax,eax
  je .shiftn3
  invoke lstrcmp,filename,[esi+16]
  test eax,eax
  je .shiftn2
  invoke lstrcmp,filename,[esi+20]
  test eax,eax
  je .shiftn1
  jmp .finish
  

.SAVE:
  invoke lstrcmp,filename,empty
  test eax,eax
  je .empts
  call SaveFile
  jmp .finish
.empts:
  mov esi,resent_files
  call SaveFile
  invoke lstrcmp,filename,[esi+4]
  test eax,eax
  je .shiftn5
  invoke lstrcmp,filename,[esi+8]
  test eax,eax
  je .shiftn4
  invoke lstrcmp,filename,[esi+12]
  test eax,eax
  je .shiftn3
  invoke lstrcmp,filename,[esi+16]
  test eax,eax
  je .shiftn2
  invoke lstrcmp,filename,[esi+20]
  test eax,eax
  je .shiftn1
  jmp .finish

.SAVEAS:
  call SaveFile
  jmp .finish
  
.RECENTFILE1:
  mov esi,resent_files
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .file1
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .file1 
  call SaveFile
.file1:
  invoke CreateFile,[esi+4],GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .shiftn5
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,[esi+4]
  invoke lstrcmp,filename,empty
  test eax,eax
  je .finish1
  invoke lstrcpy,pfilename,filename
  invoke lstrcpy,filename,[esi+4]
  jmp .shift1
.finish1:
  invoke lstrcpy,filename,[esi+4]
  jmp .shiftn5
  
.RECENTFILE2:
  mov esi,resent_files
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .file2
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .file2 
  call SaveFile
.file2:
  invoke CreateFile,[esi+8],GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .shiftn4
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,[esi+8]
  invoke lstrcmp,filename,empty
  test eax,eax
  je .finish2
  invoke lstrcpy,pfilename,filename
  invoke lstrcpy,filename,[esi+8]
  jmp .shift2
.finish2:
  invoke lstrcpy,filename,[esi+8]
  jmp .shiftn4
  
.RECENTFILE3:
  mov esi,resent_files
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .file3
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .file3 
  call SaveFile
.file3:
  invoke CreateFile,[esi+12],GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .shiftn3
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,[esi+12]
  invoke lstrcmp,filename,empty
  test eax,eax
  je .finish3
  invoke lstrcpy,pfilename,filename
  invoke lstrcpy,filename,[esi+12]
  jmp .shift3
.finish3:
  invoke lstrcpy,filename,[esi+12]
  jmp .shiftn3

.RECENTFILE4:
  mov esi,resent_files
  xor ebx,ebx
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .file4
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .file4 
  call SaveFile
.file4:
  invoke CreateFile,[esi+16],GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .shiftn2
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,[esi+16]
  invoke lstrcmp,filename,empty
  test eax,eax
  je .finish4
  invoke lstrcpy,pfilename,filename
  invoke lstrcpy,filename,[esi+16]
  jmp .shift4
.finish4:
  invoke lstrcpy,filename,[esi+16]
  jmp .shiftn2
  
.RECENTFILE5:
  mov esi,resent_files
  xor ebx,ebx
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .file5
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .file5 
  call SaveFile
.file5:
  invoke CreateFile,[esi+20],GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .shiftn1
  mov [hfile],eax
  mov [editstream.dwCookie],eax
  mov [editstream.pfnCallback],StreamInProc
  invoke SendMessage,[hedit],EM_STREAMIN,SF_RTF,editstream
  invoke SendMessage,[hedit],EM_SETMODIFY,FALSE,0
  invoke CloseHandle,[hfile]
  invoke SetWindowText,edi,[esi+20]
  invoke lstrcmp,filename,empty
  test eax,eax
  je .finish5
  invoke lstrcpy,pfilename,filename
  invoke lstrcpy,filename,[esi+20]
  jmp .shift5
.finish5:
  invoke lstrcpy,filename,[esi+20]
  jmp .shiftn1
  
.shiftn5:
  invoke lstrcpy,[esi+4],[esi+8]
.shiftn4:
  invoke lstrcpy,[esi+8],[esi+12]
.shiftn3:
  invoke lstrcpy,[esi+12],[esi+16]
.shiftn2:
  invoke lstrcpy,[esi+16],[esi+20]
.shiftn1:
  invoke lstrcpy,[esi+20],empty
  call FillMenu
  jmp .finish
  
.shift5:
  invoke lstrcpy,[esi+20],[esi+16]
.shift4:
  invoke lstrcpy,[esi+16],[esi+12]
.shift3:
  invoke lstrcpy,[esi+12],[esi+8]
.shift2:
  invoke lstrcpy,[esi+8],[esi+4]
.shift1:
  invoke lstrcpy,[esi+4],pfilename
  call FillMenu
  jmp .finish
  
.LNEW:
  invoke SendMessage,[hlist],LB_RESETCONTENT,0,0
  invoke lstrcpy, lfilename,empty
  jmp .finish
  
.LOPEN:
  invoke RtlZeroMemory,ofn,sizeof.OPENFILENAME
  push edi
  pop [ofn.hwndOwner] 
  push [wc.hInstance]
  pop [ofn.hInstance]
  mov [ofn.lStructSize],sizeof.OPENFILENAME
  mov [ofn.lpstrFilter],lopenfilter 
  mov [ofn.nMaxFile],MAX_PATH
  ;mov [ofn.lpstrFile],resent_files
  ;mov [resent_files],0
  mov [ofn.lpstrFile],lfilename
  mov [lfilename],0
  mov [ofn.Flags],OFN_FILEMUSTEXIST+OFN_HIDEREADONLY+OFN_PATHMUSTEXIST+OFN_NOCHANGEDIR
  invoke GetOpenFileName,ofn
  test eax,eax
  je .finish
  invoke lstrcpy,[resent_files],lfilename
  invoke CreateFile,lfilename,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
  cmp eax,INVALID_HANDLE_VALUE
  je .finish
  mov [hfile],eax
  invoke SendMessage,[hlist],LB_RESETCONTENT,0,0
.r:
  push edi
  lea esi,[buff]
  mov [read],0
.read:
  invoke ReadFile,[hfile],temp,1,read,0
  test eax,eax
  je .f
  cmp [read],0
  je .f
  cmp [temp],10
  je .endofline
  movzx eax,[temp]
  mov [esi], al
  inc esi
  jmp .read 
.endofline:
  movzx eax,[temp]
  mov [esi], al
  inc esi
  mov byte [esi],0
  stdcall is_utf8,buff
  test eax,eax
  jz .ad
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  invoke lstrcmp,bufff,empty
  test eax,eax
  je .r
  invoke SendMessage,[hlist],LB_ADDSTRING,0,bufff
  jmp .r
.aaad:
  ;invoke MessageBox,0,buff,0,MB_OK
  invoke lstrcmp,buff,empty
  test eax,eax
  je .r
  invoke SendMessage,[hlist],LB_ADDSTRING,0,buff
  jmp .r
.f:
  mov byte [esi],13
  inc esi
  mov byte [esi],10
  inc esi
  mov byte [esi],0
  stdcall is_utf8,buff
  test eax,eax
  jz .aaddd
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  invoke lstrcmp,bufff,empty
  test eax,eax
  je .finn
  invoke SendMessage,[hlist],LB_ADDSTRING,0,bufff
  jmp .finn
.aaddd:
  ;invoke MessageBox,0,buff,0,MB_OK
  invoke lstrcmp,buff,empty
  test eax,eax
  je .finn
  invoke SendMessage,[hlist],LB_ADDSTRING,0,buff
.finn:
  invoke CloseHandle,[hfile]
  pop edi
  jmp .finish
  
.LSAVE:
  invoke lstrcmp,lfilename,empty
  test eax,eax
  jnz .saving_tasks
  invoke RtlZeroMemory,ofn,sizeof.OPENFILENAME
  push edi
  pop [ofn.hwndOwner] 
  push [wc.hInstance]
  pop [ofn.hInstance]
  mov [ofn.lStructSize],sizeof.OPENFILENAME
  mov [ofn.lpstrFilter],lopenfilter 
  mov [ofn.nMaxFile],MAX_PATH
  mov [ofn.lpstrFile],lfilename
  mov [ofn.Flags],OFN_FILEMUSTEXIST+OFN_HIDEREADONLY+OFN_PATHMUSTEXIST
  invoke GetSaveFileName,ofn
  test eax,eax
  je .finish
.saving_tasks:  
  invoke CreateFile,lfilename,GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL
  mov [hfile],eax
  cmp eax,INVALID_HANDLE_VALUE
  je .lfinish
  push edi
  ;mov esi,[hlist]
  invoke SendMessage,[hlist],LB_GETCOUNT,0,0
  test eax,eax
  jz .lfinish
  mov ebx,eax
.loop_task:
  dec ebx
  invoke SendMessage,[hlist],LB_GETTEXTLEN,ebx,0
  mov esi,eax
  invoke HeapAlloc,[hHeapList],HEAP_ZERO_MEMORY, esi + 1
  mov edi,eax
  invoke SendMessage,[hlist],LB_GETTEXT,ebx,buf
  invoke WriteFile,[hfile],buf,esi,0,0
  test ebx,ebx
  jnz .loop_task
  pop edi
.lfinish:
  invoke CloseHandle,[hfile]
  jmp .finish

.UNDO:
  mov eax,EM_UNDO
  jmp .sendtoedit

.CUT:
  mov eax,WM_CUT
  jmp .sendtoedit

.COPY:
  mov eax,WM_COPY
  jmp .sendtoedit

.PASTE:
  mov eax,WM_PASTE
  jmp .sendtoedit

.DELETE:
  mov eax,WM_CLEAR
  jmp .sendtoedit

.sendtoedit:
  invoke SendMessage,[hedit],eax,0,0
  jmp .finish

.SELECTALL:
  invoke SendMessage,[hedit],EM_SETSEL,0,-1
  jmp .finish
  
.FIND:
  ;cmp [hsearch],0
  ;je .finish
  invoke CreateDialogParam,[wc.hInstance],IDD_FINDDLG,edi,Search,0
  jmp .finish
  
.REPLACE:
  invoke CreateDialogParam,[wc.hInstance],IDD_REPLACEDLG,edi,Replace,0
  jmp .finish
  
.GOTOLINE:
  invoke CreateDialogParam,[wc.hInstance],IDD_GOTODLG,edi,GoTo,0
  jmp .finish

.backcolorbox:
  invoke RtlZeroMemory, color, sizeof.CHOOSECOLOR
  mov [color.lStructSize],sizeof.CHOOSECOLOR
  push edi
  pop [color.hwndOwner]
  push [wc.hInstance]
  pop [color.hInstance]
  push [backgroundcolor]
  pop [color.rgbResult]
  mov [color.lpCustColors],colors
  mov [color.Flags], CC_ANYCOLOR+CC_RGBINIT
  invoke ChooseColor, color
  test eax,eax
  je .finish
  push [color.rgbResult] 
  pop ebx
  mov [backgroundcolor],ebx
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  mov [charf.crBackColor],ebx
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  invoke InvalidateRect,[hbackcolor],0,TRUE
  jmp .finish

.textcolorbox:
  invoke RtlZeroMemory, color, sizeof.CHOOSECOLOR
  mov [color.lStructSize],sizeof.CHOOSECOLOR
  push edi
  pop [color.hwndOwner]
  push [wc.hInstance]
  pop [color.hInstance]
  push [textcolor]
  pop [color.rgbResult]
  mov [color.lpCustColors],colors
  mov [color.Flags], CC_ANYCOLOR+CC_RGBINIT
  invoke ChooseColor, color
  test eax,eax
  je .finish
  push [color.rgbResult]
  pop ebx
  mov [textcolor],ebx
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  mov [charf.crTextColor],ebx
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  invoke InvalidateRect,[htextcolor],0,TRUE
  jmp .finish
  
.ADDTASK:
  invoke SendMessage,[heditadd],WM_GETTEXT,101,buf
  cmp [buf],0
  je .finish
  lea esi,[buf]
  invoke lstrcat,buf,linefeed
  invoke SendMessage,[hlist],LB_ADDSTRING,0,buf
  invoke SetWindowText,[heditadd],0
  jmp .finish
  
.DELETETASK:
  invoke SendMessage,[hlist],LB_GETCURSEL,0,0
  invoke SendMessage,[hlist],LB_DELETESTRING,eax,0
  jmp .finish
  
.EDITTASK:
  invoke SendMessage,[hlist],LB_GETCURSEL,0,0
  mov ebx,eax
  invoke SendMessage,[hlist],LB_GETTEXT,ebx,buf
  invoke SetWindowText,[heditadd],buf
  invoke SendMessage,[hlist],LB_DELETESTRING,ebx,0
  jmp .finish
  
.bold:
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  xor [charf.dwEffects], CFE_BOLD
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish
  
.italic:
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  xor [charf.dwEffects], CFE_ITALIC
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish
  
.underline:
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  xor [charf.dwEffects], CFE_UNDERLINE
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish
  
.marker:
  invoke SendMessage,[hedit],EM_GETPARAFORMAT,SCF_SELECTION,paraf
  mov [paraf.dwMask],PFM_NUMBERING or PFM_NUMBERINGSTART or PFM_NUMBERINGTAB
  xor [paraf.wNumbering], 1 
  mov [paraf.wNumberingStart], 1 
  mov [paraf.wNumberingTab], 200 
  invoke SendMessage,[hedit],EM_SETPARAFORMAT,SCF_SELECTION,paraf
  jmp .finish
  
.up:
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  add [charf.yHeight],10
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish
  
.down:
  invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  sub [charf.yHeight],10
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish
  
.alignc:
  invoke SendMessage,[hedit],EM_GETPARAFORMAT,SCF_SELECTION,paraf
  mov [paraf.dwMask],PFM_ALIGNMENT
  mov [paraf.wAlignment],3
  invoke SendMessage,[hedit],EM_SETPARAFORMAT,SCF_SELECTION,paraf
  jmp .finish

.alignl:
  invoke SendMessage,[hedit],EM_GETPARAFORMAT,SCF_SELECTION,paraf
  mov [paraf.dwMask],PFM_ALIGNMENT
  mov [paraf.wAlignment],1
  invoke SendMessage,[hedit],EM_SETPARAFORMAT,SCF_SELECTION,paraf
  jmp .finish

.alignr:
  invoke SendMessage,[hedit],EM_GETPARAFORMAT,SCF_SELECTION,paraf
  mov [paraf.dwMask],PFM_ALIGNMENT
  mov [paraf.wAlignment],2
  invoke SendMessage,[hedit],EM_SETPARAFORMAT,SCF_SELECTION,paraf
  jmp .finish
  
.font:
  invoke RtlZeroMemory, font, sizeof.CHOOSEFONT
  mov [font.lStructSize],sizeof.CHOOSEFONT
  mov [font.Flags],CF_SCREENFONTS or CF_EFFECTS or CF_INITTOLOGFONTSTRUCT
  push [wc.hInstance]
  pop [font.hInstance]
  mov [font.lpLogFont],lf
  invoke ChooseFont, font
  test eax,eax
  je .finish
  ;invoke CreateFontIndirect, lf.lfFaceName, lf.lfHeight, lf.lfWeight, lf.lfItalic, lf.lfUnderline,lf.lfStrikeOut, DEFAULT_CHARSET, 0, 0, 0, 0, 0, 0, lf.lfFaceName 
  ;invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION,font.lpLogFont
  ;push edi
  ;lea edi,[charf.szFaceName]
  ;lea esi,[lf.lfFaceName] 
  ;cld
  ;mov ecx,30
  ;rep movsw
  ;pop edi
  invoke lstrcmp,charf.szFaceName,lf.lfFaceName
  test eax,eax
  je .finish
  invoke lstrcpy,charf.szFaceName,lf.lfFaceName
  invoke lstrcpy,curfont,lf.lfFaceName
  ;invoke MessageBox,0,charf.szFaceName,0,MB_OK
  mov cl, [lf.lfPitchAndFamily]
  mov [charf.bPitchAndFamily],cl
  invoke SetWindowText,[hfont],charf.szFaceName
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  jmp .finish


.wmcreate:
  invoke GetClientRect,edi,client
;создание главного поля для текста
  mov esi, [client.right]
  sub esi, 600
  invoke CreateWindowEx,WS_EX_CLIENTEDGE,_edit,0,ES_SAVESEL+WS_VISIBLE+WS_CHILD+WS_VSCROLL+WS_BORDER+ES_AUTOVSCROLL+ ES_MULTILINE,ebx,[client.top],esi,[client.bottom],edi,0,[wc.hInstance],NULL
  test eax,eax
  je .failed
  mov [hedit],eax
  invoke SendMessage, [hedit], EM_SETEVENTMASK, 0, ENM_SELCHANGE
  mov [charf.cbSize], sizeof.CHARFORMAT
  mov [charf.crBackColor], 0x00FFFFFF
  mov [charf.dwMask], CFM_BACKCOLOR or CFM_COLOR or CFM_BOLD or CFM_ITALIC or CFM_SIZE or CFM_FACE or CFM_UNDERLINE
  mov [charf.yHeight],220
  invoke lstrcpy,charf.szFaceName,curfont
  invoke SendMessage,[hedit],EM_SETCHARFORMAT,SCF_ALL,charf
  mov [paraf.cbSize], sizeof.PARAFORMAT
  ;mov [paraf.dwMask], PFM_ALIGNMENT
  invoke SendMessage,[hedit],EM_SETPARAFORMAT,SCF_ALL,paraf
  
  ;invoke LoadImage,0,bmp1,IMAGE_BITMAP,0,0,LR_LOADFROMFILE
  ;invoke SendMessage,[hedit],EM_STREAMIN,SF_TEXT,eax
;создание списка задач
  mov ebx, [client.right]
  sub ebx, 150
  mov esi, [client.top]
  add esi, 20
  invoke CreateWindowEx,0,_listbox,0,WS_VISIBLE+WS_CHILD+LBS_NOTIFY+WS_HSCROLL+WS_BORDER+LBS_SORT,ebx,esi,295,150,edi,0,[wc.hInstance],NULL 
  test eax,eax
  je .failed
  mov [hlist],eax
;создание поля для ввода добавляемой задачи
  add esi, 165
  invoke CreateWindowEx,0,_edit,0,WS_VISIBLE+WS_CHILD+WS_BORDER+ES_AUTOHSCROLL,ebx,esi,295,25,edi,0,[wc.hInstance],NULL 
  test eax,eax
  je .failed
  mov [heditadd],eax
;создание кнопки для добавления задачи
  add ecx, 30
  invoke CreateWindowEx,0,_button,_taddbut,WS_VISIBLE+ WS_CHILD+BS_PUSHBUTTON+WS_TABSTOP,ebx,esi,295,20,edi,ID_AD,[wc.hInstance],0 
  test eax,eax
  je .failed
  mov [hbutadd],eax
;создание кнопки для удаления задачи
  add esi, 30
  invoke CreateWindowEx,0,_button,_tdelbut,WS_VISIBLE+ WS_CHILD+BS_PUSHBUTTON+WS_TABSTOP,ebx,esi,295,20,edi,ID_DE,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutdel],eax
;создание текста "Цвет фона"
  mov esi, [client.bottom]
  sub esi, 80
  invoke CreateWindowEx,0,_static,_tbackcolor,WS_VISIBLE+WS_CHILD,ebx,esi,120,15,edi,0,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hback],eax
;создание "кнопки" изменения цвета фона
  add esi, 20
  invoke CreateWindowEx,0,_static,0,SS_NOTIFY+WS_BORDER+WS_VISIBLE+WS_CHILD,ebx,esi,28,14,edi,IDC_BACKCOLORBOX,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbackcolor],eax
;создание текста "Цвет текста" выделенного
  add esi, 20
  invoke CreateWindowEx,0,_static,_ttextcolor,WS_VISIBLE+WS_CHILD,ebx,esi,120,15,edi,0,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [htext],eax
;создание "кнопки" изменения цвета текста
  add esi, 20
  invoke CreateWindowEx,0,_static,0,SS_NOTIFY+WS_BORDER+WS_VISIBLE+WS_CHILD,ebx,esi,28,14,edi,IDC_TEXTCOLORBOX,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [htextcolor],eax
;создание кнопки для жирного текста
  add esi, 30  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_BOLD,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutbold],eax 
  invoke LoadImage, edi, bmp1, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutbold], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для курсивного текста
  add ebx, 50  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_ITALIC,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutitalic],eax 
  invoke LoadImage, edi, bmp2, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutitalic], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для подчеркнутого текста
  add ebx, 50  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_UNDERLINE,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutunderline],eax 
  invoke LoadImage, edi, bmp9, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_SHARED
  invoke SendMessage, [hbutunderline], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для маркера
  add esi, 50   
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_MARKER,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutmarker],eax 
  invoke LoadImage, edi, bmp8, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE or LR_SHARED
  invoke SendMessage, [hbutmarker], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для увеличения шрифта
  sub ebx, 50 
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_UP,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutup],eax 
  invoke LoadImage, edi, bmp3, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutup], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для уменьшения шрифта
  sub ebx, 50  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_DOWN,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutdown],eax 
  invoke LoadImage, edi, bmp4, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutdown], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для выравнивания по левому краю
  add esi,50  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_ALIGNL,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutalignl],eax 
  invoke LoadImage, edi, bmp5, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutalignl], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для выравнивания по центру
  add ebx,50    
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_ALIGNC,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutalignc],eax 
  invoke LoadImage, edi, bmp6, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutalignc], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание кнопки для выравнивания по правому краю
  add ebx, 50  
  invoke CreateWindowEx,0,_button,0, WS_VISIBLE+ WS_CHILD+BS_BITMAP,ebx,esi,30,30,edi,IDC_ALIGNR,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hbutalignr],eax 
  invoke LoadImage, edi, bmp7, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE or LR_DEFAULTSIZE or LR_SHARED
  invoke SendMessage, [hbutalignr], BM_SETIMAGE, IMAGE_BITMAP, eax
;создание текста "Шрифт" выделенного
  add esi, 50
  invoke CreateWindowEx,0,_static,_tfont,WS_VISIBLE+WS_CHILD,ebx,esi,120,15,edi,0,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [htfont],eax
;создание "кнопки" изменения шрифта
  add ebx,50
  invoke CreateWindowEx,0,_static,curfont,SS_NOTIFY+WS_VISIBLE+WS_CHILD,ebx,esi,100,20,edi,IDC_FONT,[wc.hInstance],0
  test eax,eax
  je .failed
  mov [hfont],eax
  
  xor eax, eax
  invoke SetWindowText,edi,untitled
  invoke lstrcpy,filename,empty
  invoke SendMessage,[hbutalignl],BM_SETSTATE,1,0
  
  invoke lstrcpy,lfilename,[resent_files]
  ;invoke MessageBox,0,lfilename,0,MB_OK
  cmp [lfilename],0
  je .finish
  invoke CreateFile,lfilename,GENERIC_READ+GENERIC_WRITE,FILE_SHARE_READ+FILE_SHARE_WRITE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
  cmp eax,INVALID_HANDLE_VALUE
  je .fini
  test eax,eax
  jz .fini
  mov [hfile],eax
.re:
  push edi
  lea esi,[buff]
  mov [read],0
.readd:
  invoke ReadFile,[hfile],temp,1,read,0
  test eax,eax
  je .fi
  cmp [read],0
  je .fi
  cmp [temp],10
  je .endoflinee
  movzx eax,[temp]
  mov [esi], al
  inc esi
  jmp .readd 
.endoflinee:
  movzx eax,[temp]
  mov [esi], al
  inc esi
  mov byte [esi],0
  stdcall is_utf8,buff
  test eax,eax
  jz .ad
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  invoke lstrcmp,bufff,linefeed
  test eax,eax
  je .re
  invoke SendMessage,[hlist],LB_ADDSTRING,0,bufff
  jmp .re
.ad:
  ;invoke MessageBox,0,buff,0,MB_OK
  invoke lstrcmp,buff,linefeed
  test eax,eax
  je .re
  invoke SendMessage,[hlist],LB_ADDSTRING,0,buff
  jmp .re
.fi:
  mov byte [esi],13
  inc esi
  mov byte [esi],10
  inc esi
  mov byte [esi],0
  stdcall is_utf8,buff
  test eax,eax
  jz .addd
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,0,0
  invoke  MultiByteToWideChar,CP_UTF8,0,buff,-1,widechar_buffer,eax
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,0,0,0,0
  invoke  WideCharToMultiByte,1251,0,widechar_buffer,-1,bufff,eax,0,0
  ;invoke MessageBox,0,bufff,0,MB_OK
  invoke lstrcmp,bufff,linefeed
  test eax,eax
  je .fin
  invoke SendMessage,[hlist],LB_ADDSTRING,0,bufff
  jmp .fin
.addd:
  ;invoke MessageBox,0,buff,0,MB_OK
  invoke lstrcmp,buff,linefeed
  test eax,eax
  je .fin
  invoke SendMessage,[hlist],LB_ADDSTRING,0,buff
.fin:
  pop edi
.fini:
  invoke CloseHandle,[hfile]
  
  jmp .finish

.failed:
  mov eax,-1
  jmp .finish

.wmsize:
  invoke GetClientRect,edi,client
  mov esi, [client.right]
  sub esi, 300
  invoke MoveWindow,[hedit],[client.left],[client.top],esi,[client.bottom],TRUE
  mov ebx, [client.right]
  sub ebx, 300
  mov esi, [client.top]
  add esi, 20
  invoke SetWindowPos,[hlist],0,ebx,esi,295,150,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 170
  invoke SetWindowPos,[heditadd],0,ebx,esi,295,20,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 25
  invoke SetWindowPos,[hbutadd],0,ebx,esi,145,20,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 50
  invoke SetWindowPos,[hbutdel],0,ebx,esi,145,20,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 90
  add ebx,75 
  invoke SetWindowPos,[hback],0,ebx,esi,120,15,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 20
  invoke SetWindowPos,[hbackcolor],0,ebx,esi,28,14,SWP_NOZORDER+SWP_SHOWWINDOW
  add esi, 20
  invoke SetWindowPos,[htext],0,ebx,esi,120,15,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi, 20
  invoke SetWindowPos,[htextcolor],0,ebx,esi,28,14,SWP_NOZORDER+SWP_SHOWWINDOW
  add esi,30
  invoke SetWindowPos,[hbutbold],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add ebx,50
  invoke SetWindowPos,[hbutitalic],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add ebx,50
  invoke SetWindowPos,[hbutunderline],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi,50
  invoke SetWindowPos,[hbutmarker],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  sub ebx,50
  invoke SetWindowPos,[hbutup],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  sub ebx,50
  invoke SetWindowPos,[hbutdown],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi,50
  invoke SetWindowPos,[hbutalignl],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add ebx,50
  invoke SetWindowPos,[hbutalignc],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add ebx,50
  invoke SetWindowPos,[hbutalignr],0,ebx,esi,30,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi,50
  sub ebx,100
  invoke SetWindowPos,[htfont],0,ebx,esi,50,30,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  add esi,20
  invoke SetWindowPos,[hfont],0,ebx,esi,100,14,SWP_NOZORDER+SWP_NOSIZE+SWP_SHOWWINDOW
  xor eax, eax
  jmp .finish

.wmsetfocus:
  invoke SetFocus,[hedit]
  xor eax, eax
  jmp .finish

.wmctlcolorstatic:
  mov esi,[lparam]
  cmp [hbackcolor],esi
  je .back
  cmp [htextcolor],esi
  je .text
  jmp .finish

.back:
  invoke CreateSolidBrush,[backgroundcolor]
  jmp .finish

.text:
  invoke CreateSolidBrush,[textcolor]
  jmp .finish
  
.wmnotify:
  mov esi,[lparam]
  mov eax,[esi+NMHDR.code]
  cmp eax,EN_SELCHANGE
  je .enselchange
  
  jmp .finish
  
.enselchange:
  ;invoke SendMessage,[hedit],EM_GETCHARFORMAT,SCF_SELECTION or SCF_WORD,charf
  invoke SendMessage,[hedit],EM_GETPARAFORMAT,SCF_SELECTION or SCF_WORD,paraf
  mov esi,[charf.crBackColor]
  cmp esi,[backgroundcolor]
  je .changetcolor
  mov [backgroundcolor],esi
  invoke InvalidateRect,[hbackcolor],0,TRUE
.changetcolor:
  mov esi,[charf.crTextColor]
  cmp esi,[textcolor]
  je .changefont
  mov [textcolor],esi
  invoke InvalidateRect,[htextcolor],0,TRUE
.changefont:
  invoke lstrcmp,curfont,charf.szFaceName
  test eax,eax
  je .changebold
  invoke lstrcpy,curfont,charf.szFaceName
  invoke SetWindowText,[hfont],curfont
.changebold:
  mov esi,[charf.dwEffects] 
  test esi,CFE_BOLD
  jz .nbold
  cmp [bolds],1
  je .changeitalic
  mov [bolds],1
  invoke SendMessage,[hbutbold],BM_SETSTATE,1,0
  jmp .changeitalic
.nbold:
  cmp [bolds],0
  je .changeitalic
  mov [bolds],0
  invoke SendMessage,[hbutbold],BM_SETSTATE,0,0
.changeitalic:
  test esi,CFE_ITALIC
  jz .nitalic
  cmp [italics],1
  je .changeunder
  mov [italics],1
  invoke SendMessage,[hbutitalic],BM_SETSTATE,1,0
  jmp .changeunder
.nitalic:
  cmp [italics],0
  je .changeunder
  mov [italics],0
  invoke SendMessage,[hbutitalic],BM_SETSTATE,0,0
.changeunder:
  mov esi,[charf.dwEffects] 
  test esi,CFE_UNDERLINE
  jz .nunder
  cmp [unders],1
  je .changealign
  mov [unders],1
  invoke SendMessage,[hbutunderline],BM_SETSTATE,1,0
  jmp .changealign
.nunder:
  cmp [unders],0
  je .changealign
  mov [unders],0
  invoke SendMessage,[hbutunderline],BM_SETSTATE,0,0
.changealign:
  mov bx, [paraf.wAlignment]
  mov si, word [aligns]
  push bx
  pop word [aligns]
  cmp bx,si
  je .finish
  cmp si,1
  jne .prev2
  invoke SendMessage,[hbutalignl],BM_SETSTATE,0,0
  jmp .next1
.prev2:
  cmp si,2
  jne .prev3
  invoke SendMessage,[hbutalignr],BM_SETSTATE,0,0
  jmp .next1
.prev3:
  invoke SendMessage,[hbutalignc],BM_SETSTATE,0,0
.next1:
  cmp bx,1
  jne .next2
  invoke SendMessage,[hbutalignl],BM_SETSTATE,1,0
  jmp .finish
.next2:
  cmp bx,2
  jne .next3
  invoke SendMessage,[hbutalignr],BM_SETSTATE,1,0
  jmp .finish
.next3:
  invoke SendMessage,[hbutalignc],BM_SETSTATE,1,0
  jmp .finish

  
.wmclose:
  invoke SendMessage,[hedit],EM_GETMODIFY,0,0
  test eax,eax
  jz .wmdestroy
  call Confirmation
  cmp eax,IDCANCEL
  je .finish
  cmp eax,IDNO
  je .wmdestroy  
  call SaveFile

.wmdestroy: 
  invoke CreateFile,recent,GENERIC_READ+GENERIC_WRITE,FILE_SHARE_READ+FILE_SHARE_WRITE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL 
  mov [hfile],eax
  cmp eax,INVALID_HANDLE_VALUE
  je .handle_error
  lea esi,[resent_files]
  invoke lstrcpy,[esi],lfilename
  invoke lstrcat,[esi],linefeed
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
  add esi,4 
  invoke lstrcat,[esi],linefeed  
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
  add esi,4  
  invoke lstrcat,[esi],linefeed
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
  add esi,4  
  invoke lstrcat,[esi],linefeed  
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
  add esi,4 
  invoke lstrcat,[esi],linefeed  
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
  add esi,4
  invoke lstrcat,[esi],linefeed  
  invoke lstrlen,[esi]
  invoke WriteFile,[hfile],[esi],eax,0,0
  test eax, eax
  jz .handle_error
.handle_error:
  invoke CloseHandle, [hfile]
.d:
  invoke HeapDestroy,[hHeap]
  invoke HeapDestroy,[hHeapList]
  invoke FreeLibrary, [hrichedit]
  invoke PostQuitMessage,0
  xor eax, eax

.finish:
  ret
endp


section '.idata' import data readable writeable

library kernel32,'KERNEL32.DLL',\
user32,'USER32.DLL',\
gdi32,'GDI32.DLL',\
comdlg32, 'COMDLG32.DLL'

include 'api\kernel32.inc'
include 'api\user32.inc'
include 'api\gdi32.inc'
include 'api\comdlg32.inc'

import comdlg,\
         GetOpenFileName,'GetOpenFileNameA'

section '.rsrc' resource data readable

directory RT_MENU,menus,\
RT_ACCELERATOR,accelerators,\
RT_VERSION,versions,\
RT_ICON,icons,\
RT_GROUP_ICON,group_icons,\
RT_DIALOG,dialogs

resource menus,\
IDM_MAIN,LANG_RUSSIAN+SUBLANG_DEFAULT,main_menu

resource accelerators,\
IDA_MAIN,LANG_ENGLISH+SUBLANG_DEFAULT,main_keys

resource versions,\
1,LANG_NEUTRAL,version

resource icons,\
2,LANG_NEUTRAL,icon_data

resource group_icons,\
IDI_MAIN,LANG_NEUTRAL,main_icon

resource dialogs,\
IDD_FINDDLG,LANG_ENGLISH+SUBLANG_DEFAULT,search_dialog,\
IDD_REPLACEDLG,LANG_ENGLISH+SUBLANG_DEFAULT,replace_dialog,\
IDD_GOTODLG,LANG_ENGLISH+SUBLANG_DEFAULT,goto_dialog

menu main_menu
menuitem '&Файл',0,MFR_POPUP
menuitem <'Созд&ать',9,'Ctrl+N'>,IDM_NEW
menuitem <'&Открыть…',9,'Ctrl+O'>,IDM_OPEN
menuitem <'&Сохранить',9,'Ctrl+S'>,IDM_SAVE
menuitem 'Сохранить &как…',IDM_SAVEAS
menuitem 'Последние файлы',IDM_RECENT_FILE,MFR_POPUP
menuitem '',IDM_RECENT_FILE+1
menuitem '',IDM_RECENT_FILE+2
menuitem '',IDM_RECENT_FILE+3
menuitem '',IDM_RECENT_FILE+4
menuitem '',IDM_RECENT_FILE+5,MFR_END 
menuseparator
menuitem <'В&ыход',9,'Ctrl+Q'>,IDM_EXIT,MFR_END

menuitem '&Список',0,MFR_POPUP
menuitem 'Созд&ать',IDM_LNEW
menuitem '&Открыть…',IDM_LOPEN
menuitem '&Сохранить',IDM_LSAVE,MFR_END 

menuitem '&Правка',0,MFR_POPUP
menuitem <'&Отменить',9,'Ctrl+Z'>,IDM_UNDO
menuseparator
menuitem <'&Вырезать',9,'Ctrl+X'>,IDM_CUT
menuitem <'&Копировать',9,'Ctrl+C'>,IDM_COPY
menuitem <'Вст&авить',9,'Ctrl+V'>,IDM_PASTE
menuitem <'&Удалить',9,'Del'>,IDM_DELETE
menuseparator
menuitem <'Выделить в&се',9,'Ctrl+A'>,IDM_SELECTALL,MFR_END

menuitem 'Поиск',0,MFR_POPUP+MFR_END
menuitem 'Найти…',IDM_FIND
menuitem 'Заменить',IDM_REPLACE
menuitem 'Перейти к строке',IDM_GOTOLINE,MFR_END


accelerator main_keys,\
FVIRTKEY+FNOINVERT+FCONTROL,'Z',IDM_UNDO,\
FVIRTKEY+FNOINVERT+FCONTROL,'X',IDM_CUT,\
FVIRTKEY+FNOINVERT+FCONTROL,'C',IDM_COPY,\
FVIRTKEY+FNOINVERT+FCONTROL,'V',IDM_PASTE,\
FVIRTKEY+FNOINVERT+FCONTROL,'A',IDM_SELECTALL

dialog          search_dialog,'Поиск',0,0,200,54,WS_VISIBLE+WS_POPUP+WS_CAPTION+WS_SYSMENU+DS_MODALFRAME+DS_CENTER,0,0,'Arial',10
  dialogitem    'STATIC','Найти:',-1,5,4,34,8,WS_VISIBLE
  dialogitem    'EDIT','',IDC_FINDEDIT,30,3,120,10,ES_AUTOHSCROLL+WS_VISIBLE+WS_BORDER
  dialogitem    'BUTTON','С учётом регистра',IDC_MATCHCASE,6,24,75,10,WS_VISIBLE+BS_AUTOCHECKBOX+WS_TABSTOP
  dialogitem    'BUTTON','Полностью слово',IDC_WHOLEWORD,6,37,75,10,WS_VISIBLE+BS_AUTOCHECKBOX+WS_TABSTOP
  dialogitem    'BUTTON','Направление',-1,90,18,60,32,WS_VISIBLE+BS_GROUPBOX
  dialogitem    'BUTTON','Вниз',IDC_DOWN,95,27,35,10,WS_VISIBLE+BS_AUTORADIOBUTTON+WS_TABSTOP
  dialogitem    'BUTTON','Вверх',IDC_UP,95,38,35,10,WS_VISIBLE+BS_AUTORADIOBUTTON+WS_TABSTOP
  dialogitem    'BUTTON','Ок',IDOK,155,3,39,12,WS_VISIBLE+BS_PUSHBUTTON
  dialogitem    'BUTTON','Отмена',IDCANCEL,155,18,39,12,WS_VISIBLE+BS_PUSHBUTTON
enddialog

dialog          replace_dialog,'Замена',0,0,200,33,WS_VISIBLE+WS_POPUP+WS_CAPTION+WS_SYSMENU+DS_MODALFRAME+DS_CENTER,0,0,'Arial',10
  dialogitem    'STATIC','Найти:',-1,3,4,34,8,WS_VISIBLE
  dialogitem    'STATIC','Заменить на:',-1,3,19,50,8,WS_VISIBLE
  dialogitem    'EDIT','',IDC_FINDEDIT,51,3,100,12,ES_AUTOHSCROLL+WS_VISIBLE+WS_BORDER
  dialogitem    'EDIT','',IDC_REPLACEEDIT,51,18,100,12,ES_AUTOHSCROLL+WS_VISIBLE+WS_BORDER
  dialogitem    'BUTTON','Ок',IDOK,155,3,39,12,WS_VISIBLE+BS_PUSHBUTTON
  dialogitem    'BUTTON','Отмена',IDCANCEL,155,18,39,12,WS_VISIBLE+BS_PUSHBUTTON
enddialog

dialog          goto_dialog,'Перейти к строке',0,0,120,30,WS_VISIBLE+WS_POPUP+WS_CAPTION+WS_SYSMENU+DS_MODALFRAME+DS_CENTER,0,0,'Arial',10
  dialogitem    'STATIC','Перейти к строке:',-1,3,5,75,8,WS_VISIBLE
  dialogitem    'EDIT','',IDC_LINENO,65,5,50,10,ES_AUTOHSCROLL+WS_VISIBLE+WS_BORDER
  dialogitem    'BUTTON','Ок',IDOK,15,17,39,12,WS_VISIBLE+BS_PUSHBUTTON
  dialogitem    'BUTTON','Отмена',IDCANCEL,65,17,39,12,WS_VISIBLE+BS_PUSHBUTTON
enddialog

icon main_icon, icon_data, 'bmp.ico'
versioninfo version,VOS_NT_WINDOWS32,VFT_APP,VFT2_UNKNOWN,LANG_RUSSIAN+ SUBLANG_DEFAULT,0,\
'Comments','Написан при помощи FASM',\
'CompanyName','Milena Korotkaya',\
'FileDescription','Ежедневник',\
'ProductName',<'Ежедневник'>,\
'LegalCopyright',<'Copyright ',0A9h, 'Milena Korotkaya'>,\
'FileVersion','0.1.0.0',\
'OriginalFilename','diary.EXE'