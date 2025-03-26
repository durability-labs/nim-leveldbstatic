import os, times, strutils, strformat, random
import ../leveldbstatic as leveldb

proc benchmarkIndividualDeletes(db: LevelDb, numKeys: int): float =
  # Insert test data
  for i in 1..numKeys:
    let key = "key_" & $i
    let value = "value_" & $i
    db.put(key, value)
  
  # Benchmark individual deletes
  let startTime = cpuTime()
  for i in 1..numKeys:
    let key = "key_" & $i
    db.delete(key)
  let endTime = cpuTime()
  
  return endTime - startTime

proc benchmarkBatchDeletes(db: LevelDb, numKeys: int): float =
  # Insert test data
  for i in 1..numKeys:
    let key = "key_" & $i
    let value = "value_" & $i
    db.put(key, value)
  
  # Benchmark batch deletes
  let startTime = cpuTime()
  let batch = newBatch()
  for i in 1..numKeys:
    let key = "key_" & $i
    batch.delete(key)
  db.write(batch)
  let endTime = cpuTime()
  
  return endTime - startTime

proc benchmarkRandomAccessIndividualDeletes(db: LevelDb, numKeys: int): float =
  # Insert test data
  for i in 1..numKeys:
    let key = "key_" & $i
    let value = "value_" & $i
    db.put(key, value)
  
  # Create a randomized sequence of keys to delete
  var keys = newSeq[int](numKeys)
  for i in 0..<numKeys:
    keys[i] = i + 1
  shuffle(keys)
  
  # Benchmark individual deletes with random access
  let startTime = cpuTime()
  for i in keys:
    let key = "key_" & $i
    db.delete(key)
  let endTime = cpuTime()
  
  return endTime - startTime

proc benchmarkRandomAccessBatchDeletes(db: LevelDb, numKeys: int): float =
  # Insert test data
  for i in 1..numKeys:
    let key = "key_" & $i
    let value = "value_" & $i
    db.put(key, value)
  
  # Create a randomized sequence of keys to delete
  var keys = newSeq[int](numKeys)
  for i in 0..<numKeys:
    keys[i] = i + 1
  shuffle(keys)
  
  # Benchmark batch deletes with random access
  let startTime = cpuTime()
  let batch = newBatch()
  for i in keys:
    let key = "key_" & $i
    batch.delete(key)
  db.write(batch)
  let endTime = cpuTime()
  
  return endTime - startTime

proc runBenchmarks() =
  let dbName = getTempDir() / "benchmark_deletes"
  removeDir(dbName)
  
  let keyCounts = @[100, 1000, 10000]
  
  echo "Benchmarking Individual Deletes vs Batch Deletes"
  echo "==============================================="
  echo "Sequential Access:"
  echo "Key Count      Individual (s)       Batch (s)           Speedup"
  echo "-----------------------------------------------"
  
  for numKeys in keyCounts:
    # Sequential access benchmark
    let db1 = leveldb.open(dbName & "_seq1")
    let individualTime = benchmarkIndividualDeletes(db1, numKeys)
    db1.close()
    removeDir(db1.path)
    
    let db2 = leveldb.open(dbName & "_seq2")
    let batchTime = benchmarkBatchDeletes(db2, numKeys)
    db2.close()
    removeDir(db2.path)
    
    let speedup = individualTime / batchTime
    echo align($numKeys, 15) & align(formatFloat(individualTime, ffDecimal, 6), 20) & align(formatFloat(batchTime, ffDecimal, 6), 20) & align(formatFloat(speedup, ffDecimal, 2) & "x", 10)
  
  echo "\nRandom Access:"
  echo "Key Count      Individual (s)       Batch (s)           Speedup"
  echo "-----------------------------------------------"
  
  for numKeys in keyCounts:
    # Random access benchmark
    let db3 = leveldb.open(dbName & "_rand1")
    let randomIndividualTime = benchmarkRandomAccessIndividualDeletes(db3, numKeys)
    db3.close()
    removeDir(db3.path)
    
    let db4 = leveldb.open(dbName & "_rand2")
    let randomBatchTime = benchmarkRandomAccessBatchDeletes(db4, numKeys)
    db4.close()
    removeDir(db4.path)
    
    let speedup = randomIndividualTime / randomBatchTime
    echo align($numKeys, 15) & align(formatFloat(randomIndividualTime, ffDecimal, 6), 20) & align(formatFloat(randomBatchTime, ffDecimal, 6), 20) & align(formatFloat(speedup, ffDecimal, 2) & "x", 10)

when isMainModule:
  randomize()
  runBenchmarks()
