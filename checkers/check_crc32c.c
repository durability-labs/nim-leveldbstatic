#include <crc32c/crc32c.h>

int main(int argc, char** argv)
{
  char* buffer;
  size_t size;
  ::crc32c::Extend(0, buffer, size);
  return 0;
}
