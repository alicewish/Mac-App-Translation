"""Wrapper script for py_compile which reformats SyntaxError,
IndentationError and TabError into a format more palatable to BBEdit and
TextWrangler's Python error parsers."""

import os
import sys

__all__ = ['main']

def fix_path():
	self_path = sys.argv[0];
	self_parent = os.path.dirname(self_path)
	if not self_parent in sys.path:
		sys.path.insert(0, self_parent)

def main():
	"""Check syntax on the file passed in sys.argv[1]"""
	source_file = sys.argv[1]
	fix_path()
	(major, minor, bugfix) = sys.version_info[0:3]
	if (major >= 3) or (major >= 2 and minor >= 6):
		import py_check_syntax_lib
		rc = py_check_syntax_lib.check_syntax(source_file)
	else:
		import py_check_syntax_lib2
		rc = py_check_syntax_lib2.check_syntax(source_file)
	sys.exit(rc)

if __name__ == "__main__":
	main()
