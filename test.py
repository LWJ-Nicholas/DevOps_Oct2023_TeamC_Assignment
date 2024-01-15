import pytest

def test_mytest(capsys):
    with pytest.raises(SystemExit):
        return raise SystemExit(1)
