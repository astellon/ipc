require "./lib/*"

module IPC
  extend self

  macro raiseif(ex, unexpect, message)
    ( ret = {{ex}} ) == {{unexpect}} ? raise({{message}}) : ret
  end

  def getkey(filepath : String, id : Int)
    if !File.file?(filepath)
      File.touch(filepath)
    end

    return IPC.raiseif(LibC.ftok(filepath, id), -1, "Cannot aquire IPC key #{filepath}")
  end

  def getid(type : T.class, key : LibC::KeyT, size : Int, flag : LibC::Int) forall T
    return IPC.raiseif(LibC.shmget(key, size*sizeof(T), flag), -1, "Cannot get shared memory id.")
  end

  def attach(type : T.class, id : LibC::Int, flag : LibC::Int) forall T
    return IPC.raiseif(LibC.shmat(id, Pointer(T).null, 0).as(Pointer(T)), Pointer(T).null, "Cannot attach shared momory.")
  end

  def detach(ptr : Pointer(T)) forall T
    return IPC.raiseif(LibC.shmdt(@ptr), -1, "Cannot detach memory.")
  end

  def remove(id : LibC::Int)
    return IPC.raiseif(LibC.shmctl(@shm_id, LibC::IPC_RMID, Pointer(T).null), -1, "Cannot detach memory.")
  end
end
