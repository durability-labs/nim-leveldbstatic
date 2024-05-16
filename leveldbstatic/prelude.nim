import os

const root = currentSourcePath.parentDir.parentDir
const envWindows = root/"vendor"/"util"/"env_windows.cc"
const envPosix = root/"vendor"/"util"/"env_posix.cc"

when defined(windows):
  {.compile: envWindows.}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}
  {.passc: "-D_UNICODE".}
  {.passc: "-DUNICODE".}

when defined(posix):
  {.compile: envPosix.}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}
