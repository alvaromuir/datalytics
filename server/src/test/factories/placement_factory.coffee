# Placement factory

moment = require 'moment'

module.exports =
    'Month': moment().format('YYYY-MM')
    'Campaign': 'Test Campaign ' + moment().format('YYYY')
    'Site (DFA)': 'Test Publisher'
    'Placement': 'Test Placement | 300x250'
    'Placement Group': 'Test Placement Group | 300x250'
    'Placement Tactic': 'Test Placement Tactic'
    'DMP Segment': 'Test DMP Segment'
    'Impressions': 999999
    'Clicks': 12345
    'CT TV LQS': 1234
    'VT TV LQS': 5678
    'Internet Orders': 654
    'TV Orders': 321
    'Internet AM CT Conversions': 9
    'Internet AM CT Conversions': 8
    'Internet NC CT Conversions': 7
    'Internet NC TV Conversions': 6
    'TV AM CT Conversions': 5
    'TV AM VT Conversions': 4
    'TV NC CT Conversions': 3
    'TV NC VT Conversions': 2
