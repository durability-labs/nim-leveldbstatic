when defined(windows):
  {.compile: "./sources/util/env_windows.cc".}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}

when defined(posix):
  {.compile: "./sources/util/env_posix.cc".}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}
