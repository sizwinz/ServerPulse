import pytest
from typing import Optional, Union, Any

# Mock discord classes
class Member:
    mention = "@member"
class TextChannel:
    mention = "#text-channel"
class VoiceChannel:
    mention = "#voice-channel"
class CategoryChannel:
    mention = "#category-channel"
class Guild:
    pass

import sys
from unittest.mock import MagicMock

# Create a mock discord module
discord_mock = MagicMock()
discord_mock.Member = Member
discord_mock.TextChannel = TextChannel
discord_mock.VoiceChannel = VoiceChannel
discord_mock.CategoryChannel = CategoryChannel
discord_mock.Guild = Guild
sys.modules['discord'] = discord_mock

from src.utils.helpers import create_progress_bar

def test_create_progress_bar_zero():
    """Test progress bar at 0%."""
    result = create_progress_bar(0, length=20)
    assert result == "░" * 20 + " 0.0%"

def test_create_progress_bar_half():
    """Test progress bar at 50%."""
    result = create_progress_bar(50, length=20)
    assert result == "█" * 10 + "░" * 10 + " 50.0%"

def test_create_progress_bar_full():
    """Test progress bar at 100%."""
    result = create_progress_bar(100, length=20)
    assert result == "█" * 20 + " 100.0%"

def test_create_progress_bar_custom_length():
    """Test progress bar with custom length."""
    result = create_progress_bar(50, length=10)
    assert result == "█" * 5 + "░" * 5 + " 50.0%"

def test_create_progress_bar_fractional():
    """Test progress bar with fractional percentage."""
    # 10 * 33.3 / 100 = 3.33 -> int(3.33) = 3
    result = create_progress_bar(33.3, length=10)
    assert result == "█" * 3 + "░" * 7 + " 33.3%"

def test_create_progress_bar_rounding():
    """Test progress bar rounding behavior."""
    # 10 * 39.9 / 100 = 3.99 -> int(3.99) = 3
    result = create_progress_bar(39.9, length=10)
    assert result == "█" * 3 + "░" * 7 + " 39.9%"

def test_create_progress_bar_over_100():
    """Test progress bar with percentage > 100."""
    # current implementation: filled = int(20 * 150 / 100) = 30
    # bar = '█' * 30 + '░' * (20 - 30) = '█' * 30
    result = create_progress_bar(150, length=20)
    assert result.startswith("█" * 30)
    assert "150.0%" in result

def test_create_progress_bar_negative():
    """Test progress bar with negative percentage."""
    # filled = int(20 * -10 / 100) = -2
    # bar = '█' * -2 + '░' * (20 - (-2)) = '' + '░' * 22
    result = create_progress_bar(-10, length=20)
    assert result.startswith("░" * 22)
    assert "-10.0%" in result
