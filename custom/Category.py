import re

__all__ = ['remove_category_define_blank']


def _remove_category_define_blank(m):
    text = m.group()
    return re.sub(r' +\(', "(", text)


def remove_category_define_blank(full_text):
    rst = re.sub(r'@interface +[a-zA-Z0-9_]+ \(', _remove_category_define_blank, full_text)
    return rst
