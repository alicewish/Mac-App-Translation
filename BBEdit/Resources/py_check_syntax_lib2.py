"""Wrapper module for py_compile which reformats SyntaxError,
IndentationError and TabError into a format more palatable to BBEdit and
TextWrangler's Python error parsers."""

import py_compile
import sys

__all__ = ['check_syntax']

(major, minor, bugfix) = sys.version_info[0:3]
assert (major == 2 and minor <= 5), "This module is only supported for Python 2.5 or earlier."

try:
    True, False
except NameError:
    # Maintain compatibility with Python 2.2
    True, False = 1, 0
    
def print_reformatted_error(exc_type_name, exc_value):
	"""Print out compile exceptions in the same friendly format that they
	are dumped at runtime when running python with compile errors."""
	msg = exc_value[0]
	file = exc_value[1][0]
	line = exc_value[1][1]
	col = exc_value[1][2]
	ctx = exc_value[1][3]
	if ctx.endswith('\r') or ctx.endswith('\n'):
		ctx = ctx[:-1]
	print >> sys.stderr, '''  File "%s", line %d''' % (file, line)
	print >> sys.stderr, ctx
	print >> sys.stderr, ' ' * col + '^'
	print >> sys.stderr, exc_type_name + ": " + msg

def check_syntax(source_file):
	"""Check syntax on file"""
	try:
		py_compile.compile(source_file, doraise=True)
	except py_compile.PyCompileError, ex:
		(c, v, t) = sys.exc_info()
		exc_names = [IndentationError.__name__, TabError.__name__]
		if v.exc_type_name in exc_names:
			print_reformatted_error(v.exc_type_name, v.exc_value)
		else:
			print >> sys.stderr, v,
		return 1
	return 0
