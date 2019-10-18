require "./libipc.cr"
require "./libshm.cr"

module IPC
  class ShmidDs
    property raw : Pointer(Void)

    def initialize
      @raw = Pointer(Void).malloc(LibC::Sizeof_struct_shmid_ds)
    end

    {% for member in {"perm", "segz", "lpid", "cpid", "nattch", "atime", "dtime", "ctime"} %}
    def {{member.id}}
      offset = LibC::Offsetof_shmid_ds_shm_{{member.id}}
      return (@raw + offset).as(Pointer(LibC::ShmattT)).value
    end
    {% end %}

    def unsafe
      @raw
    end
  end

  class SharedMemory(T)
    property key : LibC::KeyT
    property key_id : LibC::Int
    property shm_id : LibC::Int
    property ptr : Pointer(T)
    property size : Int32
    property slice : Slice(T)

    def initialize(filepath : String, @key_id : Int32, @size : Int32, flag : Int32)
      if !File.file?(filepath)
        File.touch(filepath)
      end

      @key = LibC.ftok(filepath, @key_id)

      if @key == -1
        raise "Cannot aquire IPC key."
      end

      @shm_id = LibC.shmget(key, size*sizeof(T), flag)

      if @shm_id == -1
        raise "Cannot get shared memory id."
      end

      @ptr = LibC.shmat(@shm_id, Pointer(T).null, 0).as(Pointer(T))

      if @ptr == Pointer(T).null
        raise "Cannot attach shared momory."
      end

      @slice = Slice(T).new(@ptr, size)
    end

    def finalize
      if LibC.shmdt(@ptr) == -1
        raise "Cannot detach shared memory."
      end

      ds = IPC::ShmidDs.new
      LibC.shmctl(@shm_id, LibC::IPC_STAT, ds.unsafe) == -1

      if ds.nattch == 0
        LibC.shmctl(@shm_id, LibC::IPC_RMID, Pointer(T).null)
      end
    end
  end # class SharedMemory
end   # module IPC
