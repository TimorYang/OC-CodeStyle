import re

__all__ = ['add_break_line_after_root_braces']


def _add_break_line_after_root_braces(m):
    text = m.group()
    if text.find('*/') >= 0:
        return text
    return text.replace('}', '}\n', 1)


def add_break_line_after_root_braces(full_text):
    # print(full_text)
    rst = re.sub(r'\n}\n.+', _add_break_line_after_root_braces, full_text)
    return rst
