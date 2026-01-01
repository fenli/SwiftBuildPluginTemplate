# SwiftBuildPluginTemplate
> Template repository for creating new SPM / Xcode build plugins project

[![](https://img.shields.io/github/v/release/fenli/SwiftBuildPluginTemplate?style=flat&label=Latest%20Release&color=blue)](https://github.com/fenli/SwiftBuildPluginTemplate/releases)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffenli%2FSwiftBuildPluginTemplate%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/fenli/SwiftBuildPluginTemplate)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffenli%2FSwiftBuildPluginTemplate%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/fenli/SwiftBuildPluginTemplate)
[![](https://img.shields.io/github/license/fenli/SwiftBuildPluginTemplate?style=flat)](https://github.com/fenli/SwiftBuildPluginTemplate/blob/main/LICENSE)

## How to install
### SPM
Add this configuration to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/MyGithubUser/MyPlugin", from: "0.1.0"),
],
```

Then add the plugins to your target:
```swift
.target(
    name: "MyProjectPackage",
    plugins: [
        .plugin(name: "MyPlugin", package: "MyPlugin")
    ]
)
```

### XCode
Integration into Xcode project:
- In Xcode root project, navigate to your targets list in side bar.
- Select target to integrate (usually app or library target).
- Go to Build Phase -> Run Build Tool Plug-ins -> Add the plugin

### Build on CI
If you are building on CI server, you have to add this as the xcodebuild command arguments to bypass xcode validation:
```
-skipPackagePluginValidation
-skipMacroValidation
```
Or if you are building on Xcode Cloud, you can disable it by adding this to `ci_scripts/ci_post_clone.sh`:
```sh
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
```
