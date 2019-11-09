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

  def attach(type : T.class, id : LibC::Int, addr : Pointer(Void), flag : LibC::Int) forall T
    return IPC.raiseif(LibC.shmat(id, addr, flag).as(Pointer(T)), Pointer(Void).null, "Cannot attach shared momory.")
  end

  def detach(ptr : Pointer(T)) forall T
    return IPC.raiseif(LibC.shmdt(ptr), -1, "Cannot detach memory.")
  end

  def getds(id)
    ptr = Pointer(Void).malloc(LibC::Sizeof_struct_shmid_ds)
    IPC.raiseif(LibC.shmctl(id, IPC::Control::Status, ptr), -1, "Cannot get data structure.")
    return IPC::ShmidDs.new(ptr)
  end

  def remove(id : LibC::Int)
    return IPC.raiseif(LibC.shmctl(id, IPC::Control::Remove, nil), -1, "Cannot detach memory.")
  end
end
