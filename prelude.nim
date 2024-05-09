when defined(windows):
  {.compile: "./src/vendor/util/env_windows.cc".}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}

when defined(posix):
  {.compile: "./src/vendor/util/env_posix.cc".}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}
