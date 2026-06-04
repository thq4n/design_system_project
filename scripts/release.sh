#!/bin/bash

# Release Script for Design System Project
# Usage: ./scripts/release.sh [version] [message]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if version is provided
if [ -z "$1" ]; then
    print_error "Version is required!"
    echo "Usage: ./scripts/release.sh [version] [message]"
    echo "Example: ./scripts/release.sh 1.1.0 'Add new button variants'"
    exit 1
fi

VERSION=$1
MESSAGE=${2:-"Release v$VERSION"}

print_status "Starting release process for version $VERSION..."

# Check if we're on master branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "master" ]; then
    print_warning "You're not on master branch. Current branch: $CURRENT_BRANCH"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Release cancelled."
        exit 1
    fi
fi

# Check if working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    print_error "Working directory is not clean. Please commit or stash your changes."
    git status --short
    exit 1
fi

print_status "1. Running code analysis..."
flutter analyze

print_status "2. Running tests..."
flutter test

print_status "3. Generating assets..."
fvm dart run build_runner build

print_status "4. Updating version in pubspec.yaml..."
# Update version in pubspec.yaml
sed -i '' "s/version: [0-9]*\.[0-9]*\.[0-9]*+[0-9]*/version: $VERSION+$(($(echo $VERSION | cut -d. -f4 2>/dev/null || echo 1) + 1))/" pubspec.yaml

print_status "5. Updating version in example/pubspec.yaml..."
# Update version in example/pubspec.yaml
sed -i '' "s/version: [0-9]*\.[0-9]*\.[0-9]*+[0-9]*/version: $VERSION+$(($(echo $VERSION | cut -d. -f4 2>/dev/null || echo 1) + 1))/" example/pubspec.yaml

print_status "6. Testing catalog app..."
flutter run -t lib/catalog/main.dart --no-sound-null-safety &
CATALOG_PID=$!
sleep 10
kill $CATALOG_PID 2>/dev/null || true

print_status "7. Testing storybook app..."
flutter run -t lib/stories/main.dart --no-sound-null-safety &
STORYBOOK_PID=$!
sleep 10
kill $STORYBOOK_PID 2>/dev/null || true

print_status "8. Testing example app..."
flutter run -t example/lib/main.dart --no-sound-null-safety &
EXAMPLE_PID=$!
sleep 10
kill $EXAMPLE_PID 2>/dev/null || true

print_status "9. Committing changes..."
git add .
git commit -m "chore: prepare for release v$VERSION

$MESSAGE"

print_status "10. Creating tag..."
git tag -a "v$VERSION" -m "Release v$VERSION

$MESSAGE"

print_status "11. Pushing to remote..."
git push origin master
git push origin "v$VERSION"

print_success "Release v$VERSION completed successfully!"

print_status "Next steps:"
echo "1. Create GitHub Release with release notes"
echo "2. Update CHANGELOG.md with release date"
echo "3. Notify team about the new release"
echo "4. Update documentation if needed"

print_success "🎉 Release process completed!" 