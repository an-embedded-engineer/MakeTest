# Set Current Directory Path
CURRENT_DIR = ..

# Include Common Makefile
include Common.mk

# Append Ignore Directory for Search Components
IGNORE_DIRS += out make common

# Search All Object Files
ALL_OBJ_FILES = $(shell find $(OBJ_DIR) -iname *.o 2> /dev/null)
ALL_LINK_OBJ_FILES = $(filter-out $(NO_LINK_OBJS), $(ALL_OBJ_FILES))
ALL_FILES_TO_LINK = $(ALL_LINK_OBJ_FILES) $(LIBRARIES_LINK_ONLY) $(OBJECTS_LINK_ONLY)

# Default Make Rule
default:
	@(make all --no-print-directory)

# Phony Make Targets
.PHONY: all rom clean clean_obj

# All Target Make Rule
all: rom

# Full Build Make Rule
full: clean rom

# Only Binary Make Rule
rom: $(TARGET)

# Only AST Nodes Make Rule
ast: $(COMPONENTS)

# Binary File Make Rule
$(TARGET): $(COMPONENTS) $(ALL_FILES_TO_LINK)
	@$(ECHO) ""
	@$(ECHO) Linking $@...
	@[ -d $(dir $@) ] || $(MKDIR) $(dir $@)
	$(LI) $(LD_OPT) -o $@
	@$(ECHO) $@ is Generated.

# Clean Generated Files Make Rule
clean:
	@$(ECHO) Remove All Generated Files...
	@$(RM) $(OUT_DIR)/*

# Clean without Binary Files Make Rule
clean_obj:
	@$(ECHO) Remove All Generated Object Files...
	@$(RM) $(OBJ_DIR)/* $(AST_DIR)/*

# Make Components Object Files
$(foreach component,$(COMPONENTS),$(eval $(call MAKE_COMPONENTS_RULE,$(CURRENT_DIR),$(component),$(MAKECMDGOALS))))
