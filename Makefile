
# Project Info
NAME		:= BrunchPolice
AUTHOR		:= cdumais
TEAM		:= $(AUTHOR)
REPO_LINK	:= https://github.com/SaydRomey/BrunchPolice

# Compiler and Flags
COMPILE	:= c++
C_FLAGS	:= -Wall -Werror -Wextra -std=c++98 -pedantic

# Source code files
SRC_DIR		:= src
SRCS		:= $(shell find $(SRC_DIR) -name "*.cpp")

# Object files
OBJ_DIR		:= obj
OBJS		:= $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Header files (including .ipp)
INC_DIR		:= inc
HEADERS		:= $(shell find $(INC_DIR) -name "*.hpp" -o -name "*.ipp" -name "*.tpp")
INCLUDES	:= $(addprefix -I, $(shell find $(INC_DIR) -type d))

# BUILD_DIR	:= build


# Helper Makefiles
MK_PATH	:= utils/makefiles

# Imports for Utility Macros and Additional `make` Targets
include $(MK_PATH)/utils.mk		# Utility Variables and Macros
include $(MK_PATH)/doc.mk		# Documentation Targets
include $(MK_PATH)/class.mk		# CPP Class Creator
include $(MK_PATH)/scripts.mk	# Scripts Management
include $(MK_PATH)/misc.mk		# Miscellaneous Utilities

# Default Target
.DEFAULT_GOAL	:= all

.DEFAULT:
	$(info make: *** No rule to make target '$(MAKECMDGOALS)'.  Stop.)
	@$(MAKE) help $(NPD)

# ==============================
##@ 🛠  Utility
# ==============================

help: ## Display available targets
	@echo "\nAvailable targets:"
	@awk 'BEGIN {FS = ":.*##";} \
		/^[a-zA-Z_0-9-]+:.*?##/ { \
			printf "   $(CYAN)%-15s$(RESET) %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)

repo: ## Open the GitHub repository
	@$(call INFO,$(NAME),Opening $(AUTHOR)'s github repo...)
	@open $(REPO_LINK);

.PHONY: help repo

# ==============================
##@ 🎯 Main Targets
# ==============================

all: $(NAME) ## Build the project

$(NAME): $(OBJS)
	@$(COMPILE) $(C_FLAGS) $(OBJS) $(INCLUDES) -o $@
	@$(call SUCCESS,$@,Build complete)
	@$(MAKE) title $(NPD)

# Object compilation rules
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS)
	@mkdir -p $(@D)
	@$(call INFO,$(NAME),$(ORANGE)Compiling...\t,$(CYAN)$(notdir $<))
	@$(COMPILE) $(C_FLAGS) $(INCLUDES) -c $< -o $@
	@$(call UPCUT)

run: all ## Compile and run the executable with default arguments
	@./$(NAME)

.PHONY: all re

# ==============================
##@ 🧹 Cleanup
# ==============================

clean: ## Remove object files
	@$(call CLEANUP,$(NAME),object files,$(OBJ_DIR))

fclean: clean ## Remove executable
	@$(call CLEANUP,$(NAME),executable,$(NAME))

ffclean: fclean ## Remove all generated files and folders

re: fclean all ## Rebuild everything

.PHONY: clean fclean ffclean re
