# EXE Build Workflows - Quick Start

This directory now contains comprehensive GitHub Actions workflows for building Aseprite Windows EXE applications.

## 🚀 Quick Start

### Option 1: Manual Build (Recommended for first time)
1. Go to the **Actions** tab in your GitHub repository
2. Select **"Build EXE Application"** workflow  
3. Click **"Run workflow"**
4. Choose build type (RelWithDebInfo recommended)
5. Enable artifact upload
6. Click **"Run workflow"** button
7. Wait for completion and download the EXE from artifacts

### Option 2: Automatic Build
- Push changes to `main` or `develop` branch
- Workflow automatically triggers and builds EXE
- Download artifacts from the workflow run

### Option 3: Create Release
```bash
git tag v1.0.0
git push origin v1.0.0
```
- Creates a GitHub release automatically
- EXE is packaged and attached as ZIP file

## 📁 What You Get

After building, you'll receive a packaged directory containing:
- `aseprite.exe` - The main application executable  
- `data/` - Required application data files
- `README.md`, `EULA.txt`, `AUTHORS.md` - Documentation
- `BUILD_INFO.txt` - Build information and metadata

## 🛠️ Workflows Included

| Workflow | Purpose | Trigger |
|----------|---------|---------|
| `build-exe.yml` | Automatic EXE builds | Push/PR/Release |
| `build-app-exe.yml` | Manual EXE builds | Manual only |
| `release-exe.yml` | Create releases with EXE | Git tags/Manual |

## 🔧 Technical Details

- **Platform**: Windows (windows-latest runner)
- **Compiler**: MSVC (Visual Studio 2022)
- **Build System**: CMake + Ninja
- **Graphics**: Skia backend (automatically downloaded)
- **Scripting**: Lua support enabled
- **Build Type**: Release/RelWithDebInfo/Debug

## 📚 Full Documentation

See `docs/BUILDING_EXE_WORKFLOWS.md` for complete documentation including:
- Detailed usage instructions
- Troubleshooting guide
- Customization options
- System requirements

## ✅ Validation

Run the validation script to check everything is set up correctly:
```bash
./validate-workflows.sh
```

## 🎯 Next Steps

1. Test the "Build EXE Application" workflow
2. Verify the built EXE works correctly
3. Customize workflows if needed
4. Create your first release with git tags

---
*Implementation by GitHub Copilot for building Aseprite EXE applications*