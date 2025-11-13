#!/usr/bin/env python3
"""
Create a git worktree with dependencies installed and gitignored files copied.
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path


def run_command(cmd, cwd=None, check=True):
    """Run shell command and return output."""
    result = subprocess.run(
        cmd, shell=True, cwd=cwd, capture_output=True, text=True, check=check
    )
    return result.stdout.strip(), result.stderr.strip(), result.returncode


def get_repo_name():
    """Get current git repository name."""
    stdout, _, _ = run_command("basename -s .git $(git config --get remote.origin.url)")
    if not stdout:
        stdout, _, _ = run_command("basename $(git rev-parse --show-toplevel)")
    return stdout


def get_current_branch():
    """Get current git branch name."""
    stdout, _, _ = run_command("git branch --show-current")
    return stdout


def get_default_branch():
    """Get the default branch (main or master)."""
    stdout, _, returncode = run_command("git symbolic-ref refs/remotes/origin/HEAD", check=False)
    if returncode == 0 and stdout:
        return stdout.replace("refs/remotes/origin/", "")

    # Fallback: check if main or master exists
    _, _, returncode = run_command("git rev-parse --verify main", check=False)
    if returncode == 0:
        return "main"

    _, _, returncode = run_command("git rev-parse --verify master", check=False)
    if returncode == 0:
        return "master"

    return None


def get_all_branches():
    """Get all git branches."""
    stdout, _, _ = run_command("git branch --all --format='%(refname:short)'")
    branches = []
    for line in stdout.split("\n"):
        if line and not line.startswith("origin/HEAD"):
            # Remove origin/ prefix for remote branches
            branch = line.replace("origin/", "")
            if branch not in branches:
                branches.append(branch)
    return branches


def select_base_branch(current_branch, default_branch):
    """Let user select base branch using fzf."""
    all_branches = get_all_branches()

    # Sort branches by priority: current, default, then rest
    priority_branches = []
    if current_branch and current_branch in all_branches:
        priority_branches.append(current_branch)
        all_branches.remove(current_branch)

    if default_branch and default_branch in all_branches:
        priority_branches.append(default_branch)
        all_branches.remove(default_branch)

    # Combine: priority branches first, then alphabetically sorted rest
    sorted_branches = priority_branches + sorted(all_branches)
    branches_text = "\n".join(sorted_branches)

    # Use fzf for selection
    try:
        result = subprocess.run(
            ["fzf", "--height", "40%", "--reverse", "--prompt", "Select base branch: "],
            input=branches_text,
            stdout=subprocess.PIPE,
            stderr=None,  # Let fzf use terminal for interactive display
            text=True,
            check=True
        )
        selected = result.stdout.strip()
        if not selected:
            return None
        return selected
    except subprocess.CalledProcessError:
        # User cancelled (Ctrl+C or ESC)
        return None
    except FileNotFoundError:
        # Fallback if fzf is not available: return first priority branch
        if priority_branches:
            return priority_branches[0]
        return sorted_branches[0] if sorted_branches else None


def get_gitignored_files():
    """Get list of gitignored files (excluding node_modules)."""
    stdout, _, _ = run_command("git ls-files --others --ignored --exclude-standard")
    files = []
    for line in stdout.split("\n"):
        if line and "node_modules" not in line.split("/"):
            files.append(line)
    return files


def detect_package_manager():
    """Detect package manager for the project."""
    if Path("package.json").exists():
        if Path("pnpm-lock.yaml").exists():
            return "pnpm"
        elif Path("yarn.lock").exists():
            return "yarn"
        elif Path("package-lock.json").exists():
            return "npm"
        else:
            return "pnpm"  # default for Node projects
    elif Path("pyproject.toml").exists() or Path("requirements.txt").exists():
        return "uv"
    return None


def install_dependencies(worktree_path, package_manager):
    """Install dependencies based on package manager."""
    print(f"Installing dependencies using {package_manager}...")

    if package_manager == "pnpm":
        run_command("pnpm install", cwd=worktree_path)
    elif package_manager == "npm":
        run_command("npm install", cwd=worktree_path)
    elif package_manager == "yarn":
        run_command("yarn install", cwd=worktree_path)
    elif package_manager == "uv":
        run_command("uv sync", cwd=worktree_path, check=False)

    print("Dependencies installed successfully")


def main():
    try:
        # Check if we're in a git repo first
        _, _, returncode = run_command("git rev-parse --git-dir", check=False)
        if returncode != 0:
            print("Error: Not in a git repository")
            sys.exit(1)

        # Get worktree name
        if len(sys.argv) > 1:
            worktree_name = sys.argv[1]
        else:
            worktree_name = input("Enter worktree name: ").strip()
            if not worktree_name:
                print("Error: Worktree name is required")
                sys.exit(1)

        # Get base branch (from argument or prompt)
        if len(sys.argv) > 2:
            base_branch = sys.argv[2]
        else:
            current_branch = get_current_branch()
            default_branch = get_default_branch()

            print(f"Current branch: {current_branch}")
            if default_branch:
                print(f"Default branch: {default_branch}")

            base_branch = select_base_branch(current_branch, default_branch)
            if not base_branch:
                print("\nCancelled")
                sys.exit(0)

            print(f"Selected base branch: {base_branch}")
    except KeyboardInterrupt:
        print("\n\nCancelled")
        sys.exit(0)

    # Get repo info
    repo_name = get_repo_name()
    current_dir = Path.cwd()

    # Create worktree path
    worktree_base = Path.home() / "worktrees" / repo_name
    worktree_path = worktree_base / worktree_name

    # Check if worktree already exists
    if worktree_path.exists():
        print(f"Error: Worktree already exists at {worktree_path}")
        sys.exit(1)

    # Detect package manager before confirmation
    package_manager = detect_package_manager()

    # Show summary and ask for confirmation
    print("\n" + "="*60)
    print("WORKTREE CREATION SUMMARY")
    print("="*60)
    print(f"Worktree name:  {worktree_name}")
    print(f"Base branch:    {base_branch}")
    print(f"Location:       {worktree_path}")
    print(f"Repository:     {repo_name}")
    if package_manager:
        print(f"Package mgr:    {package_manager} (will install dependencies)")
    else:
        print(f"Package mgr:    None detected")
    print("="*60)

    try:
        confirm = input("\nProceed with worktree creation? [Y/n]: ").strip().lower()
        if confirm and confirm not in ['y', 'yes']:
            print("Cancelled")
            sys.exit(0)
    except KeyboardInterrupt:
        print("\n\nCancelled")
        sys.exit(0)

    # Create worktrees directory if it doesn't exist
    worktree_base.mkdir(parents=True, exist_ok=True)

    # Create worktree
    print(f"\nCreating worktree '{worktree_name}' from '{base_branch}' at {worktree_path}...")
    run_command(f"git worktree add {worktree_path} -b {worktree_name} {base_branch}")

    # Get gitignored files before copying
    gitignored_files = get_gitignored_files()

    # Copy gitignored files (except node_modules)
    if gitignored_files:
        print(f"Copying {len(gitignored_files)} gitignored files...")
        for file_path in gitignored_files:
            src = current_dir / file_path
            dst = worktree_path / file_path

            if src.is_file():
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src, dst)
                print(f"  Copied: {file_path}")

    # Install dependencies (already detected before confirmation)
    if package_manager:
        install_dependencies(worktree_path, package_manager)
    else:
        print("No package manager detected, skipping dependency installation")

    print(f"\n✓ Worktree created successfully at: {worktree_path}")
    print(f"  cd {worktree_path}")


if __name__ == "__main__":
    main()
