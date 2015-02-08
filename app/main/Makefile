# Set Current Directory
CURRENT_DIR = $(PROJECT_ROOT)/app/main

# Include Common Make File
include Common.mk

# Append Referable Include Directories
INCLUDES += $(APP_DIR)/inc
INCLUDES += $(CURRENT_DIR)/inc

# Phony Make Target Definition
.PHONY: all full rom ast rm_opt

# All Target Make Rule
all: ast rom

# Full Target Make Rule
full: ast rom

# Binary Make Rule
rom: rm_opt $(CC_OPT_FILE) $(OBJ_FILES)
	@$(ECHO) $(CURRENT_DIR) Build Finished.

# AST Nodes Make Rule
ast: $(AST_FILES)
	@$(ECHO) $(CURRENT_DIR) Build Finished.

# Remove CC Option File Make Rule
rm_opt:
	@$(RM) $(CC_OPT_FILE)

# Include Dependency Files
ifneq "$(MAKECMDGOALS)" "clean"
-include $(DEP_FILES)
endif
