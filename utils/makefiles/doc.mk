
# ==============================
##@ 📚 Documentation
# ==============================

# Godot
URL_GODOT	:= https://docs.godotengine.org/en/stable/index.html

doc: ## Show documentation links
	@clear
	@echo "Select documentation subject:"
	@echo "\n$(ORANGE)Godot$(RESET)"
	@echo "  0. Godot Documentation"

	@read url_choice; \
	case $$url_choice in \
		0) CHOICE=$(URL_GODOT);; \
		*) $(call ERROR,Invalid choice:,$$CHOICE, Exiting.); exit 1;; \
	esac; \
	$(OPEN) $$CHOICE
	@clear
	@$(call INFO,,Opening documentation...)

.PHONY: doc
