"""
Developer Kit Cross-Platform Library

This module provides cross-platform utilities for the Developer Kit plugin,
enabling consistent behavior across Windows, macOS, and Linux.
"""

from .platform_utils import (
    PlatformInfo,
    CommandRunner,
    FileUtils,
    HookIO,
)

__all__ = [
    "PlatformInfo",
    "CommandRunner",
    "FileUtils",
    "HookIO",
]

__version__ = "1.0.0"
