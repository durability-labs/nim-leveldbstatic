when defined(windows):
  {.compile: "./src/vendor/util/env_windows.cc".}
  {.passc: "-DLEVELDB_PLATFORM_POSIX".}

when defined(posix):
  {.compile: "./src/vendor/util/env_posix.cc".}
  {.passc: "-DLEVELDB_PLATFORM_WINDOWS".}

# Generated @ 2024-05-09T14:57:19+02:00
# Command line:
#   /home/ben/.nimble/pkgs/nimterop-0.6.13/nimterop/toast --compile=./src/vendor/helpers/memenv/memenv.cc --compile=./src/vendor/table/table.cc --compile=./src/vendor/table/iterator.cc --compile=./src/vendor/table/merger.cc --compile=./src/vendor/table/block.cc --compile=./src/vendor/table/table_builder.cc --compile=./src/vendor/table/format.cc --compile=./src/vendor/table/two_level_iterator.cc --compile=./src/vendor/table/filter_block.cc --compile=./src/vendor/table/block_builder.cc --compile=./src/vendor/db/write_batch.cc --compile=./src/vendor/db/version_edit.cc --compile=./src/vendor/db/dbformat.cc --compile=./src/vendor/db/builder.cc --compile=./src/vendor/db/repair.cc --compile=./src/vendor/db/db_impl.cc --compile=./src/vendor/db/dumpfile.cc --compile=./src/vendor/db/filename.cc --compile=./src/vendor/db/log_reader.cc --compile=./src/vendor/db/memtable.cc --compile=./src/vendor/db/table_cache.cc --compile=./src/vendor/db/c.cc --compile=./src/vendor/db/log_writer.cc --compile=./src/vendor/db/version_set.cc --compile=./src/vendor/db/db_iter.cc --compile=./src/vendor/util/hash.cc --compile=./src/vendor/util/options.cc --compile=./src/vendor/util/comparator.cc --compile=./src/vendor/util/coding.cc --compile=./src/vendor/util/histogram.cc --compile=./src/vendor/util/logging.cc --compile=./src/vendor/util/cache.cc --compile=./src/vendor/util/env.cc --compile=./src/vendor/util/filter_policy.cc --compile=./src/vendor/util/arena.cc --compile=./src/vendor/util/bloom.cc --compile=./src/vendor/util/crc32c.cc --compile=./src/vendor/util/status.cc --pnim --preprocess --noHeader --includeDirs=./src/vendor --includeDirs=./src/vendor/helpers --includeDirs=./src/vendor/helpers/memenv --includeDirs=./src/vendor/port --includeDirs=./src/vendor/include --includeDirs=./build/include ./src/vendor/include/leveldb/c.h

{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}


{.experimental: "codeReordering".}
{.passC: "-I./src/vendor".}
{.passC: "-I./src/vendor/helpers".}
{.passC: "-I./src/vendor/helpers/memenv".}
{.passC: "-I./src/vendor/port".}
{.passC: "-I./src/vendor/include".}
{.passC: "-I./build/include".}
{.compile: "./src/vendor/helpers/memenv/memenv.cc".}
{.compile: "./src/vendor/table/table.cc".}
{.compile: "./src/vendor/table/iterator.cc".}
{.compile: "./src/vendor/table/merger.cc".}
{.compile: "./src/vendor/table/block.cc".}
{.compile: "./src/vendor/table/table_builder.cc".}
{.compile: "./src/vendor/table/format.cc".}
{.compile: "./src/vendor/table/two_level_iterator.cc".}
{.compile: "./src/vendor/table/filter_block.cc".}
{.compile: "./src/vendor/table/block_builder.cc".}
{.compile: "./src/vendor/db/write_batch.cc".}
{.compile: "./src/vendor/db/version_edit.cc".}
{.compile: "./src/vendor/db/dbformat.cc".}
{.compile: "./src/vendor/db/builder.cc".}
{.compile: "./src/vendor/db/repair.cc".}
{.compile: "./src/vendor/db/db_impl.cc".}
{.compile: "./src/vendor/db/dumpfile.cc".}
{.compile: "./src/vendor/db/filename.cc".}
{.compile: "./src/vendor/db/log_reader.cc".}
{.compile: "./src/vendor/db/memtable.cc".}
{.compile: "./src/vendor/db/table_cache.cc".}
{.compile: "./src/vendor/db/c.cc".}
{.compile: "./src/vendor/db/log_writer.cc".}
{.compile: "./src/vendor/db/version_set.cc".}
{.compile: "./src/vendor/db/db_iter.cc".}
{.compile: "./src/vendor/util/hash.cc".}
{.compile: "./src/vendor/util/options.cc".}
{.compile: "./src/vendor/util/comparator.cc".}
{.compile: "./src/vendor/util/coding.cc".}
{.compile: "./src/vendor/util/histogram.cc".}
{.compile: "./src/vendor/util/logging.cc".}
{.compile: "./src/vendor/util/cache.cc".}
{.compile: "./src/vendor/util/env.cc".}
{.compile: "./src/vendor/util/filter_policy.cc".}
{.compile: "./src/vendor/util/arena.cc".}
{.compile: "./src/vendor/util/bloom.cc".}
{.compile: "./src/vendor/util/crc32c.cc".}
{.compile: "./src/vendor/util/status.cc".}
defineEnum(Enum_ch1)
const
  leveldb_no_compression* = (0).cint
  leveldb_snappy_compression* = (1).cint
