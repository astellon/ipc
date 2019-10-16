lib LibC
  alias KeyT = Int32

  # memory layout of `ipc_perm`
  Sizeof_struct_ipc_perm = 48
  Offsetof_ipc_perm_uid = 4
  Offsetof_ipc_perm_gid = 8
  Offsetof_ipc_perm_cuid = 12
  Offsetof_ipc_perm_cgid = 16
  Offsetof_ipc_perm_mode = 20

  # the type of `mode`
  alias Typeof_Ipc_Perm_Mode = UInt16

  IPC_CREAT = Int32.new(512)
  IPC_EXCL = Int32.new(1024)
  IPC_NOWAIT = Int32.new(2048)

  IPC_PRIVATE = Int32.new(0)

  IPC_RMID = Int32.new(0)
  IPC_SET = Int32.new(1)
  IPC_STAT = Int32.new(2)

  fun ftok(pathname : UInt8*, proj_id : Int32) : KeyT
end
