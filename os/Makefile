# Set Current Directory
CURRENT_DIR = $(PROJECT_ROOT)/os

# Include Common Make File
include Common.mk

# Append Ignore Directory for Search Components
#IGNORE_DIRS += 

# Phony Make Target Definition
.PHONY: all full rom ast

# All Target Make Rule
all: ast rom

# Full Target Make Rule
full: ast rom

# Binary Make Rule
rom: $(COMPONENTS)
	@$(ECHO) $(CURRENT_DIR) Build Finished.

# AST Nodes Make Rule
ast: $(COMPONENTS)
	@$(ECHO) $(CURRENT_DIR) Build Finished.

# Make Components Object Files
$(foreach component,$(COMPONENTS),$(eval $(call MAKE_COMPONENTS_RULE,$(CURRENT_DIR),$(component),$(MAKECMDGOALS))))