type
  leveldb_t* {.incompleteStruct.} = object
  leveldb_cache_t* {.incompleteStruct.} = object
  leveldb_comparator_t* {.incompleteStruct.} = object
  leveldb_env_t* {.incompleteStruct.} = object
  leveldb_filelock_t* {.incompleteStruct.} = object
  leveldb_filterpolicy_t* {.incompleteStruct.} = object
  leveldb_iterator_t* {.incompleteStruct.} = object
  leveldb_logger_t* {.incompleteStruct.} = object
  leveldb_options_t* {.incompleteStruct.} = object
  leveldb_randomfile_t* {.incompleteStruct.} = object
  leveldb_readoptions_t* {.incompleteStruct.} = object
  leveldb_seqfile_t* {.incompleteStruct.} = object
  leveldb_snapshot_t* {.incompleteStruct.} = object
  leveldb_writablefile_t* {.incompleteStruct.} = object
  leveldb_writebatch_t* {.incompleteStruct.} = object
  leveldb_writeoptions_t* {.incompleteStruct.} = object
proc leveldb_open*(options: ptr leveldb_options_t; name: cstring;
                   errptr: ptr cstring): ptr leveldb_t {.importc, cdecl.}
proc leveldb_close*(db: ptr leveldb_t) {.importc, cdecl.}
proc leveldb_put*(db: ptr leveldb_t; options: ptr leveldb_writeoptions_t;
                  key: cstring; keylen: uint; val: cstring; vallen: uint;
                  errptr: ptr cstring) {.importc, cdecl.}
proc leveldb_delete*(db: ptr leveldb_t; options: ptr leveldb_writeoptions_t;
                     key: cstring; keylen: uint; errptr: ptr cstring) {.importc,
    cdecl.}
proc leveldb_write*(db: ptr leveldb_t; options: ptr leveldb_writeoptions_t;
                    batch: ptr leveldb_writebatch_t; errptr: ptr cstring) {.
    importc, cdecl.}
proc leveldb_get*(db: ptr leveldb_t; options: ptr leveldb_readoptions_t;
                  key: cstring; keylen: uint; vallen: ptr uint;
                  errptr: ptr cstring): cstring {.importc, cdecl.}
  ## ```
                                                                  ##   Returns NULL if not found.  A malloc()ed array otherwise.
                                                                  ##      Stores the length of the array invallen.
                                                                  ## ```
proc leveldb_create_iterator*(db: ptr leveldb_t;
                              options: ptr leveldb_readoptions_t): ptr leveldb_iterator_t {.
    importc, cdecl.}
proc leveldb_create_snapshot*(db: ptr leveldb_t): ptr leveldb_snapshot_t {.
    importc, cdecl.}
proc leveldb_release_snapshot*(db: ptr leveldb_t;
                               snapshot: ptr leveldb_snapshot_t) {.importc,
    cdecl.}
proc leveldb_property_value*(db: ptr leveldb_t; propname: cstring): cstring {.
    importc, cdecl.}
  ## ```
                    ##   Returns NULL if property name is unknown.
                    ##      Else returns a pointer to a malloc()-ed null-terminated value.
                    ## ```
proc leveldb_approximate_sizes*(db: ptr leveldb_t; num_ranges: cint;
                                range_start_key: ptr cstring;
                                range_start_key_len: ptr uint;
                                range_limit_key: ptr cstring;
                                range_limit_key_len: ptr uint; sizes: ptr uint64) {.
    importc, cdecl.}
