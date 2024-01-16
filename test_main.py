import pytest

def test_mytest():
    with pytest.raises(SystemExit) as pytest_wrapped_e:
        raise SystemExit(1)
        assert pytest_wrapped_e.type == SystemExit
        assert pytest_wrapped_e.value.code == 42
