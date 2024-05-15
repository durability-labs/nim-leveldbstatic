import unittest, options, os, osproc, sequtils, strutils
import leveldbstatic as leveldb
import leveldbstatic/raw

suite "checking":
  test "A!":
    echo "A!"

    when sizeof(int) == 8:
      echo "int = 8"
    else:
      echo "int is not 8"

    when defined(fdatasync):
      echo "yes fdatasync"
    else:
      echo "no fdatasync"

    when defined(F_FULLFSYNC):
      echo "yes full"
    else:
      echo "no full"

    when defined(O_CLOEXEC):
      echo "yes oclo"
    else:
      echo "no oclo"

    static:
      proc doesCompile(cfile: string): bool =
        # static:
        let rv = gorgeEx("gcc " & cfile)
        echo rv[0]
        return rv[1] == 0

      echo "compileme.c: " & $doesCompile("compileme.c")
      echo "compileme2.c: " & $doesCompile("compileme2.c")
      echo "compileme3.c: " & $doesCompile("compileme3.c")

