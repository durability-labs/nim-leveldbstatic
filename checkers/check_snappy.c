#include <snappy.h>

int main(int argc, char** argv)
{
  char* input;
  size_t length;
  size_t result;
  snappy::GetUncompressedLength(input, length, &result);
  return 0;
}
