# Package

version       = "0.4.1"
author        = "Michał Zieliński"
description   = "LevelDB wrapper for Nim"
license       = "MIT"
bin           = @["leveldbtool"]
installDirs   = @["build", "leveldb", "vendor"]
installFiles  = @["leveldb.nim"]

# Dependencies
requires "nim >= 1.4.0"
