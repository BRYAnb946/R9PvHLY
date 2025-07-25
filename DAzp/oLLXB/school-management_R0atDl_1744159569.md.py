"""Django's command-line utility for administrative tasks."""
import os
import sys


    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'schoolmanagement.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
    execute_from_command_line(sys.argv)
    main()