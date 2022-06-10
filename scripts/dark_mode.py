import subprocess
from os import path


def is_dark_mode() -> bool:
    """Return the current Dark Mode status"""
    result = subprocess.run(
        ["defaults", "read", "-g", "AppleInterfaceStyle"],
        text=True,
        capture_output=True,
    )
    return result.returncode == 0 and result.stdout.strip() == "Dark"


OSASCRIPT = """
tell application "System Events"
    tell appearance preferences
        set dark mode to {mode}
    end tell
end tell
"""

KITTY_THEMES = {
    "dark": "Gruvbox Dark",
    "light": "Github",
}


def set_interface_style(dark: bool):
    """Enable/disable dark mode."""
    mode = "true" if dark else "false"  # mode can be {true, false, not dark}
    theme = "dark" if dark else "light"
    script = OSASCRIPT.format(mode=mode)
    result = subprocess.run(
        ["osascript", "-e", script],
        text=True,
        capture_output=True,
    )
    # pure evil ahead
    regex = f's/COLORSCHEME=\\K".*"/"{theme}"/'
    zshrc_path = path.join(path.expanduser("~"), ".zshrc")

    subprocess.run(["perl", "-i", "-p", "-e", regex, zshrc_path])
    subprocess.run(
        ["kitty", "+kitten", "themes", "--reload-in=all", KITTY_THEMES[theme]]
    )
    subprocess.run(["nvr", "-c", f"let colorscheme='{theme}'"])
    subprocess.run(["nvr", "-c", 'lua require("lvim.config"):reload()'])

    assert result.returncode == 0, result


if __name__ == "__main__":
    set_interface_style(not is_dark_mode())
