#
# "main" pseudo-component makefile.
#
# (Uses default behaviour of compiling all source files in directory, adding 'include' to include path.)

COMPONENT_ADD_LDFLAGS=-lstdc++ -l$(COMPONENT_NAME)
COMPONENT_SRCDIRS= . source ../../Utilities
COMPONENT_ADD_INCLUDEDIRS= source ../../Utilities

