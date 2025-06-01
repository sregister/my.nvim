#!/bin/bash

# Neovim Setup Script
# This script installs the latest stable Neovim and sets up custom configuration
# Usage: curl -fsSL https://your-url.com/setup-nvim.sh | bash

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_status() {
    echo -e "${GREEN}[*]${NC} $1"
}

print_error() {
    echo -e "${RED}[!]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Detect OS and architecture
detect_system() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)
    
    case "$ARCH" in
        x86_64|amd64)
            ARCH="x64"
            ;;
        aarch64|arm64)
            ARCH="arm64"
            ;;
        *)
            print_error "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac
    
    if [[ "$OS" != "linux" ]]; then
        print_error "This script only supports Linux"
        exit 1
    fi
}

# Install Neovim
install_neovim() {
    print_status "Installing Neovim..."
    
    # Check if we should skip installation
    if [ -f "$HOME/.local/bin/nvim" ]; then
        INSTALLED_VERSION=$("$HOME/.local/bin/nvim" --version 2>/dev/null | head -n1 || echo "unknown")
        print_status "Neovim already installed at ~/.local/bin/nvim: $INSTALLED_VERSION"
        
        read -p "Do you want to reinstall/update Neovim? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Skipping Neovim installation"
            return 0
        fi
    fi
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download latest stable release
    print_status "Downloading latest stable Neovim..."
    
    # Determine the correct filename based on architecture
    if [[ "$ARCH" == "x64" ]]; then
        FILENAME="nvim-linux-x86_64.tar.gz"
    elif [[ "$ARCH" == "arm64" ]]; then
        FILENAME="nvim-linux-arm64.tar.gz"
    else
        print_error "Unsupported architecture for Neovim download"
        exit 1
    fi
    
    DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/$FILENAME"
    
    if ! command -v curl &> /dev/null; then
        print_error "curl is required but not installed. Please install curl first."
        exit 1
    fi
    
    print_status "Downloading $FILENAME..."
    curl -LO "$DOWNLOAD_URL" || {
        print_error "Failed to download Neovim"
        exit 1
    }
    
    # Extract
    print_status "Extracting Neovim..."
    tar -xzf "$FILENAME"
    
    # Install to user's local directory
    LOCAL_BIN="$HOME/.local/bin"
    mkdir -p "$LOCAL_BIN"
    
    # Copy Neovim files
    print_status "Installing Neovim to $HOME/.local..."
    cp -rf nvim-linux*/* "$HOME/.local/"
    
    # Clean up
    cd - > /dev/null
    rm -rf "$TEMP_DIR"
    
    print_status "Neovim installed successfully!"
}

# Setup bashrc aliases
setup_bashrc() {
    print_status "Setting up bash aliases..."
    
    BASHRC="$HOME/.bashrc"
    
    # Check if our configuration is already in .bashrc
    if [ -f "$BASHRC" ] && grep -q "# Neovim configuration (added by nvim-setup script)" "$BASHRC"; then
        print_status "Bash configuration already set up, skipping..."
        return 0
    fi
    
    # Create backup of .bashrc
    if [ -f "$BASHRC" ]; then
        cp "$BASHRC" "$BASHRC.backup.$(date +%Y%m%d_%H%M%S)"
        print_status "Created backup of .bashrc"
    fi
    
    # Add Neovim configuration to .bashrc
    cat >> "$BASHRC" << 'EOF'

# Neovim configuration (added by nvim-setup script)
# Add ~/.local/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Check if nvim exists and set up aliases
if command -v nvim &> /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
fi
EOF
    
    print_status "Bash configuration updated"
}

# Clone Neovim configuration
clone_config() {
    print_status "Setting up custom Neovim configuration..."
    
    CONFIG_DIR="$HOME/.config/nvim"
    
    # Check if configuration already exists
    if [ -d "$CONFIG_DIR" ]; then
        # Check if it's the correct repository
        if [ -d "$CONFIG_DIR/.git" ]; then
            cd "$CONFIG_DIR"
            REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
            cd - > /dev/null
            
            if [[ "$REMOTE_URL" == *"github.com/sregister/my.nvim"* ]]; then
                print_status "Correct configuration already installed at $CONFIG_DIR"
                read -p "Do you want to update it? (y/N) " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    cd "$CONFIG_DIR"
                    print_status "Updating configuration..."
                    git pull || print_warning "Failed to update configuration"
                    cd - > /dev/null
                fi
                return 0
            fi
        fi
        
        # Different or non-git configuration exists
        BACKUP_DIR="$CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        print_warning "Existing configuration backed up to $BACKUP_DIR"
    fi
    
    # Clone the configuration
    git clone https://github.com/sregister/my.nvim "$CONFIG_DIR" || {
        print_error "Failed to clone configuration repository"
        exit 1
    }
    
    print_status "Custom configuration installed successfully!"
}

# Check for required dependencies
check_dependencies() {
    print_status "Checking for required dependencies..."
    
    local missing_deps=()
    
    # Check for C compiler
    if ! command -v cc &> /dev/null && ! command -v gcc &> /dev/null && ! command -v clang &> /dev/null; then
        missing_deps+=("C compiler (gcc/clang)")
    else
        local compiler=""
        if command -v gcc &> /dev/null; then
            compiler="gcc $(gcc --version | head -n1)"
        elif command -v clang &> /dev/null; then
            compiler="clang $(clang --version | head -n1)"
        elif command -v cc &> /dev/null; then
            compiler="cc"
        fi
        print_status "Found C compiler: $compiler"
    fi
    
    # Check for make
    if ! command -v make &> /dev/null; then
        missing_deps+=("make")
    else
        print_status "Found make"
    fi
    
    # Check for git (required for plugin management)
    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    else
        print_status "Found git"
    fi
    
    # Check for curl (required for downloading)
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    else
        print_status "Found curl"
    fi
    
    # Check for common tools that plugins might need
    local optional_tools=("node" "npm" "python3" "pip3" "cargo" "go" "cmake" "unzip" "clangd")
    local found_optional=()
    
    for tool in "${optional_tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            found_optional+=("$tool")
        fi
    done
    
    if [ ${#found_optional[@]} -gt 0 ]; then
        print_status "Found optional tools: ${found_optional[*]}"
    fi
    
    # Report missing dependencies
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        echo
        print_warning "Please install the missing dependencies before continuing."
        print_warning "On Ubuntu/Debian: sudo apt-get install build-essential git curl"
        print_warning "On Fedora/RHEL: sudo dnf install gcc make git curl"
        print_warning "On Arch: sudo pacman -S base-devel git curl"
        echo
        read -p "Do you want to continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 1
        fi
    else
        print_status "All required dependencies are installed"
    fi
    
    # Warn about optional dependencies
    local missing_optional=()
    for tool in "${optional_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_optional+=("$tool")
        fi
    done
    
    if [ ${#missing_optional[@]} -gt 0 ]; then
        print_warning "Some optional tools are not installed: ${missing_optional[*]}"
        print_warning "These may be needed by certain Neovim plugins"
    fi
}

# Main execution
main() {
    echo "========================================="
    echo "       Neovim Setup Script"
    echo "========================================="
    echo
    
    # Detect system
    detect_system
    
    # Check dependencies
    check_dependencies
    
    # Check if Neovim is already installed
    if command -v nvim &> /dev/null; then
        CURRENT_VERSION=$(nvim --version | head -n1)
        print_warning "Neovim is already installed: $CURRENT_VERSION"
        read -p "Do you want to continue with the installation? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
    fi
    
    # Install Neovim
    install_neovim
    
    # Setup bashrc
    setup_bashrc
    
    # Clone configuration
    clone_config
    
    echo
    echo "========================================="
    echo -e "${GREEN}Installation complete!${NC}"
    echo "========================================="
    echo
    echo "Please run the following command to reload your shell:"
    echo "  source ~/.bashrc"
    echo
    echo "Or start a new terminal session to use Neovim."
    echo
    print_status "You can now use 'nvim', 'vim', or 'vi' to start Neovim"
    
    # Check for missing optional packages and provide install commands
    local missing_optional=()
    local optional_check=("node" "npm" "python3" "pip3" "cargo" "go" "cmake" "unzip" "clangd")
    
    for tool in "${optional_check[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_optional+=("$tool")
        fi
    done
    
    if [ ${#missing_optional[@]} -gt 0 ]; then
        echo
        echo "========================================="
        echo -e "${YELLOW}Optional Packages for Neovim Plugins${NC}"
        echo "========================================="
        echo
        print_warning "Some optional packages are not installed: ${missing_optional[*]}"
        echo
        echo "To ensure all Neovim plugins work correctly, install these packages:"
        echo
        echo "For Ubuntu/Debian:"
        echo -e "${GREEN}sudo apt update && sudo apt install -y nodejs npm python3 python3-pip cmake unzip clangd${NC}"
        echo
        echo "For Rocky/RHEL/Fedora:"
        echo -e "${GREEN}sudo dnf install -y nodejs npm python3 python3-pip cmake unzip clang-tools-extra${NC}"
        echo
        echo "For Rust support (all distros):"
        echo -e "${GREEN}curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh${NC}"
        echo
        echo "For Go support (all distros), visit: https://golang.org/dl/"
        echo
    fi
}

# Run main function
main
