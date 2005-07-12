# Header.

MULTILIB_ABIS="x86 amd64"
DEFAULT_ABI="amd64"

CFLAGS_amd64="-m64"
LDFLAGS_amd64="-m elf_x86_64"
CHOST_amd64="x86_64-pc-linux-gnu"
CDEFINE_amd64="__x86_64__"
LIBDIR_amd64="lib64"

CFLAGS_x86="-m32 -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib"
LDFLAGS_x86="-m elf_i386 -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib"
CHOST_x86="i686-pc-linux-gnu"
CDEFINE_x86="__i386__"
LIBDIR_x86="lib32"
