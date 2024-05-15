import os

const root = currentSourcePath.parentDir.parentDir
const envWindows = root/"vendor"/"util"/"env_windows.cc"
const envPosix = root/"vendor"/"util"/"env_posix.cc"
const checkers = root/"checkers"

when defined(windows):
  {.compile: envWindows.}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}
  {.passc: "-D_UNICODE".}
  {.passc: "-DUNICODE".}

when defined(posix):
  {.compile: envPosix.}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}


static:
  proc doesCompile(cfile: string): int =
    let rv = gorgeEx("gcc " & cfile)
    if rv[1] == 0:
      return 1
    return 0

  {.passc: "-DHAVE_FDATASYNC=" & $doesCompile(checkers/"check_fdatasync.c").}
  {.passc: "-DHAVE_FULLFSYNC=" & $doesCompile(checkers/"check_fullfsync.c").}
  {.passc: "-DHAVE_O_CLOEXEC=" & $doesCompile(checkers/"check_ocloexec.c").}
  {.passc: "-DHAVE_CRC32C=" & $doesCompile(checkers/"check_crc32c.c").}
  {.passc: "-DHAVE_SNAPPY=" & $doesCompile(checkers/"check_snappy.c").}
  {.passc: "-DHAVE_ZSTD=" & $doesCompile(checkers/"check_zstd.c").}
  {.passc: "-DHAVE_Zstd=" & $doesCompile(checkers/"check_zstd.c").}

