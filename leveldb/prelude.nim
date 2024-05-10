import os

const root = currentSourcePath.parentDir.parentDir
const envWindows = root/"vendor"/"util"/"env_windows.cc"
const envPosix = root/"vendor"/"util"/"env_posix.cc"

when defined(windows):
  {.compile: envWindows.}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}

when defined(posix):
  {.compile: envPosix.}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}

{.passC: "-I" & root/"vendor".}
{.passC: "-I" & root/"vendor"/"helpers".}
{.passC: "-I" & root/"vendor"/"helpers"/"memenv".}
{.passC: "-I" & root/"vendor"/"port".}
{.passC: "-I" & root/"vendor"/"include".}
{.passC: "-I" & root/"build"/"include".}

