# Use, modification, and distribution are
# subject to the Boost Software License, Version 1.0. (See accompanying
# file LICENSE.txt)
#
# Copyright Rene Rivera 2020.

# For Drone CI we use the Starlark scripting language to reduce duplication.
# As the yaml syntax for Drone CI is rather limited.
#
#
globalenv={'B2_VARIANT': 'variant=release,debug'}
linuxglobalimage="cppalliance/droneubuntu1604:1"
windowsglobalimage="cppalliance/dronevs2019"

def main(ctx):
  return [
  linux_cxx("B2_TOOLSET=gcc-4.8 B2_CXXSTD=03,11 Job 0", "g++-4.8", packages="g++-4.8", buildtype="boost", image=linuxglobalimage, environment={'B2_TOOLSET': 'gcc-4.8', 'B2_CXXSTD': '03,11', 'DRONE_JOB_UUID': 'b6589fc6ab'}, globalenv=globalenv),
  linux_cxx("B2_TOOLSET=gcc-5 B2_CXXSTD=11 Job 1", "g++-5", packages="g++-5", buildtype="boost", image=linuxglobalimage, environment={'B2_TOOLSET': 'gcc-5', 'B2_CXXSTD': '11', 'DRONE_JOB_UUID': '356a192b79'}, globalenv=globalenv),
  linux_cxx("B2_TOOLSET=gcc-6 B2_CXXSTD=11,14 Job 2", "g++-6", packages="g++-6", buildtype="boost", image=linuxglobalimage, environment={'B2_TOOLSET': 'gcc-6', 'B2_CXXSTD': '11,14', 'DRONE_JOB_UUID': 'da4b9237ba'}, globalenv=globalenv),
  linux_cxx("B2_TOOLSET=gcc-7 B2_CXXSTD=11,14,17 Job 3", "g++-7", packages="g++-7", buildtype="boost", image=linuxglobalimage, environment={'B2_TOOLSET': 'gcc-7', 'B2_CXXSTD': '11,14,17', 'DRONE_JOB_UUID': '77de68daec'}, globalenv=globalenv),
  linux_cxx("B2_TOOLSET=gcc-8 B2_CXXSTD=14,17,2a Job 4", "g++-8", packages="g++-8", buildtype="boost", image=linuxglobalimage, environment={'B2_TOOLSET': 'gcc-8', 'B2_CXXSTD': '14,17,2a', 'DRONE_JOB_UUID': '1b64538924'}, globalenv=globalenv),
  linux_cxx("COMMENT=codecov.io B2_CXXSTD=03,11 B2_TOOLSET Job 5", "g++-8", packages="g++-8", buildtype="b5847f804b-bbb3de2b00", image=linuxglobalimage, environment={'COMMENT': 'codecov.io', 'B2_CXXSTD': '03,11', 'B2_TOOLSET': 'gcc-8', 'B2_DEFINES': 'define=BOOST_NO_STRESS_TEST=1', 'DRONE_JOB_UUID': 'ac3478d69a'}, globalenv=globalenv),
  linux_cxx("COMMENT=cppcheck Job 6", "g++", packages="binutils-gold gdb libc6-dbg", buildtype="b5847f804b-ed45733e6c", image=linuxglobalimage, environment={'COMMENT': 'cppcheck', 'DRONE_JOB_UUID': 'c1dfd96eea'}, globalenv=globalenv),
  linux_cxx("COMMENT=ubsan B2_VARIANT=variant=debug B2_TOO Job 7", "g++-8", packages="g++-8", buildtype="boost", image=linuxglobalimage, environment={'COMMENT': 'ubsan', 'B2_VARIANT': 'variant=debug', 'B2_TOOLSET': 'gcc-8', 'B2_CXXSTD': '03,11,14,17,2a', 'B2_DEFINES': 'define=BOOST_NO_STRESS_TEST=1', 'B2_CXXFLAGS': 'cxxflags=-fno-omit-frame-pointer cxxflags=-fsanitize=undefined cxxflags=-fno-sanitize-recover=undefined', 'B2_LINKFLAGS': 'linkflags=-fsanitize=undefined linkflags=-fno-sanitize-recover=undefined linkflags=-fuse-ld=gold', 'UBSAN_OPTIONS': 'print_stacktrace=1', 'DRONE_JOB_UUID': '902ba3cda1'}, globalenv=globalenv),
  linux_cxx("COMMENT=Coverity Scan B2_TOOLSET=gcc Job 8", "g++", packages="binutils-gold gdb libc6-dbg", buildtype="b5847f804b-cce9827eb5", image=linuxglobalimage, environment={'COMMENT': 'Coverity Scan', 'B2_TOOLSET': 'gcc', 'DRONE_JOB_UUID': 'fe5dbbcea5'}, globalenv=globalenv),
  ]

# from https://github.com/boostorg/boost-ci
load("@boost_ci//ci/drone/:functions.star", "linux_cxx","windows_cxx","osx_cxx","freebsd_cxx")
