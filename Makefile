gen:
	flutter pub run build_runner build --delete-conflicting-outputs

gen-watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: gen gen-watch
