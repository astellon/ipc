lib LibC
  alias ShmattT = UInt32

  # memory layout of `shmid_ds`
  Sizeof_struct_shmid_ds = 112
  Offsetof_shmid_ds_shm_perm = 0
  Offsetof_shmid_ds_shm_segsz = 48
  Offsetof_shmid_ds_shm_lpid = 84
  Offsetof_shmid_ds_shm_cpid = 80
  Offsetof_shmid_ds_shm_nattch = 88
  Offsetof_shmid_ds_shm_atime = 56
  Offsetof_shmid_ds_shm_dtime = 64
  Offsetof_shmid_ds_shm_ctime = 72

  # the type of `shm_atime`, `shm_dtime` and `shm_ctime`
  alias Typeof_Shmid_Ds_Time = Int64

  SHM_R = Int32.new(256)
  SHM_W = Int32.new(128)

  SHM_RDONLY = Int32.new(4096)
  SHM_RND = Int32.new(8192)

  SHM_LOCK = Int32.new(11)
  SHM_UNLOCK = Int32.new(12)

  fun shmget(key : KeyT, size : SizeT, flag : Int) : Int
  fun shmat(id : Int, addr : Void*, flag : Int) : Void*
  fun shmctl(id : Int, cmd : Int, buf : Void*) : Int
  fun shmdt(addr : Void*) : Int
  # NOTE: the type of the argument `buf` of shmctl is shmid_ds
end
