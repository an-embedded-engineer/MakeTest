# Macro Definitions
empty =
space = $(empty) $(empty)

# Command Definitions
RM    = rm -rf
MKDIR = mkdir -p
CAT   = cat
ECHO  = echo
COPY  = cp
MV    = mv
TOUCH = touch
SED   = sed

# Suffix Rule
OBJ_FILE_SUFFIX = o
LIB_FILE_SUFFIX = lib
AST_FILE_SUFFIX = ast
# Delete default Suffixes
.SUFFIXES:
# Definition Suffixes
.SUFFIXES: .c .h .s $(OBJ_FILE_SUFFIX) $(LIB_FILE_SUFFIX) $(AST_FILE_SUFFIX)

# Project Root Path
PROJECT_ROOT := ..

# Target Name
TARGET_NAME = main

# Directory Setting
APP_DIR    = $(PROJECT_ROOT)/app
OS_DIR     = $(PROJECT_ROOT)/os
COMMON_DIR = $(PROJECT_ROOT)/common
OUT_DIR    = $(PROJECT_ROOT)/out
OBJ_DIR    = $(OUT_DIR)/obj
AST_DIR    = $(OUT_DIR)/ast
BIN_DIR    = $(OUT_DIR)/bin

# Common Includes Path Setting
INCLUDES := $(COMMON_DIR)/inc

# Build Target Setting
TARGET = $(BIN_DIR)/$(TARGET_NAME)

# All Include Directory Path
INCLUDE = $(addprefix -I, $(INCLUDES))

# Compile Switch Definitions
CSW_DEF = $(empty)

# Compiler Command
CC = clang
LI = clang

# Compiler Options
CP_OPT        = $(INCLUDE) $(CSW_DEF)
CC_OPT_COMMON = -g -O0 -MMD -MP -c
CC_OPT_WARN   = -Wall -Wextra
CC_OPT        = $(CC_OPT_COMMON) $(CC_OPT_WARN) $(CP_OPT)
CC_OPT_AST    = -emit-ast $(CP_OPT)
LD_OPT        = $(ALL_FILES_TO_LINK)

# Common Ignore Directories for Search Components
IGNORE_DIRS = inc src
# Search All Sub Directories
SUB_DIRS = $(shell find $(CURRENT_DIR) -maxdepth 1 -mindepth 1 -type d)
# Get Component Directories(Search Directories without Ignored Directories)
COMPONENT_DIRS = $(filter-out $(addprefix $(CURRENT_DIR)/,$(IGNORE_DIRS)), $(SUB_DIRS))
# Get All Component Name
COMPONENTS = $(subst $(CURRENT_DIR)/,$(empty),$(COMPONENT_DIRS))

# Ignore Source File Setting
NO_MAKE_SOURCES = $(empty)

# Ignore Directory Setting
NO_MAKE_DIRS = $(empty)

# Ignore Items for Build
NO_MAKE_ITEMS = $(NO_MAKE_DIRS) $(NO_MAKE_SOURCES)

# Search All C Source Files
ALL_C_FILES = $(shell find $(CURRENT_DIR)/src -maxdepth 1 -iname *.c 2> /dev/null)
# Get All C Files for Build
BUILD_C_FILES = $(filter-out $(NO_MAKE_ITEMS), $(ALL_C_FILES))
# Get All Object Files Path
C_OBJ_FILES = $(subst $(PROJECT_ROOT)/,$(OBJ_DIR)/,$(addsuffix .$(OBJ_FILE_SUFFIX),$(basename $(BUILD_C_FILES))))
# Search All S Source Files
ALL_S_FILES = $(shell find $(CURRENT_DIR)/src -maxdepth 1 -iname *.s 2> /dev/null)
# Get All S Files for Build
BUILD_S_FILES = $(filter-out $(NO_MAKE_ITEMS), $(ALL_C_FILES))
# Get All Object Files Path
S_OBJ_FILES = $(subst $(PROJECT_ROOT)/,$(OBJ_DIR)/,$(addsuffix .$(OBJ_FILE_SUFFIX),$(basename $(BUILD_S_FILES))))
# Get All Object Files
OBJ_FILES = $(C_OBJ_FILES) $(S_OBJ_FILES)
# Get All Dependency Files Path
DEP_FILES = $(OBJ_FILES:.o=.d)

# Get All AST Files Path
C_AST_FILES = $(subst $(PROJECT_ROOT)/,$(AST_DIR)/,$(addsuffix .$(AST_FILE_SUFFIX),$(basename $(BUILD_C_FILES))))
# Get All AST Files Path
S_AST_FILES = $(subst $(PROJECT_ROOT)/,$(AST_DIR)/,$(addsuffix .$(AST_FILE_SUFFIX),$(basename $(BUILD_S_FILES))))
# Get All AST Files Path
AST_FILES = $(C_AST_FILES) $(S_AST_FILES)

# Components Make Rule
define MAKE_COMPONENTS_RULE
$(2):
	@$(ECHO) Processing $(2) Directory...
	@$(MAKE) -f $(1)/$(2)/Makefile $(3)
	@$(ECHO) Done.
endef

# Object File from C Files Make Rule
$(OBJ_DIR)/%.o: $(PROJECT_ROOT)/%.c
	@[ -d $(dir $@) ] || $(MKDIR) $(dir $@)
	$(CC) $(CC_OPT) $< -o $@

# Object File from S Files Make Rule
$(OBJ_DIR)/%.o: $(PROJECT_ROOT)/%.s
	@[ -d $(dir $@) ] || $(MKDIR) $(dir $@)
	$(CC) $(CC_OPT) $< -o $@

# AST File from C Files Make Rule
$(AST_DIR)/%.ast: $(PROJECT_ROOT)/%.c
	@[ -d $(dir $@) ] || $(MKDIR) $(dir $@)
	$(CC) $(CC_OPT_AST) $< -o $@

# AST File from S Files Make Rule
$(AST_DIR)/%.ast: $(PROJECT_ROOT)/%.s
	@[ -d $(dir $@) ] || $(MKDIR) $(dir $@)
	$(CC) $(CC_OPT_AST) $< -o $@
