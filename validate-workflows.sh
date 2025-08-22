#!/bin/bash

# Workflow validation script
echo "🔍 Validating EXE build workflows..."
echo ""

WORKFLOWS_DIR=".github/workflows"
EXIT_CODE=0

# Check if workflow directory exists
if [ ! -d "$WORKFLOWS_DIR" ]; then
    echo "❌ Workflows directory not found: $WORKFLOWS_DIR"
    exit 1
fi

# List of our new workflow files
WORKFLOWS=(
    "build-exe.yml"
    "build-app-exe.yml"
    "release-exe.yml"
)

echo "📋 Checking workflow files..."
for workflow in "${WORKFLOWS[@]}"; do
    file_path="$WORKFLOWS_DIR/$workflow"
    if [ -f "$file_path" ]; then
        echo "✅ Found: $workflow"
        
        # Check for required sections
        if grep -q "name:" "$file_path" && grep -q "on:" "$file_path" && grep -q "jobs:" "$file_path"; then
            echo "   ✓ Has required sections (name, on, jobs)"
        else
            echo "   ❌ Missing required sections"
            EXIT_CODE=1
        fi
        
        # Check for Windows runner
        if grep -q "runs-on: windows-latest" "$file_path"; then
            echo "   ✓ Uses Windows runner"
        else
            echo "   ⚠️  Does not use Windows runner"
        fi
        
        # Check for MSVC setup
        if grep -q "ilammy/msvc-dev-cmd" "$file_path"; then
            echo "   ✓ Sets up MSVC compiler"
        else
            echo "   ⚠️  Missing MSVC setup"
        fi
        
    else
        echo "❌ Missing: $workflow"
        EXIT_CODE=1
    fi
    echo ""
done

# Check documentation
DOC_FILE="docs/BUILDING_EXE_WORKFLOWS.md"
if [ -f "$DOC_FILE" ]; then
    echo "✅ Documentation found: $DOC_FILE"
    if grep -q "Build Windows EXE" "$DOC_FILE" && grep -q "workflow_dispatch" "$DOC_FILE"; then
        echo "   ✓ Contains expected content"
    else
        echo "   ⚠️  May be missing some content"
    fi
else
    echo "❌ Missing documentation: $DOC_FILE"
    EXIT_CODE=1
fi

echo ""
echo "🧪 Testing YAML syntax..."
if command -v python3 >/dev/null 2>&1; then
    for workflow in "${WORKFLOWS[@]}"; do
        file_path="$WORKFLOWS_DIR/$workflow"
        if [ -f "$file_path" ]; then
            if python3 -c "import yaml; yaml.safe_load(open('$file_path'))" 2>/dev/null; then
                echo "✅ $workflow: Valid YAML"
            else
                echo "❌ $workflow: Invalid YAML"
                EXIT_CODE=1
            fi
        fi
    done
else
    echo "⚠️  Python3 not available, skipping YAML validation"
fi

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ All workflow validations passed!"
    echo ""
    echo "🎉 Ready to build EXE applications!"
    echo "   • Use 'Build EXE Application' workflow for manual builds"
    echo "   • Push to main/develop for automatic builds"
    echo "   • Create git tags for releases"
else
    echo "❌ Some validations failed. Please review and fix issues."
fi

exit $EXIT_CODE