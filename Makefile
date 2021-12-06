PLATFORM_IOS = iOS Simulator,name=iPhone 11
PLATFORM_MACOS = macOS
PLATFORM_TVOS = tvOS Simulator,name=Apple TV 4K (at 1080p)

default: test

test:
	xcodebuild test \
		-scheme ArrowView-Package \
		-destination platform="$(PLATFORM_IOS)" \
		-enableCodeCoverage YES ENABLE_TESTING_SEARCH_PATHS=YES

# Extract coverage info for ArrowView.swift -- expects defintion of env variable GITHUB_ENV
PROJECT = ArrowView
coverage:
	@-rm -f cov.txt percentage.txt
	@for XCTEST_PATH in $$(find $${HOME}/Library/Developer/Xcode/DerivedData -name '$(PROJECT)-*' -prune); do \
		echo "-- checking $${XCTEST_PATH}"; \
		OBJ="$${XCTEST_PATH}/Build/Products/Debug-iphonesimulator/$(PROJECT).framework/${PROJECT}"; \
		set -- $${XCTEST_PATH}/Build/ProfileData/*/Coverage.profdata; \
		if [[ -f "$${1}" && -f "$${OBJ}" ]]; then \
			echo "-- generaing coverage from $${1}"; \
			xcrun llvm-cov report "$${OBJ}" -instr-profile "$${1}" > cov.txt; \
		fi; \
	done; \
	[[ -f cov.txt ]] || { echo "** no coverage report found"; exit 1; \\; }
	@tail -1 cov.txt | awk '{ print $$10; }' > percentage.txt
	@echo "-- PERCENTAGE=$$(< percentage.txt)"
	@if [[ -n "$$GITHUB_ENV" ]]; then \
		echo "PERCENTAGE=$$(< percentage.txt)" >> $$GITHUB_ENV; \
	fi

.PHONY: test coverage
