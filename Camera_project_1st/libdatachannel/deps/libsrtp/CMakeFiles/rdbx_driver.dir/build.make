# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel

# Include any dependencies generated for this target.
include deps/libsrtp/CMakeFiles/rdbx_driver.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include deps/libsrtp/CMakeFiles/rdbx_driver.dir/compiler_depend.make

# Include the progress variables for this target.
include deps/libsrtp/CMakeFiles/rdbx_driver.dir/progress.make

# Include the compile flags for this target's objects.
include deps/libsrtp/CMakeFiles/rdbx_driver.dir/flags.make

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/flags.make
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o: deps/libsrtp/test/rdbx_driver.c
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o -MF CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o.d -o CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o -c /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/rdbx_driver.c

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.i"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/rdbx_driver.c > CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.i

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.s"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/rdbx_driver.c -o CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.s

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/flags.make
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o: deps/libsrtp/test/getopt_s.c
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o -MF CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o.d -o CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o -c /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/getopt_s.c

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/rdbx_driver.dir/test/getopt_s.c.i"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/getopt_s.c > CMakeFiles/rdbx_driver.dir/test/getopt_s.c.i

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/rdbx_driver.dir/test/getopt_s.c.s"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/getopt_s.c -o CMakeFiles/rdbx_driver.dir/test/getopt_s.c.s

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/flags.make
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o: deps/libsrtp/test/ut_sim.c
deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o: deps/libsrtp/CMakeFiles/rdbx_driver.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o -MF CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o.d -o CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o -c /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/ut_sim.c

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/rdbx_driver.dir/test/ut_sim.c.i"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/ut_sim.c > CMakeFiles/rdbx_driver.dir/test/ut_sim.c.i

deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/rdbx_driver.dir/test/ut_sim.c.s"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/test/ut_sim.c -o CMakeFiles/rdbx_driver.dir/test/ut_sim.c.s

# Object files for target rdbx_driver
rdbx_driver_OBJECTS = \
"CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o" \
"CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o" \
"CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o"

# External object files for target rdbx_driver
rdbx_driver_EXTERNAL_OBJECTS =

deps/libsrtp/rdbx_driver: deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/rdbx_driver.c.o
deps/libsrtp/rdbx_driver: deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/getopt_s.c.o
deps/libsrtp/rdbx_driver: deps/libsrtp/CMakeFiles/rdbx_driver.dir/test/ut_sim.c.o
deps/libsrtp/rdbx_driver: deps/libsrtp/CMakeFiles/rdbx_driver.dir/build.make
deps/libsrtp/rdbx_driver: deps/libsrtp/libsrtp2.a
deps/libsrtp/rdbx_driver: /usr/lib/x86_64-linux-gnu/libcrypto.so
deps/libsrtp/rdbx_driver: deps/libsrtp/CMakeFiles/rdbx_driver.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable rdbx_driver"
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/rdbx_driver.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
deps/libsrtp/CMakeFiles/rdbx_driver.dir/build: deps/libsrtp/rdbx_driver
.PHONY : deps/libsrtp/CMakeFiles/rdbx_driver.dir/build

deps/libsrtp/CMakeFiles/rdbx_driver.dir/clean:
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp && $(CMAKE_COMMAND) -P CMakeFiles/rdbx_driver.dir/cmake_clean.cmake
.PHONY : deps/libsrtp/CMakeFiles/rdbx_driver.dir/clean

deps/libsrtp/CMakeFiles/rdbx_driver.dir/depend:
	cd /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp /home/it/Desktop/data_channel/Camera_project_1st/libdatachannel/deps/libsrtp/CMakeFiles/rdbx_driver.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : deps/libsrtp/CMakeFiles/rdbx_driver.dir/depend
