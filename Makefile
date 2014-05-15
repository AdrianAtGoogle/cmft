#
# Copyright 2014 Dario Manesku. All rights reserved.
# License: http://www.opensource.org/licenses/BSD-2-Clause
#

include config.mk

UNAME := $(shell uname -s)
ifeq ($(UNAME),$(filter $(UNAME),Linux Darwin))
ifeq ($(UNAME),$(filter $(UNAME),Darwin))
OS=darwin
else
OS=linux
endif
else
OS=windows
endif

PREMAKE4=./3rdparty/bx/tools/bin/$(OS)/premake4

export CMFT_WIN_CLANG_DIR_=$(subst \,\\,$(subst /,\,$(WIN_CLANG_DIR)))
export CMFT_WIN_MINGW_DIR_=$(subst \,\\,$(subst /,\,$(WIN_MINGW_DIR)))

.PHONY: all
all:
	$(PREMAKE4) --file=premake/cmft.lua xcode4
	$(PREMAKE4) --file=premake/cmft.lua vs2008
	$(PREMAKE4) --file=premake/cmft.lua vs2010
	$(PREMAKE4) --file=premake/cmft.lua vs2012
	$(PREMAKE4) --file=premake/cmft.lua --compiler=osx         gmake
	$(PREMAKE4) --file=premake/cmft.lua --compiler=linux-gcc   gmake
#	$(PREMAKE4) --file=premake/cmft.lua --compiler=linux-clang gmake
#	$(PREMAKE4) --file=premake/cmft.lua --compiler=win-clang   gmake
#	$(PREMAKE4) --file=premake/cmft.lua --compiler=win-mingw   gmake

.PHONY: clean-projects
clean-projects:
	@echo Removing _projects folder.
	-@rm -rf _projects

.PHONY: clean-build
clean-build:
	@echo Removing _build folder.
	-@rm -rf _build

.PHONY: clean
clean: clean-build clean-projects

_projects/xcode4:
	$(PREMAKE4) --file=premake/cmft.lua xcode4

_projects/vs2008:
	$(PREMAKE4) --file=premake/cmft.lua vs2008
vs2008-debug32:
	"$(subst /,\\,$(VS2008_DEVENV_DIR))\devenv" _projects/vs2008/cmft.sln /Build "Debug|Win32"
vs2008-release32:
	"$(subst /,\\,$(VS2008_DEVENV_DIR))\devenv" _projects/vs2008/cmft.sln /Build "Release|Win32"
vs2008-debug64:
	"$(subst /,\\,$(VS2008_DEVENV_DIR))\devenv" _projects/vs2008/cmft.sln /Build "Debug|x64"
vs2008-release64:
	"$(subst /,\\,$(VS2008_DEVENV_DIR))\devenv" _projects/vs2008/cmft.sln /Build "Release|x64"
vs2008: vs2008-debug32 vs2008-release32 vs2008-debug64 vs2008-release64

_projects/vs2010:
	$(PREMAKE4) --file=premake/cmft.lua vs2010
vs2010-debug32:
	"$(subst /,\\,$(VS2010_DEVENV_DIR))\devenv" _projects/vs2010/cmft.sln /Build "Debug|Win32"
vs2010-release32:
	"$(subst /,\\,$(VS2010_DEVENV_DIR))\devenv" _projects/vs2010/cmft.sln /Build "Release|Win32"
vs2010-debug64:
	"$(subst /,\\,$(VS2010_DEVENV_DIR))\devenv" _projects/vs2010/cmft.sln /Build "Debug|x64"
vs2010-release64:
	"$(subst /,\\,$(VS2010_DEVENV_DIR))\devenv" _projects/vs2010/cmft.sln /Build "Release|x64"

_projects/vs2012:
	$(PREMAKE4) --file=premake/cmft.lua vs2012
vs2012-debug32:
	"$(subst /,\\,$(VS2012_DEVENV_DIR))\devenv" _projects/vs2012/cmft.sln /Build "Debug|Win32"
vs2012-release32:
	"$(subst /,\\,$(VS2012_DEVENV_DIR))\devenv" _projects/vs2012/cmft.sln /Build "Release|Win32"
vs2012-debug64:
	"$(subst /,\\,$(VS2012_DEVENV_DIR))\devenv" _projects/vs2012/cmft.sln /Build "Debug|x64"
vs2012-release64:
	"$(subst /,\\,$(VS2012_DEVENV_DIR))\devenv" _projects/vs2012/cmft.sln /Build "Release|x64"

_projects/gmake-linux-gcc:
	$(PREMAKE4) --file=premake/cmft.lua --gcc=linux-gcc gmake
linux-gcc-debug32: _projects/gmake-linux-gcc
	make -R -C _projects/gmake-linux-gcc config=debug32
linux-gcc-release32: _projects/gmake-linux-gcc
	make -R -C _projects/gmake-linux-gcc config=release32
linux-gcc-debug64: _projects/gmake-linux-gcc
	make -R -C _projects/gmake-linux-gcc config=debug64
linux-gcc-release64: _projects/gmake-linux-gcc
	make -R -C _projects/gmake-linux-gcc config=release64
linux-gcc: linux-debug32 linux-release32 linux-debug64 linux-release64

_projects/gmake-osx:
	$(PREMAKE4) --file=premake/cmft.lua --clang=osx gmake
osx-debug32: _projects/gmake-osx
	make -R -C _projects/gmake-osx config=debug32
osx-release32: _projects/gmake-osx
	make -R -C _projects/gmake-osx config=release32
osx-debug64: _projects/gmake-osx
	make -R -C _projects/gmake-osx config=debug64
osx-release64: _projects/gmake-osx
	make -R -C _projects/gmake-osx config=release64
osx: osx-debug32 osx-release32 osx-debug64 osx-release64

#_projects/gmake-linux-clang:
#	$(PREMAKE4) --file=premake/cmft.lua --clang=linux-clang gmake
#linux-clang-debug32: _projects/gmake-linux-clang
#	make -R -C _projects/gmake-linux-clang config=debug32
#linux-clang-release32: _projects/gmake-linux-clang
#	make -R -C _projects/gmake-linux-clang config=release32
#linux-clang-debug64: _projects/gmake-linux-clang
#	make -R -C _projects/gmake-linux-clang config=debug64
#linux-clang-release64: _projects/gmake-linux-clang
#	make -R -C _projects/gmake-linux-clang config=release64
#linux-clang: linux-debug32 linux-release32 linux-debug64 linux-release64

#_projects/gmake-win-clang:
#	$(PREMAKE4) --file=premake/cmft.lua --clang=win-clang gmake
#win-clang-debug32: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-clang config=debug32
#win-clang-release32: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-clang config=release32
#win-clang-debug64: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-clang config=debug64
#win-clang-release64: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-clang config=release64
#win-clang: win-debug32 win-release32 win-debug64 win-release64
#
#_projects/gmake-win-mingw:
#	$(PREMAKE4) --file=premake/cmft.lua --mingw=win-clang gmake
#win-mingw-debug32: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-mingw config=debug32
#win-mingw-release32: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-mingw config=release32
#win-mingw-debug64: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-mingw config=debug64
#win-mingw-release64: _projects/gmake-win-clang
#	make -R -C _projects/gmake-win-mingw config=release64
#win-mingw: win-debug32 win-release32 win-debug64 win-release64
