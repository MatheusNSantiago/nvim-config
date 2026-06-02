#!/usr/bin/env python3
"""
Test that our Lua source splitting matches nbformat's behavior.

Run with: uv run python tests/test_source_splitting.py

This script generates expected outputs from nbformat, which are then
used by the Lua test to verify our implementation.
"""

import json
import sys
import tempfile
import os

import nbformat


def get_nbformat_source_lines(source: str) -> list[str]:
    """Get what nbformat writes for a given source string."""
    nb = nbformat.v4.new_notebook()
    nb.cells.append(nbformat.v4.new_code_cell(source))

    with tempfile.NamedTemporaryFile(mode='w', suffix='.ipynb', delete=False) as f:
        nbformat.write(nb, f)
        tmp_path = f.name

    try:
        with open(tmp_path) as f:
            raw = json.load(f)
        return raw['cells'][0]['source']
    finally:
        os.unlink(tmp_path)


# Test cases: (name, source_string)
TEST_CASES = [
    ('empty', ''),
    ('single_line', 'x = 1'),
    ('single_line_trailing_newline', 'x = 1\n'),
    ('multi_line', 'x = 1\ny = 2'),
    ('multi_line_trailing_newline', 'x = 1\ny = 2\n'),
    ('three_lines', 'a\nb\nc'),
    ('three_lines_trailing', 'a\nb\nc\n'),
    ('blank_line_middle', 'a\n\nb'),
    ('only_newline', '\n'),
    ('multiple_newlines', '\n\n'),
    ('unicode_emoji', '🎉 = "party"'),
    ('unicode_japanese', 'x = "日本語"'),
]


def main():
    """Generate expected outputs from nbformat and print as JSON."""
    results = {}
    for name, source in TEST_CASES:
        results[name] = {
            'source': source,
            'expected': get_nbformat_source_lines(source),
        }

    # Print JSON for Lua test to consume
    print(json.dumps(results, indent=2, ensure_ascii=False))
    return 0


if __name__ == '__main__':
    sys.exit(main())
