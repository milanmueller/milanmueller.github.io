# justfile for milanmueller.de

# List available recipes
default:
    @just --list

# Start local development server with live reload
serve:
    zola serve

# Build the site (output to public/)
build:
    zola build

# Check links and validate site without rendering
check:
    zola check

# Spell check content
spell:
    codebook check
