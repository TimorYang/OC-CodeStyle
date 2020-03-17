# # LiteralSymbolSpacer.py
#
# If a filename is specified as a parameter, it will change that file in place.
# If input is provided through stdin, it will send the result to stdout.
# Copyright 2015 Square, Inc

from Dictionary import pre_format_dict

from AbstractCustomFormatter import AbstractCustomFormatter


class PrepareFormatter(AbstractCustomFormatter):
    def format_lines(self, lines):
        full = ''.join(lines)
        rst = pre_format_dict(full)

        # print(rst)

        return rst


if __name__ == "__main__":
    PrepareFormatter().run()