proc leveldb_compact_range*(db: ptr leveldb_t; start_key: cstring;
                            start_key_len: uint; limit_key: cstring;
                            limit_key_len: uint) {.importc, cdecl.}
proc leveldb_destroy_db*(options: ptr leveldb_options_t; name: cstring;
                         errptr: ptr cstring) {.importc, cdecl.}
proc leveldb_repair_db*(options: ptr leveldb_options_t; name: cstring;
                        errptr: ptr cstring) {.importc, cdecl.}
proc leveldb_iter_destroy*(a1: ptr leveldb_iterator_t) {.importc, cdecl.}
proc leveldb_iter_valid*(a1: ptr leveldb_iterator_t): uint8 {.importc, cdecl.}
proc leveldb_iter_seek_to_first*(a1: ptr leveldb_iterator_t) {.importc, cdecl.}
proc leveldb_iter_seek_to_last*(a1: ptr leveldb_iterator_t) {.importc, cdecl.}
proc leveldb_iter_seek*(a1: ptr leveldb_iterator_t; k: cstring; klen: uint) {.
    importc, cdecl.}
proc leveldb_iter_next*(a1: ptr leveldb_iterator_t) {.importc, cdecl.}
proc leveldb_iter_prev*(a1: ptr leveldb_iterator_t) {.importc, cdecl.}
proc leveldb_iter_key*(a1: ptr leveldb_iterator_t; klen: ptr uint): cstring {.
    importc, cdecl.}
proc leveldb_iter_value*(a1: ptr leveldb_iterator_t; vlen: ptr uint): cstring {.
    importc, cdecl.}
proc leveldb_iter_get_error*(a1: ptr leveldb_iterator_t; errptr: ptr cstring) {.
    importc, cdecl.}
proc leveldb_writebatch_create*(): ptr leveldb_writebatch_t {.importc, cdecl.}
proc leveldb_writebatch_destroy*(a1: ptr leveldb_writebatch_t) {.importc, cdecl.}
proc leveldb_writebatch_clear*(a1: ptr leveldb_writebatch_t) {.importc, cdecl.}
proc leveldb_writebatch_put*(a1: ptr leveldb_writebatch_t; key: cstring;
                             klen: uint; val: cstring; vlen: uint) {.importc,
    cdecl.}
proc leveldb_writebatch_delete*(a1: ptr leveldb_writebatch_t; key: cstring;
                                klen: uint) {.importc, cdecl.}
proc leveldb_writebatch_iterate*(a1: ptr leveldb_writebatch_t; state: pointer;
    put: proc (a1: pointer; k: cstring; klen: uint; v: cstring; vlen: uint) {.
    cdecl.}; deleted: proc (a1: pointer; k: cstring; klen: uint) {.cdecl.}) {.
    importc, cdecl.}
proc leveldb_writebatch_append*(destination: ptr leveldb_writebatch_t;
                                source: ptr leveldb_writebatch_t) {.importc,
    cdecl.}
proc leveldb_options_create*(): ptr leveldb_options_t {.importc, cdecl.}
proc leveldb_options_destroy*(a1: ptr leveldb_options_t) {.importc, cdecl.}
proc leveldb_options_set_comparator*(a1: ptr leveldb_options_t;
                                     a2: ptr leveldb_comparator_t) {.importc,
    cdecl.}
proc leveldb_options_set_filter_policy*(a1: ptr leveldb_options_t;
                                        a2: ptr leveldb_filterpolicy_t) {.
    importc, cdecl.}
proc leveldb_options_set_create_if_missing*(a1: ptr leveldb_options_t; a2: uint8) {.
    importc, cdecl.}
proc leveldb_options_set_error_if_exists*(a1: ptr leveldb_options_t; a2: uint8) {.
    importc, cdecl.}
proc leveldb_options_set_paranoid_checks*(a1: ptr leveldb_options_t; a2: uint8) {.
    importc, cdecl.}
proc leveldb_options_set_env*(a1: ptr leveldb_options_t; a2: ptr leveldb_env_t) {.
    importc, cdecl.}
proc leveldb_options_set_info_log*(a1: ptr leveldb_options_t;
                                   a2: ptr leveldb_logger_t) {.importc, cdecl.}
proc leveldb_options_set_write_buffer_size*(a1: ptr leveldb_options_t; a2: uint) {.
    importc, cdecl.}
proc leveldb_options_set_max_open_files*(a1: ptr leveldb_options_t; a2: cint) {.
    importc, cdecl.}
proc leveldb_options_set_cache*(a1: ptr leveldb_options_t;
                                a2: ptr leveldb_cache_t) {.importc, cdecl.}
