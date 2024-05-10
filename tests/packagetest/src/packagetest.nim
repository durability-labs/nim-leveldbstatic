import os
import options
import leveldb

when isMainModule:
  let tempDir = getTempDir() / "testleveldb" / "tooldb"
  createdir(tempDir)
  let db = leveldb.open(tempDir)
  db.put("hello", "world")
  let val = db.get("hello")
  if val.isSome() and val.get() == "world":
    echo "leveldb works."
  db.close()
  removedir(tempDir)
