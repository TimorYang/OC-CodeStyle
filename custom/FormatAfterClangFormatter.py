# # LiteralSymbolSpacer.py
#
# If a filename is specified as a parameter, it will change that file in place.
# If input is provided through stdin, it will send the result to stdout.
# Copyright 2015 Square, Inc

from Category import *
from BreakLines import *

from AbstractCustomFormatter import AbstractCustomFormatter


class FormatAfterClangFormatter(AbstractCustomFormatter):
    def format_lines(self, lines):
        full_text = ''.join(lines)
        rst = remove_category_define_blank(full_text)
        rst = add_break_line_after_root_braces(rst)
        # print(rst)

        return rst


if __name__ == "__main__":
    FormatAfterClangFormatter().run()
