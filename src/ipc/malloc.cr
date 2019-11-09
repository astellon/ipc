module IPC
  module SharedMemory(T)
    extend self

    @@malloced = [] of Pointer(Void)
    @@ids = [] of Int32

    def malloc(key : String, id : Int, size : Int, addr = Pointer(Void).null, flags = IPC::Flag::Create|IPC::Flag::Read|IPC::Flag::Write)
      k = IPC.getkey(key, id)
      i = IPC.getid(T, k, size, flags)
      p = IPC.attach(T, i, addr, 0)
      @@malloced << p.as(Pointer(Void))
      @@ids << i
      return p
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