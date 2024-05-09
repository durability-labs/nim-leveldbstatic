# Package

version       = "0.4.1"
author        = "Michał Zieliński"
description   = "LevelDB wrapper for Nim"
license       = "MIT"
bin           = @["leveldbtool"]
installExt    = @["nim", "cc", "h", "c", "cpp"]
skipDirs      = @["tests"]


# Dependencies

requires "nim >= 1.4.0"
