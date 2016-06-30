"""Wrapper module for py_compile which reformats SyntaxError,
IndentationError and TabError into a format more palatable to BBEdit and
TextWrangler's Python error parsers."""

from __future__ import print_function
from pprint import pprint
import py_compile
import sys

__all__ = ['check_syntax']

(major, minor, bugfix) = sys.version_info[0:3]
assert (major >= 3) or (major == 2 and minor >= 6), "This module is only supported for Python 2.6 or later."

def print_reformatted_error(exc_type_name, exc_value):
	"""Print out compile exceptions in the same friendly format that they
	are dumped at runtime when running python with compile errors.

	We started included SyntaxError in the list of exceptions to be printed
	for Python 2.6 since it stopped being pretty-printed by default. 
	
	This is unecessary, and causes a syntax error, for Python 3.	
	"""
	if isinstance(exc_value, SyntaxError):
		msg = exc_value.msg
		file = exc_value.filename
		line = exc_value.lineno
		col = exc_value.offset
		ctx = exc_value.text
	else:
		msg = exc_value[0]
		file = exc_value[1][0]
		line = exc_value[1][1]
		col = exc_value[1][2]
		ctx = exc_value[1][3]
	if ctx.endswith('\r') or ctx.endswith('\n'):
		ctx = ctx[:-1]
	print('''  File "%s", line %d''' % (file, line), file=sys.stderr)
	print(ctx, file=sys.stderr)
	if col is not None:
		print(' ' * col + '^', file=sys.stderr)
	print(exc_type_name + ": " + msg, file=sys.stderr)

def check_syntax(source_file):
	"""Check syntax on file"""
	try:
		py_compile.compile(source_file, doraise=True)
	except py_compile.PyCompileError as ex:
		(c, v, t) = sys.exc_info()
		exc_names = [SyntaxError.__name__, IndentationError.__name__, TabError.__name__]
		if v.exc_type_name in exc_names:
			print_reformatted_error(v.exc_type_name, v.exc_value)
		else:
			print(v, end=' ', file=sys.stderr)
		return 1
	return 0
