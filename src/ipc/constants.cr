require "./lib/*"

module IPC
  module Flag
    Create    = LibC::IPC_CREAT
    Exclusive = LibC::IPC_EXCL
    NoWait    = LibC::IPC_NOWAIT
    Read      = LibC::SHM_R
    Write     = LibC::SHM_W
  end

  module Control
    Remove = LibC::IPC_RMID
    Set    = LibC::IPC_SET
    Status = LibC::IPC_STAT
  end

  module Lock
    Lock   = LibC::SHM_LOCK
    Unlock = LibC::SHM_UNLOCK
  end

  PrivateKeyID = LibC::IPC_PRIVATE
end
