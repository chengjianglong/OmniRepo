#!/bin/bash
# Builds a universal (Apple silicon + Intel) OmniRepo.app and packages it as dist/OmniRepo-<version>.dmg
# for anyone to download. It is ad-hoc signed (no Developer ID), so on first launch macOS asks the user to
# allow it in System Settings › Privacy & Security, or to right-click › Open.
set -euo pipefail
cd "$(dirname "$0")/.."
export CLANG_MODULE_CACHE_PATH="$PWD/.build/clang-cache"
export SWIFTPM_MODULECACHE_OVERRIDE="$PWD/.build/swift-cache"
VERSION="${1:-0.1.0}"
STAGE="$PWD/.build/dmg"
APP="$STAGE/OmniRepo.app"
rm -rf "$STAGE" && mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

swift build --disable-sandbox -c release --arch arm64 --arch x86_64 -debug-info-format none
BIN="$(swift build -c release --arch arm64 --arch x86_64 --show-bin-path)"
cp "$BIN/OmniRepo" "$BIN/omnirepo-mcp" "$APP/Contents/MacOS/"
cp Resources/AppIcon.icns Resources/mermaid.min.js "$APP/Contents/Resources/"
cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>OmniRepo</string>
<key>CFBundleDisplayName</key><string>OmniRepo</string>
<key>CFBundleIdentifier</key><string>local.repolens.app</string>
<key>CFBundleExecutable</key><string>OmniRepo</string>
<key>CFBundleIconFile</key><string>AppIcon</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>$VERSION</string>
<key>CFBundleVersion</key><string>$VERSION</string>
<key>LSMinimumSystemVersion</key><string>14.0</string>
<key>LSApplicationCategoryType</key><string>public.app-category.developer-tools</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
# Ad-hoc signature: runs on any Mac once allowed, and carries no personal certificate details.
codesign --force --sign - "$APP/Contents/MacOS/omnirepo-mcp"
codesign --force --sign - "$APP"
ln -s /Applications "$STAGE/Applications"

mkdir -p dist
DMG="dist/OmniRepo-$VERSION.dmg"
rm -f "$DMG"
hdiutil create -volname "OmniRepo $VERSION" -srcfolder "$STAGE" -fs HFS+ -format UDZO -ov "$DMG" >/dev/null
shasum -a 256 "$DMG"
lipo -archs "$APP/Contents/MacOS/OmniRepo"
