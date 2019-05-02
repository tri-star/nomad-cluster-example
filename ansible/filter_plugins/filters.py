# -- coding: utf-8 --

from ansible import errors

class FilterModule(object):
    def filters(self):
        return {
            'quote_single': lambda v: "'" + v + "'",
            'quote_double': lambda v: '"' + v + '"'
        }