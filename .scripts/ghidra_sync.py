import gdb
import re
import json
from pathlib import Path

# Setup the persistent cache file using pathlib
CACHE_FILE = Path.home() / ".cache" / "gdb" / "gdb_ghidra_cache.json"

def load_cache():
    if CACHE_FILE.exists():
        try:
            with CACHE_FILE.open("r") as f:
                return json.load(f)
        except Exception:
            pass
    return {}

def save_cache(cache):
    try:
        # Create the ~/.cache/gdb directory if it doesn't exist
        CACHE_FILE.parent.mkdir(parents=True, exist_ok=True)
        with CACHE_FILE.open("w") as f:
            json.dump(cache, f, indent=4)
    except Exception as e:
        print(f"[GhidraSync] Warning: Could not save cache file: {e}")

def get_current_binary():
    """Returns the absolute path of the currently loaded executable as a string."""
    progspace = gdb.current_progspace()
    if progspace and progspace.filename:
        # Resolve to get the clean absolute path
        return str(Path(progspace.filename).resolve())
    return None


class SetGhidraText(gdb.Command):
    """Manually set or update the Ghidra .text start address for the current binary.
    Usage: gset-ghidra-text <address>
    Example: gset-ghidra-text 1011c0
    """
    def __init__(self):
        super(SetGhidraText, self).__init__("gset-ghidra-text", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        binary_path = get_current_binary()
        if not binary_path:
            print("Error: No binary loaded in GDB. Load a file first.")
            return

        binary_name = Path(binary_path).name

        if not arg:
            cache = load_cache()
            current = cache.get(binary_path)
            print("Usage: gset-ghidra-text <address>")
            if current:
                print(f"Current setting for {binary_name}: {hex(current)}")
            return

        try:
            # Force hex interpretation even if '0x' prefix is missing
            cleaned_arg = arg.strip()
            if not cleaned_arg.lower().startswith("0x"):
                cleaned_arg = "0x" + cleaned_arg
            
            addr = int(cleaned_arg, 16)
            
            cache = load_cache()
            cache[binary_path] = addr
            save_cache(cache)
            
            print(f"[GhidraSync] Associated {binary_name} with Ghidra .text: {hex(addr)}")
        except ValueError:
            print("Invalid hex address format.")


class GhidraBreak(gdb.Command):
    """Set a breakpoint using a Ghidra address (assumed to be hex).
    Usage: gbreak <ghidra_address>
    Example: gbreak 1023a0
    """
    def __init__(self):
        super(GhidraBreak, self).__init__("gbreak", gdb.COMMAND_BREAKPOINTS)

    def invoke(self, arg, from_tty):
        binary_path = get_current_binary()
        if not binary_path:
            print("Error: No binary loaded in GDB.")
            return

        if not arg:
            print("Usage: gbreak <ghidra_address>")
            return

        binary_name = Path(binary_path).name

        # 1. Look up the Ghidra address in the persistent cache
        cache = load_cache()
        ghidra_text_start = cache.get(binary_path)

        if ghidra_text_start is None:
            print(f"Error: No Ghidra base address known for '{binary_name}'.")
            print("Please set it once using: gset-ghidra-text <address>")
            return

        # 2. Parse user's target address (Enforce HEX assumption)
        try:
            cleaned_arg = arg.strip()
            if not cleaned_arg.lower().startswith("0x"):
                cleaned_arg = "0x" + cleaned_arg
            ghidra_addr = int(cleaned_arg, 16)
        except ValueError:
            print("Invalid hex address.")
            return

        # 3. Grab runtime info from GDB
        try:
            info_files = gdb.execute("info files", to_string=True)
        except gdb.error as e:
            print(f"Error getting target info: {e}. Is the program running?")
            return

        match = re.search(r'(0x[0-9a-fA-F]+)\s*-\s*0x[0-9a-fA-F]+\s*is\s*\.text', info_files)
        if not match:
            print("Could not find runtime .text segment. Ensure the program has started (try 'starti').")
            return

        runtime_text_start = int(match.group(1), 16)

        # 4. Math and Break
        offset = runtime_text_start - ghidra_text_start
        runtime_target = ghidra_addr + offset

        print(f"[GhidraSync] Ghidra Addr:  {hex(ghidra_addr)}")
        print(f"[GhidraSync] Runtime Base: {hex(runtime_text_start)}")
        print(f"[GhidraSync] Calculated:   {hex(runtime_target)}")

        gdb.execute(f"break *{hex(runtime_target)}")

# Register commands
SetGhidraText()
GhidraBreak()
