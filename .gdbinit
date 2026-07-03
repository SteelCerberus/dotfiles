set disassembly-flavor intel
set print pretty on
set debuginfod enabled on
set follow-fork-mode child

# Update GDB's Python paths with the `sys.path` values of the local
# Python installation, whether that is system Python or a venv
python
import os,subprocess,sys
# Execute a Python using the user's shell and pull out the sys.path (for site-packages)
paths = subprocess.check_output('python -c "import os,sys;print(os.linesep.join(sys.path).strip())"',shell=True).decode("utf-8").split()
# Extend GDB's Python's search path
sys.path.extend(paths)
end

# This is a script to make it easier to convert the addresses in Ghidra
# to addresses usable by gdb. On the first time running the binary,
# the user needs to find the start of the .text section in Ghidra,
# then call "gset-ghidra-text" (e.g., if .text starts at 001011c0 in Ghidra,
# then run "gset-ghidra-text 001011c0").
#
# Then breakpoints can be set with "gbreak" using the Ghidra addresses like
# "gbreak 001014e9". The gset-ghidra-text command is cached on disk,
# so it only needs to be done one time per binary.
source ~/.scripts/ghidra_sync.py

