# Building Aseprite EXE Application - Workflow Guide

This guide explains how to use the GitHub Actions workflows to build Aseprite Windows executable applications.

## Available Workflows

### 1. Build Windows EXE (`build-exe.yml`)
**Purpose**: Automatically builds Windows EXE on push, pull request, or release events.

**Triggers**:
- Push to `main` or `develop` branches
- Pull requests to `main` branch
- Published releases
- Manual trigger (`workflow_dispatch`)

**Features**:
- Builds `aseprite.exe` with full GUI support (Skia backend)
- Packages executable with data files
- Uploads artifacts for download
- Automatically attaches to GitHub releases

### 2. Build EXE Application (`build-app-exe.yml`)
**Purpose**: Manual build workflow with customizable options.

**Triggers**:
- Manual trigger only (`workflow_dispatch`)

**Options**:
- **Build Type**: Choose from `RelWithDebInfo`, `Release`, or `Debug`
- **Upload Artifacts**: Enable/disable artifact upload

**Features**:
- Uses the automated build script (`build.sh`)
- Flexible build configuration
- Detailed build summary
- Optional artifact upload

### 3. Create Release with EXE (`release-exe.yml`)
**Purpose**: Creates GitHub releases with packaged Windows executables.

**Triggers**:
- Git tags starting with `v*` (e.g., `v1.2.3`)
- Manual trigger with custom tag and release name

**Features**:
- Creates official GitHub releases
- Packages executable with all required files
- Uploads ZIP file as release asset
- Generates release notes automatically

## How to Use

### Quick Build
1. Go to **Actions** tab in your repository
2. Select **"Build EXE Application"** workflow
3. Click **"Run workflow"**
4. Choose build type and options
5. Download the built executable from the artifacts

### Create a Release
**Option 1: Using Git Tags**
```bash
git tag v1.0.0
git push origin v1.0.0
```

**Option 2: Manual Release**
1. Go to **Actions** tab
2. Select **"Create Release with EXE"** workflow
3. Click **"Run workflow"**
4. Enter tag name and release details
5. The release will be created automatically

### Development Builds
For development and testing:
1. Push changes to `main` or `develop` branch
2. The **"Build Windows EXE"** workflow will trigger automatically
3. Download artifacts from the workflow run

## Build Output

All workflows produce the following files:
- `aseprite.exe` - The main application executable
- `data/` - Required application data directory
- `README.md` - Project documentation
- `EULA.txt` - End User License Agreement
- `AUTHORS.md` - Contributors list
- `BUILD_INFO.txt` or `RELEASE_INFO.txt` - Build/release information

## System Requirements

**For Building**:
- Windows runner (automatically provided by GitHub Actions)
- MSVC compiler
- Ninja build system
- CMake
- Skia graphics library (automatically downloaded)

**For Running** (end users):
- Windows 10 or later
- x64 architecture

## File Locations

After building, the executable can be found at:
- Primary location: `build/bin/aseprite.exe`
- Alternative locations depend on the build script configuration

## Troubleshooting

### Build Fails
1. Check if all submodules are properly initialized
2. Verify Skia download completed successfully
3. Ensure MSVC compiler is available
4. Check CMake configuration output for errors

### Executable Not Found
The workflow will automatically search for the executable in common locations. If not found, check:
1. Build completed successfully
2. CMake configured with `ENABLE_ASEPRITE_EXE=ON`
3. No compilation errors occurred

### Release Upload Fails
Ensure:
1. Repository has appropriate permissions for creating releases
2. Tag name follows semantic versioning (e.g., `v1.0.0`)
3. `GITHUB_TOKEN` has sufficient permissions

## Customization

You can modify the workflows by:
1. Changing build types or CMake options
2. Adding additional packaging steps
3. Modifying artifact retention periods
4. Customizing release notes templates

## Support

For issues with the workflows:
1. Check the workflow run logs
2. Verify all prerequisites are met
3. Ensure repository permissions are correct
4. Check for any CMake or build configuration issues