proc leveldb_options_set_block_size*(a1: ptr leveldb_options_t; a2: uint) {.
    importc, cdecl.}
proc leveldb_options_set_block_restart_interval*(a1: ptr leveldb_options_t;
    a2: cint) {.importc, cdecl.}
proc leveldb_options_set_max_file_size*(a1: ptr leveldb_options_t; a2: uint) {.
    importc, cdecl.}
proc leveldb_options_set_compression*(a1: ptr leveldb_options_t; a2: cint) {.
    importc, cdecl.}
proc leveldb_comparator_create*(state: pointer;
                                destructor: proc (a1: pointer) {.cdecl.};
    compare: proc (a1: pointer; a: cstring; alen: uint; b: cstring; blen: uint): cint {.
    cdecl.}; name: proc (a1: pointer): cstring {.cdecl.}): ptr leveldb_comparator_t {.
    importc, cdecl.}
proc leveldb_comparator_destroy*(a1: ptr leveldb_comparator_t) {.importc, cdecl.}
proc leveldb_filterpolicy_create*(state: pointer;
                                  destructor: proc (a1: pointer) {.cdecl.};
    create_filter: proc (a1: pointer; key_array: ptr cstring;
                         key_length_array: ptr uint; num_keys: cint;
                         filter_length: ptr uint): cstring {.cdecl.};
    key_may_match: proc (a1: pointer; key: cstring; length: uint;
                         filter: cstring; filter_length: uint): uint8 {.cdecl.};
                                  name: proc (a1: pointer): cstring {.cdecl.}): ptr leveldb_filterpolicy_t {.
    importc, cdecl.}
proc leveldb_filterpolicy_destroy*(a1: ptr leveldb_filterpolicy_t) {.importc,
    cdecl.}
proc leveldb_filterpolicy_create_bloom*(bits_per_key: cint): ptr leveldb_filterpolicy_t {.
    importc, cdecl.}
proc leveldb_readoptions_create*(): ptr leveldb_readoptions_t {.importc, cdecl.}
proc leveldb_readoptions_destroy*(a1: ptr leveldb_readoptions_t) {.importc,
    cdecl.}
proc leveldb_readoptions_set_verify_checksums*(a1: ptr leveldb_readoptions_t;
    a2: uint8) {.importc, cdecl.}
proc leveldb_readoptions_set_fill_cache*(a1: ptr leveldb_readoptions_t;
    a2: uint8) {.importc, cdecl.}
proc leveldb_readoptions_set_snapshot*(a1: ptr leveldb_readoptions_t;
                                       a2: ptr leveldb_snapshot_t) {.importc,
    cdecl.}
proc leveldb_writeoptions_create*(): ptr leveldb_writeoptions_t {.importc, cdecl.}
proc leveldb_writeoptions_destroy*(a1: ptr leveldb_writeoptions_t) {.importc,
    cdecl.}
proc leveldb_writeoptions_set_sync*(a1: ptr leveldb_writeoptions_t; a2: uint8) {.
    importc, cdecl.}
proc leveldb_cache_create_lru*(capacity: uint): ptr leveldb_cache_t {.importc,
    cdecl.}
proc leveldb_cache_destroy*(cache: ptr leveldb_cache_t) {.importc, cdecl.}
proc leveldb_create_default_env*(): ptr leveldb_env_t {.importc, cdecl.}
proc leveldb_env_destroy*(a1: ptr leveldb_env_t) {.importc, cdecl.}
proc leveldb_env_get_test_directory*(a1: ptr leveldb_env_t): cstring {.importc,
    cdecl.}
  ## ```
           ##   If not NULL, the returned buffer must be released using leveldb_free().
           ## ```
proc leveldb_free*(`ptr`: pointer) {.importc, cdecl.}
  ## ```
                                                     ##   Utility 
                                                     ##      Calls free(ptr).
                                                     ##      REQUIRES: ptr was malloc()-ed and returned by one of the routines
                                                     ##      in this file.  Note that in certain cases (typically on Windows), you
                                                     ##      may need to call this routine instead of free(ptr) to dispose of
                                                     ##      malloc()-ed memory returned by this library.
                                                     ## ```
proc leveldb_major_version*(): cint {.importc, cdecl.}
  ## ```
                                                      ##   Return the major version number for this release.
                                                      ## ```
proc leveldb_minor_version*(): cint {.importc, cdecl.}
  ## ```
                                                      ##   Return the minor version number for this release.
                                                      ## ```
{.pop.}
