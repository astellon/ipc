module IPC
  module SharedMemory(T)
    extend self

    @@malloced = [] of Pointer(Void)
    @@ids = [] of Int32

    def malloc(key : String, id : Int, size : Int, addr = Pointer(Void).null, flags = IPC::Flag::Create | IPC::Flag::Read | IPC::Flag::Write)
      shm_key = IPC.getkey(key, id)
      shm_id = IPC.getid(T, shm_key, size, flags)
      shm_ptr = IPC.attach(T, shm_id, addr, 0)

      SharedMemory.manage(shm_id, shm_ptr.as(Pointer(Void)))

      return shm_ptr
    end

    def manage(id : Int32, ptr : Pointer(U)) forall U
      @@ids << id
      @@malloced << ptr.as(Pointer(Void))
    end

    at_exit {
      @@malloced.each do |p|
        IPC.detach(p)
      end

      @@ids.each do |i|
        ds = IPC.getds(i)
        if ds.nattch == 0
          IPC.remove(i)
        end
      end
    }

  end
end
