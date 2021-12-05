PLATFORM_IOS = iOS Simulator,name=iPhone 11
PLATFORM_MACOS = macOS
PLATFORM_TVOS = tvOS Simulator,name=Apple TV 4K (at 1080p)

default: test

test:
	xcodebuild test \
		-scheme ArrowView-Package \
		-destination platform="$(PLATFORM_IOS)" \
		-enableCodeCoverage YES ENABLE_TESTING_SEARCH_PATHS=YES

coverage: export XCTEST_PATH := $(shell find ~/Library/Developer/Xcode/DerivedData -name 'ArrowView-*' -prune)
coverage:
	xcrun llvm-cov report \
		${XCTEST_PATH}/Build/Products/Debug-iphonesimulator/ArrowView.framework/ArrowView \
		-instr-profile ${XCTEST_PATH}/Build/ProfileData/*/Coverage.profdata > cov.txt
	tail -1 cov.txt | cut -f 10 -w > percentage.txt
	echo "PERCENTAGE=$$(< percentage.txt)" >> $$GITHUB_ENV

.PHONY: test coverage
