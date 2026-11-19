#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
export CLANG_MODULE_CACHE_PATH="$PWD/.build/clang-cache"
export SWIFTPM_MODULECACHE_OVERRIDE="$PWD/.build/swift-cache"
swift build --disable-sandbox -c release -debug-info-format none
APP="$PWD/dist/OmniRepo.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp Resources/AppIcon.icns "$APP/Contents/Resources/AppIcon.icns"
cp Resources/mermaid.min.js "$APP/Contents/Resources/mermaid.min.js"   # Mermaid 11.4.1 (MIT), draws ```mermaid diagrams
cp .build/release/OmniRepo "$APP/Contents/MacOS/OmniRepo"
cp .build/release/omnirepo-mcp "$APP/Contents/MacOS/omnirepo-mcp"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>OmniRepo</string>
<key>CFBundleDisplayName</key><string>OmniRepo</string>
<key>CFBundleIdentifier</key><string>local.repolens.app</string>
<key>CFBundleExecutable</key><string>OmniRepo</string>
<key>CFBundleIconFile</key><string>AppIcon</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSMinimumSystemVersion</key><string>14.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
# Sign with the Apple Development certificate when there is one: its identity stays the same across
# rebuilds, so macOS doesn't ask again for Keychain access (API keys, pairing code) after each build.
IDENTITY="${OMNIREPO_SIGN_IDENTITY:-$(security find-identity -v -p codesigning 2>/dev/null | awk '/Apple Development/ {print $2; exit}')}"
if [ -n "$IDENTITY" ]; then
  for helper in "$APP"/Contents/MacOS/*; do
    [ "$helper" = "$APP/Contents/MacOS/OmniRepo" ] || codesign --force --sign "$IDENTITY" "$helper"
  done
  codesign --force --sign "$IDENTITY" "$APP"
else
  codesign --force --sign - "$APP"
fi
printf 'Built %s\n' "$APP"
