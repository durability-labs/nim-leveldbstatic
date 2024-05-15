#include <zstd.h>

int main(int argc, char** argv)
{
  size_t length;
  ZSTD_compressBound(length);
  return 0;
}
