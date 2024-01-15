import pytest

def test_mytest():
    with pytest.raises(SystemExit):
        return raise SystemExit(1)
