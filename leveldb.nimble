# Package

version       = "0.4.1"
author        = "Michał Zieliński"
description   = "LevelDB wrapper for Nim"
license       = "MIT"
bin           = @["leveldbtool"]
# installExt    = @["nim", "cc", "h", "c", "cpp"]
installDirs   = @["build", "leveldb", "vendor"]
installFiles  = @["leveldb.nim"]
#"leveldbtool.nim", "prelude.nim"]

# Dependencies

requires "nim >= 1.4.0"
