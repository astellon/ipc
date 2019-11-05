require "./lib/*"

require "./constants.cr"
require "./functions.cr"

module IPC
  class ShmidDs
    getter raw : Pointer(Void)

    def initialize
      @raw = Pointer(Void).malloc(LibC::Sizeof_struct_shmid_ds)
    end

    def initialize(@raw)
    end

    def perm
      offset = LibC::Offsetof_shmid_ds_shm_perm
      return IPCPerm.new(@raw + offset)
    end

    def segz
      offset = LibC::Offsetof_shmid_ds_shm_segz
      return (@raw + offset).as(Pointer(LibC::SizeT)).value
    end

    {% for member in {"lpid", "cpid"} %}
    def {{member.id}}
      offset = LibC::Offsetof_shmid_ds_shm_{{member.id}}
      return (@raw + offset).as(Pointer(LibC::PidT)).value
    end
    {% end %}

    {% for member in {"atime", "dtime", "ctime"} %}
    def {{member.id}}
      offset = LibC::Offsetof_shmid_ds_shm_{{member.id}}
      return (@raw + offset).as(Pointer(LibC::Typeof_Shmid_Ds_Time)).value
    end
    {% end %}

    def nattch
      offset = LibC::Offsetof_shmid_ds_shm_nattch
      return (@raw + offset).as(Pointer(LibC::ShmattT)).value
    end

    def unsafe
      @raw
    end
  end

  class IPCPerm
    getter raw : Pointer(Void)

    def initialize
      @raw = Pointer(Void).malloc(LibC::Sizeof_struct_ipc_perm)
    end

    def initialize(@raw)
    end

    {% for member in {"uid", "gid", "cuid", "cgid"} %}
    def {{member.id}}
      offset = LibC::Offsetof_shmid_ds_ipc_perm_{{member.id}}
      return (@raw + offset).as(Pointer(LibC::UidT)).value
    end
    {% end %}

    def mode
      offset = LibC::Offsetof_shmid_ds_ipc_perm_mode
      return (@raw + offset).as(Pointer(LibC::Typeof_Ipc_Perm_Mode)).value
    end

    def unsafe
      @raw
    end
  end
end
