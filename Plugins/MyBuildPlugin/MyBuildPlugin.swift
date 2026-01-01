import Foundation
import PackagePlugin

@main
struct MyBuildPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let inputFile = context.package.directory.appending(subpath: "MyClass.swift")
        let outputFile = context.pluginWorkDirectory.appending(subpath: "MyClass.generated.swift")
        
        guard FileManager.default.fileExists(atPath: inputFile.string) else {
            Diagnostics.error("❌ Input files not found: '\(inputFile)'")
            return []
        }
        
        return [
            createBuildCommand(
                "MyPlugin",
                executable: try context.tool(named: "MyPluginExecutable").path,
                inputPath: inputFile,
                outputPath: outputFile
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension MyBuildPlugin: XcodeBuildToolPlugin {

    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        let inputFile = context.xcodeProject.directory.appending(subpath: "MyClass.swift")
        let outputFile = context.pluginWorkDirectory.appending(subpath: "MyClass.generated.swift")
        
        guard FileManager.default.fileExists(atPath: inputFile.string) else {
            Diagnostics.error("❌ Input files not found: '\(inputFile)'")
            return []
        }
        
        return [
            createBuildCommand(
                "MyPlugin",
                executable: try context.tool(named: "MyPluginExecutable").path,
                inputPath: inputFile,
                outputPath: outputFile
            )
        ]
    }
}
#endif

func createBuildCommand(_ name: String, executable: Path, inputPath: Path, outputPath: Path) -> Command {
    .buildCommand(
        displayName: name,
        executable: executable,
        arguments: ["-i", inputPath.string, "-o", outputPath.string],
        inputFiles: [inputPath],
        outputFiles: [outputPath]
    )
}
