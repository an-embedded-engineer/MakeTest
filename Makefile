# Temp Directory
TMP_DIR = ./out/tmp

# FIFO for Output Log Files
FIFO_STDOUT = $(TMP_DIR)/p_stdout
FIFO_STDERR = $(TMP_DIR)/p_stderr
FIFO_OUT = $(FIFO_STDOUT) $(FIFO_STDERR)

# Build Log Files
BUILD_LOG_FILE = Build_Log.txt
BUILD_ERR_FILE = Build_Error.txt
LOG_FILES = $(BUILD_LOG_FILE) $(BUILD_ERR_FILE)

# Default Make Rule
default:
	@(make all --no-print-directory)

# Phony Make Target
.PHONY: all rom ast clean clean_obj help

# All Target Make Rule
all:
	@[ -d $(TMP_DIR) ] || mkdir -p $(TMP_DIR)
	@rm -rf $(FIFO_OUT)
	@mkfifo $(FIFO_OUT)
	@tee $(BUILD_LOG_FILE) < $(FIFO_STDOUT) &
	@tee $(BUILD_ERR_FILE) < $(FIFO_STDERR) &
	@-(make -C ./make/ --no-print-directory) 1>$(FIFO_STDOUT) 2>$(FIFO_STDERR)
	@rm -rf $(TMP_DIR)

# Full Build Make Rule
full:
	@[ -d $(TMP_DIR) ] || mkdir -p $(TMP_DIR)
	@rm -rf $(FIFO_OUT)
	@mkfifo $(FIFO_OUT)
	@tee $(BUILD_LOG_FILE) < $(FIFO_STDOUT) &
	@tee $(BUILD_ERR_FILE) < $(FIFO_STDERR) &
	@-(make full -C ./make/ --no-print-directory) 1>$(FIFO_STDOUT) 2>$(FIFO_STDERR)
	@rm -rf $(TMP_DIR)

# Binary Make Rule
rom:
	@[ -d $(TMP_DIR) ] || mkdir -p $(TMP_DIR)
	@rm -rf $(FIFO_OUT)
	@mkfifo $(FIFO_OUT)
	@tee $(BUILD_LOG_FILE) < $(FIFO_STDOUT) &
	@tee $(BUILD_ERR_FILE) < $(FIFO_STDERR) &
	@-(make rom -C ./make/ --no-print-directory) 1>$(FIFO_STDOUT) 2>$(FIFO_STDERR)
	@rm -rf $(TMP_DIR)

# AST Nodes Make Rule
ast:
	@[ -d $(TMP_DIR) ] || mkdir -p $(TMP_DIR)
	@rm -rf $(FIFO_OUT)
	@mkfifo $(FIFO_OUT)
	@tee $(BUILD_LOG_FILE) < $(FIFO_STDOUT) &
	@tee $(BUILD_ERR_FILE) < $(FIFO_STDERR) &
	@-(make ast -C ./make/ --no-print-directory) 1>$(FIFO_STDOUT) 2>$(FIFO_STDERR)
	@rm -rf $(TMP_DIR)

# Clean Make Rule
clean:
	@(make clean -C ./make/ --no-print-directory)
	@rm -rf $(LOG_FILES)
	@rm -rf $(TMP_DIR)

# Clean without Binary Files Make Rule
clean_obj:
	@(make clean_obj -C ./make/ --no-print-directory)
	@rm -rf $(LOG_FILES)
	@rm -rf $(TMP_DIR)

# Help Message
help:
	@echo "Make Options:"
	@echo "    make           : Default Make Rule(Same as [make all])"
	@echo "    make all       : Build Binary and AST Nodes (Re-Compile only updated files)"
	@echo "    make full      : Build Binary and AST Nodes (Re-Compile all files)"
	@echo "    make rom       : Build Binary (Re-Compile only updated files)"
	@echo "    make ast       : Build AST Nodes"
	@echo "    make clean     : Clean all generated files"
	@echo "    make clean_obj : Clean all generated files without Binary"
