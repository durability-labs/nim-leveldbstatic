#include <unistd.h>

int main(int argc, char** argv)
{
  fdatasync(-1);
  return 0;
}
