set(QEMU_INCLUDE_DIR /usr/include CACHE PATH
    "Folder that contains qemu/qemu-plugin.h")
find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB2 REQUIRED IMPORTED_TARGET glib-2.0)

include_directories(${QEMU_INCLUDE_DIR})

add_llvm_library(QemuRelay SHARED
  Plugin.cpp

  LINK_COMPONENTS
  Support
  )
target_link_libraries(QemuRelay PRIVATE PkgConfig::GLIB2)
