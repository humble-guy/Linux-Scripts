#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>


void write_text (int socket_fd, const char* text)
{
  int length = strlen (text) + 1;
  write (socket_fd, &length, sizeof (length));
  write (socket_fd, text, length);
}

int main (int argc, char* const argv[])
{
  const char* const socket_name = argv[1];
  
  int socket_fd;
  struct sockaddr_un name;


  socket_fd = socket (PF_LOCAL, SOCK_STREAM, 0);
  char message[100];
 
  name.sun_family = AF_LOCAL;
  
  strcpy (name.sun_path, socket_name);
  do{
      
      gets(message);
      connect (socket_fd, (struct sockaddr*)&name, SUN_LEN (&name));
  
      write_text (socket_fd, message);
    }while(strcmp(message,"quit") != 0);
  close (socket_fd);
  return 0;
}
